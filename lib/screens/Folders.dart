import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/Language.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/models/Translation.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/screens/EditObject.dart';
import 'package:lucas/screens/SettingScreen.dart';
import 'package:lucas/widgets/ObjectGrid.dart';
import 'package:lucas/widgets/WOnboard.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:flutter_swiper/flutter_swiper.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class Folders extends StatefulWidget {
  String currentLevel = '1';
  Folders(this.currentLevel, {Key key}) : super(key: key);

  @override
  _FoldersState createState() {
    SharedPreferences.getInstance().then((prefs) {
      // bool darkMode = prefs.getBool('darkMode') ?? true;
      String languageCode = prefs.getString('languageCode') ?? "en";
      return _FoldersState(
        // darkMode,
        this.currentLevel,
        languageCode,
      );
    });

    return _FoldersState(
      this.currentLevel,
      'en',
    );
  }
}

class _FoldersState extends State<Folders> {
  List<String> translationItems = [
    'Drag and drop enabled',
    'Drag and drop disabled',
  ];

  //List<MObject> gridObjects;
  bool isLoading = false;
  //int currentFolderId = -1;
  //final String hint = "";
  List<MFolder> folders;
  //bool darkMode = true;
  String languageCode;
  // List<Choice> choices = List<Choice>();
  //Choice _selectedChoice;
  // double _columns = 6;
  // double _rows = 6;
  // String _strColumns = '';
  // String _strRows = '';
  //String _strClose = '';
  // String _strUnlock = '';
  // String _strLock = '';
  // String _strEdit = '';
  String _strSelectDefaultFolder = '';
  //bool _showFolderInstructions = true;
  // MFolder _selectedFolder;
  // MImage _selectedImage;
  MFolder currentFolder;
  MFolder parentFolder;
  List<MObject> mObjects = <MObject>[];
  String currentLevel = '1';

  Map<String, String> helpScreenTranslations = Map<String, String>();
  bool canShowHelpScreens = false;
  bool isLargeScreen = false;
  bool canDrag = null;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, String> translations = Map<String, String>();

  _FoldersState(
    //bool darkMode,
    String currentLevel,
    String languageCode,
  ) {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }

    //this.darkMode = darkMode;
    this.currentLevel = currentLevel;
    this.languageCode = languageCode;
  }

  @override
  void initState() {
    initialize().then((result) {
      setState(() {});
    });

    L.item('select folder').then((str) {
      setState(() {
        _strSelectDefaultFolder = str;
      });
    });

    loadHelpScreensTranslationTexts().then((result) {
      setState(() {
        canShowHelpScreens = true;
      });
    });

    super.initState();
  }

  Future<void> initialize() async {
    Map<String, String> result = await L.getItems(translationItems);

    setState(() {
      translations = result;
    });
  }

  Future<void> loadHelpScreensTranslationTexts() async {
    List<String> helpScreenTranslationsItems = [
      'showHelper_folders_title1',
      'showHelper_folders_title2',
      'showHelper_folders_title3',
      'showHelper_folders_title4',
      'showHelper_folders_title5',
      'showHelper_folders_text1',
      'showHelper_folders_text2',
      'showHelper_folders_text3',
      'showHelper_folders_text4',
      'showHelper_folders_text5',
    ];

    for (int i = 0; i < helpScreenTranslationsItems.length; i++) {
      helpScreenTranslations[helpScreenTranslationsItems[i]] = '';
    }

    Map<String, String> result = await L.getItems(helpScreenTranslationsItems);

    if (mounted) {
      setState(() {
        helpScreenTranslations = result;
      });
    }
  }

  Widget showHelperScreens() {
    if (!canShowHelpScreens) return Container();

    List<String> images = [
      "assets/onboarding/folders-1.png",
      "assets/onboarding/folders-2.png",
      "assets/onboarding/folders-3.png",
      "assets/onboarding/folders-4.png",
      "assets/onboarding/folders-5.png",
    ];

    List<String> titles = [
      helpScreenTranslations['showHelper_folders_title1'],
      helpScreenTranslations['showHelper_folders_title2'],
      helpScreenTranslations['showHelper_folders_title3'],
      helpScreenTranslations['showHelper_folders_title4'],
      helpScreenTranslations['showHelper_folders_title5'],
    ];

    List<String> texts = [
      helpScreenTranslations['showHelper_folders_text1'],
      helpScreenTranslations['showHelper_folders_text2'],
      helpScreenTranslations['showHelper_folders_text3'],
      helpScreenTranslations['showHelper_folders_text4'],
      helpScreenTranslations['showHelper_folders_text5'],
    ];

    return WOnboard(images, titles, texts, StateProperties.showHelperFolders,
        onOnBoardBtnAccept);
  }

  onOnBoardBtnAccept(dynamic a) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (translations == null || translations.isEmpty) return Container();

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, properties: [
      StateProperties.selectedImage,
      StateProperties.selectedVideo,
      StateProperties.selectedSound,
      StateProperties.selectedFolder,
      StateProperties.selectedEmpty,
      StateProperties.currentFolder,
      StateProperties.showHelperFolders,
      StateProperties.gridObjects,
      StateProperties.canDrag
    ]).value;

    canDrag = lucasState.getObject(StateProperties.canDrag) ?? false;

    // return PropertyChangeConsumer<LucasState>(
    //     properties: [
    //       StateProperties.selectedImage,
    //       StateProperties.selectedVideo,
    //       StateProperties.selectedSound,
    //       StateProperties.selectedFolder,
    //       StateProperties.currentFolder,
    //       StateProperties.showHelperFolders,
    //     ],
    //     builder: (context, model, property) {
    //       final lucasState =
    //           PropertyChangeProvider.of<LucasState>(context, listen: false)
    //               .value;

    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }

    if (helpScreenTranslations == null || helpScreenTranslations.isEmpty)
      return Container();

    if ((lucasState.getObject(StateProperties.showHelperFolders) ?? '') !=
        "false") {
      return showHelperScreens();
    }

      //lucasState.saveObject(StateProperties.currentFolder, currentFolder);}

    //currentFolder = lucasState.getObject(StateProperties.currentFolder);
   // if (currentFolder != null && currentFolder.id == -1)
      //currentFolder.isVisible = 1;

    // if (currentFolder==null) {
    //   currentFolder = MFolder.getByID(-1);
    // }

    parentFolder = lucasState.getObject(StateProperties.parentFolder);
    // _columns = lucasState.getGridColumns().toDouble();
    // _rows = lucasState.getGridRows().toDouble();

    Widget grid = ObjectGrid(
      '1',
      _onItemTap,
      _onItemDoubleTap,
      _onItemLongPress,
      _onRefresh,
    );

    String selectObjectTextToShow = '';
    //MEmpty _selectedEmpty;
    //_selectedEmpty = lucasState.getObject(StateProperties.selectedEmpty);
    // if (_selectedEmpty != null)
    //   selectObjectTextToShow = _selectedEmpty.textToShow;

    MFolder _selectedFolder;
    _selectedFolder = lucasState.getObject(StateProperties.selectedFolder);
    if (_selectedFolder != null)
      selectObjectTextToShow = _selectedFolder.textToShow;

    MImage _selectedImage;
    _selectedImage = lucasState.getObject(StateProperties.selectedImage);
    if (_selectedImage != null)
      selectObjectTextToShow = _selectedImage.textToShow;

    MVideo _selectedVideo;
    _selectedVideo = lucasState.getObject(StateProperties.selectedVideo);
    if (_selectedVideo != null)
      selectObjectTextToShow = _selectedVideo.textToShow;

    MSound _selectedSound;
    _selectedSound = lucasState.getObject(StateProperties.selectedSound);
    if (_selectedSound != null)
      selectObjectTextToShow = _selectedSound.textToShow;

    bool isObjectSelected = _selectedFolder != null ||
        _selectedImage != null ||
        _selectedVideo != null ||
        _selectedSound != null;
    Widget folderPathWidget = buildFolderPath(isObjectSelected);

    Widget backToParentButton = getBackToParentButton();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              folderPathWidget,
              isObjectSelected
                  ? Text(
                      selectObjectTextToShow,
                    )
                  : Container(),
              // Text(
              //   'Folder path',
              //   style: TextStyle(fontSize: 14.0),
              // ),
              // buildAppTitle(),
            ],
          ),
          //buildFolderDropDown(currentFolder.folderId.toString(), items),
          //L.getAppBarLocalizedText("folders"),
          actions: <Widget>[
            //isObjectSelected ? buttonEdit() : Container(),
            backToParentButton,
            // overflow menu
            // PopupMenuButton<Choice>(
            //   onSelected: (Choice selectedChoice) {
            //     _popMenuButtonOnSelected(context, selectedChoice);
            //   },
            //   itemBuilder: (BuildContext context) {
            //     return choices.skip(1).map((Choice choice) {
            //       return PopupMenuItem<Choice>(
            //           value: choice,
            //           child: Row(children: <Widget>[
            //             Icon(choice.icon),
            //             L.getText(choice.title),
            //           ]));
            //     }).toList();
            //   },
            // ),
            // Helper.debugMode
            //     ?
            // IconButton(
            //     icon: Icon(
            //       Icons.refresh,
            //       color: Colors.white,
            //     ),
            //     onPressed: () async {
            //       setState(() {
            //         isLoading = true;
            //       });

            //       await MFolder.loadFromAssets();
            //       await MRelation.loadFromAssets();

            //       // refresh screen
            //       currentFolder = await MFolder.getByID(-1);
            //       lucasState.saveObject(
            //           'currentFolder', currentFolder);

            //       setState(() {
            //         isLoading = false;
            //       });
            //     },
            //   ),
            //: Container(),
            Helper.debugMode
                ? IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await showFolderAndRelationsInfo();
                    },
                  )
                : Container(),
            btnAddNew(),
            //btnGridSize(),
            btnDragEnable(),
            btnHelp(),
            // TextButton(
            //   child: Icon(
            //     Icons.add_circle_outline,
            //     color: Colors.white,
            //   ),
            //   onPressed: () async {
            //     showAddDialog();
            //   },
            // )
          ],
        ),
        /*body: ConstrainedBox(
            child: new Swiper(
              itemBuilder: (c, ind) {
                return new Wrap(
                  runSpacing: 10,
                  children: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,25,27,28,29,30,31,32].map((i){
                    return new SizedBox(
                      width: MediaQuery.of(context).size.width/6,
                      child: new Column(

                        children: <Widget>[
                          new SizedBox(
                            child:  new Container(
                              child: grid,
                            ),
                            height: MediaQuery.of(context).size.width * 0.16,

                          ),
                          //new Padding(padding: new EdgeInsets.only(top:10),child: new Text("$ind"),)
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
              pagination: new SwiperPagination(),
              itemCount: 10,
            ),
            constraints:new BoxConstraints.loose(new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height))
        ),*/
        body: WillPopScope(
          onWillPop: handleBackButton,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              isLoading
                  ? Container(
                height: Helper.LinearProgressIndicatorHeight,
                child: LinearProgressIndicator(
                  value: null,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  backgroundColor: Colors.white,
                ),
              )
                  : Container(),
              //generalInstructions(),
              //gridSizeSelector(),
              // folderToolbar(),
              // imageToolbar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buttonSelectDefaultFolder(),
                ],
              ),
              Expanded(
                child: grid,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationOptions(),
      ),
    );
    //});
  }


  Widget btnHelp() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    return IconButton(
      icon: Icon(
        Icons.help,
        color: Colors.white,
      ),
      onPressed: () async {
        String showHelpStatus =
            lucasState.getObject(StateProperties.showHelperFolders) ?? '';
        setState(() {
          if (showHelpStatus == '')
            lucasState.saveObject(StateProperties.showHelperFolders, 'false');
          else
            lucasState.saveObject(StateProperties.showHelperFolders, '');
        });
      },
    );
  }

  Widget btnGridSize() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int currentGridColumns = lucasState.getGridColumns();

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: IconButton(
            icon: Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
            onPressed: () async {
              int gridColumns = lucasState.getGridColumns();

              gridColumns++;
              if (gridColumns > 15) gridColumns = 4;

              //currentFolder = lucasState.getObject(StateProperties.currentFolder);
              currentFolder =
                  lucasState.getObject(StateProperties.currentFolder);
              List<MObject> objects = await MRelation.getObjectsInFolder(
                  gridColumns, currentFolder.id);
              await lucasState.saveObject(StateProperties.gridObjects, objects);

              setState(() {
                lucasState.setGridColumns(gridColumns);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                child: Text(
                  currentGridColumns.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    //fontSize: 16,
                    //backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget btnDragEnable() {
    return IconButton(
      icon: canDrag
          ? Icon(
              Icons.blur_on,
              color: Colors.white,
            )
          : Icon(
              Icons.blur_off,
              color: Colors.red,
            ),
      onPressed: () async {
        bool canDragNew = canDrag;
        canDragNew = !canDragNew;

        setState(() {
          canDrag = canDragNew;
        });

        if (canDragNew) {
          await reorderVisibleIndex();
          showMessageInSnackbar(translations['Drag and drop enabled']);
        } else
          showMessageInSnackbar(translations['Drag and drop disabled']);

        setState(() {
          canDrag = canDragNew;
        });

        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        await lucasState.saveObject(StateProperties.canDrag, canDragNew);
      },
    );
  }

  showMessageInSnackbar(String msg) {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 700),
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget btnAddNew() {
    return IconButton(
      //color: Colors.white,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.0))),
      icon: Icon(
        Icons.add_circle_outline,
        size: 25.0,
        color: Colors.white,
      ),
      onPressed: () async {
        showAddDialog();
      },
      //onTap: () => {gotoParentFolder()},
    );
  }

  Widget buildFolderPath(bool isObjectSelected) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    if (currentFolder == null) return Container();
    if (currentFolder.id == -1)
      return Icon(
        Icons.home,
        size: isObjectSelected ? 14.0 : 24.0,
      );

    return Text(currentFolder.textToShow,
        style: isObjectSelected
            ? TextStyle(fontSize: 14.0)
            : TextStyle(fontSize: 24.0));
  }

  Widget getBackToParentButton() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    if (currentFolder == null) return Container();
    if (currentFolder.id == -1) return Container();

    return IconButton(
      //color: Colors.white,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30.0))),
      icon: Icon(
        Icons.keyboard_arrow_up,
        size: 38.0,
        color: Colors.white,
      ),
      onPressed: () {
        gotoParentFolder();
      },
      //onTap: () => {gotoParentFolder()},
    );
  }

  gotoParentFolder() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    MFolder pFolder = await MFolder.getByID(currentFolder.parentFolderId);
    _onItemDoubleTap(pFolder);
  }

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    await lucasState.saveObject(StateProperties.isEditMode, false);

    Navigator.pop(context);

    Route route = MaterialPageRoute(builder: (context) => SettingScreen());
    Navigator.push(context, route);

    return false;
  }

  Widget buttonEdit() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    MFolder _selectedFolder =
        lucasState.getObject(StateProperties.selectedFolder);
    MImage _selectedImage = lucasState.getObject(StateProperties.selectedImage);
    MVideo _selectedVideo = lucasState.getObject(StateProperties.selectedVideo);
    MSound _selectedSound = lucasState.getObject(StateProperties.selectedSound);
    //MEmpty _selectedEmpty = lucasState.getObject(StateProperties.selectedEmpty);

    Icon icon = Icon(Icons.edit);

    return Container(
      //padding: EdgeInsets.all(4.0),
      child: IconButton(
        icon: icon,
        //splashColor: Theme.of(context).accentColor,
        color: Colors.white, //Theme.of(context).primaryColor,
        onPressed: () async {
          MObject mObject;
          //mObject = _selectedImage ?? _selectedFolder ?? _selectedVideo ?? _selectedSound;
          if (_selectedImage != null) {
            mObject = _selectedImage;
          }
          if (_selectedFolder != null) {
            mObject = _selectedFolder;
          }
          if (_selectedVideo != null) {
            mObject = _selectedVideo;
          }
          if (_selectedSound != null) {
            mObject = _selectedSound;
          }

          final lucasState =
              PropertyChangeProvider.of<LucasState>(context, listen: false)
                  .value;
          await lucasState.saveObject(StateProperties.objectToEdit, mObject);
          await LocalPreferences.setString(
              StateProperties.currentActivity, 'edit object');

          Route route = MaterialPageRoute(
              builder: (context) => EditObject(mObject, _onRefresh));
          Navigator.push(context, route);
        },
      ),
    );
  }

  Widget buttonSelectDefaultFolder() {
    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        // the color to return when button is in pressed, hovered, focused state
        return Colors.red;
      }
      // the color to return when button is in it's normal/unfocused state
      return Theme.of(context).primaryColor;
    }

    MFolder _selectedFolder;
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    _selectedFolder = lucasState.getObject(StateProperties.selectedFolder);

    // if (_selectedFolder.isVisible == 0)
    //   return Container(
    //     width: 0.0,
    //     height: 0.0,
    //   );
    if (currentLevel != '5') return Container(width: 0.0, height: 0.0);

    Icon icon =
        Icon(Icons.check_circle_outline, color: Colors.white);
    String strButton = _strSelectDefaultFolder.toUpperCase();

    return Container(
      padding: EdgeInsets.all(4.0),
      //alignment: Alignment(0.0, 0.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(getBackgroundColor),
        ),

        // shape: RoundedRectangleBorder(
        //   borderRadius: new BorderRadius.circular(18.0),
        //   //side: BorderSide(color: Colors.white),// Theme.of(context).primaryColor),
        // ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 0.0),
              child: icon,
            ),
            Text(
              strButton,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        onPressed: () async {
          final lucasState =
              PropertyChangeProvider.of<LucasState>(context, listen: false)
                  .value;

          _selectedFolder = lucasState.getObject(StateProperties.currentFolder);
          await selectDefaultFolder(_selectedFolder);
        },
      ),
    );
  }

  selectDefaultFolder(MFolder currentFolder) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int defaultFolderId = currentFolder == null ? -1 : currentFolder.id;
    //LocalPreferences.setInt('defaultFolderId', defaultFolderId);

    // Set folder visible
    if (currentFolder != null) {
      await MFolder.updateIsVisible(currentFolder.relationId, 1);

      currentFolder.isVisible = 1;
    }

    // MRelation relation = await MRelation.getByID(_selectedFolder.relationId);
    // if (relation != null) {
    //   relation.isVisible = 1;
    //   await MRelation.update(relation);
    //   _selectedFolder.isVisible = 1;
    // }

    await lucasState.saveObject(
        StateProperties.defaultFolderId, defaultFolderId);
    await LocalPreferences.setInt('defaultFolderId', defaultFolderId);

    await updateLearningObjects(defaultFolderId);

    // update folder breadcrumb
    String folderBreadcrumb = await MFolder.getBreadcrumb(defaultFolderId);
    if (folderBreadcrumb.isEmpty) folderBreadcrumb = '/';
    await LocalPreferences.setString(
        StateProperties.folderBreadcrumb, folderBreadcrumb);

    await lucasState.saveObject(
        StateProperties.folderBreadcrumb, folderBreadcrumb);
    if (currentFolder != null) {
      await updateLearningObjects(currentFolder.id);
    } else {
      await updateLearningObjects(defaultFolderId);
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    showOperationSuccessfull();
  }


  updateLearningObjects(int defaultFolderId) async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    int gridColumns = lucasState.getGridColumns();

    String strCurrentLevel =
        await LocalPreferences.getString("currentLevel", "1");
    int currentLevel = int.parse(strCurrentLevel);

    if (defaultFolderId == -2) defaultFolderId = -1;
    List<MObject> learningObjects = await MRelation.getLearningObjectsInFolder(
        currentLevel, defaultFolderId, gridColumns);
    await lucasState.saveObject(
        StateProperties.learningObjects, learningObjects);
  }

  Widget buttonClose() {
    return IconButton(
      //color: Theme.of(context).primaryColor,
      icon: Icon(Icons.close),
      onPressed: () {
        setState(() {
          _unselectAllObjects();
        });
      },
    );
    // return TextButton(
    //   child: Row(
    //     children: <Widget>[
    //       Icon(Icons.close),
    //       //Text(_strClose.toUpperCase()),
    //     ],
    //   ),
    //   onPressed: () {
    //     setState(() {
    //       _unselectAllObjects();
    //     });
    //   },
    // );
  }

  Widget buildAppTitle() {
    //folders = MFolder.getFoldersIn(currentFolderId);
    // MFolder currentFolder = await MFolder.getByID(currentFolderId);
    // MFolder parentFolder = await MFolder.getByID(currentFolder.parentFolderId);

    if (currentFolder == null) return Container();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // back button

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
              child: currentFolder.id != -1
                  ? OutlineButton (
                      borderSide: BorderSide(
                        color: Colors.white, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 1.0, //width of the border
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      //color: Theme.of(context).accentColor,
                      //color: Colors.white,
                      textColor: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.chevron_left,
                          ),
                          currentFolder.parentFolderId == -1
                              ? Icon(Icons.home)
                              : Container(),
                          parentFolder == null
                              ? Text('')
                              : Helper.debugMode
                                  ? Text((parentFolder.textToShow ?? '') +
                                      ' (${parentFolder.id})')
                                  : Text(parentFolder.textToShow ?? ''),
                        ],
                      ),

                      onPressed: () {
                        parentFolder == null
                            ? _onItemDoubleTap(currentFolder)
                            : _onItemDoubleTap(parentFolder);
                      },
                    )
                  : Container(),
            ),
          ),
        ),
        //Spacer(),
        // current folder
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: currentFolder.id == -1
                ? Icon(Icons.home)
                : Helper.debugMode
                    ? Text(currentFolder.textToShow + ' (${currentFolder.id})')
                    : Text(currentFolder.textToShow),
          ),
        ),
      ],
    );
  }

  showOperationSuccessfull() {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: L.getLocalizedText('operation completed successfully'),
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  _onItemTap(MObject mObject) async {
    _unselectAllObjects();

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    if (mObject is MFolder) {
      MFolder mfolder = mObject;
      await lucasState.saveObject(StateProperties.selectedFolder, mfolder);
    }

    if (mObject is MEmpty) {
      MEmpty mEmpty = mObject;
      await lucasState.saveObject(StateProperties.selectedEmpty, mEmpty);
    }

    if (mObject is MImage) {
      MImage mImage = mObject;
      await lucasState.saveObject(StateProperties.selectedImage, mImage);
    }

    if (mObject is MVideo) {
      MVideo mVideo = mObject;
      await lucasState.saveObject(StateProperties.selectedVideo, mVideo);
    }

    if (mObject is MSound) {
      MSound mSound = mObject;
      await lucasState.saveObject(StateProperties.selectedSound, mSound);
    }

    await lucasState.saveObject(StateProperties.objectToEdit, mObject);
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'edit object');

    Route route = MaterialPageRoute(
        builder: (context) => EditObject(mObject, _onRefresh));
    Navigator.push(context, route);

    // if (mounted) {
    //   setState(() {
    //     // just refresh screen
    //   });
    // }
  }

  _onRefresh(MObject mObject) async {
    if (mounted) {
      setState(() {
        //isLoading = true;
      });
    }
  }

  _onItemDoubleTap(MObject mObject) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    _unselectAllObjects();

    if (mObject is MFolder) {
      MFolder mfolder = mObject;

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      await lucasState.saveObject(StateProperties.selectedFolder, mfolder);

      int gridColumns = lucasState.getGridColumns();

      List<MObject> objects =
          await MRelation.getObjectsInFolder(gridColumns, mfolder.id);
      await lucasState.saveObject(StateProperties.gridObjects, objects);

      currentFolder = await MFolder.getByID(mfolder.id);
      currentFolder.isVisible = mObject.isVisible;
      currentFolder.relationId = mObject.relationId;

      if (currentFolder == null)
        parentFolder = null;
      else
        parentFolder = await MFolder.getByID(currentFolder.parentFolderId);
      lucasState.saveObject(StateProperties.currentFolder, currentFolder);
      lucasState.saveObject(StateProperties.parentFolder, parentFolder);

      setState(() {
        currentFolder = currentFolder;
      });

      if (int.parse(currentLevel) > 5) {
        //lucasState.saveObject(StateProperties.currentFolderId, mfolder.id);
        await LocalPreferences.setInt('currentLearningFolderId', mfolder.id);

        lucasState.saveObject(StateProperties.currentFolder, mfolder);
        int gridColumns = lucasState.getGridColumns();

        List<MObject> learningObjects =
            await MRelation.getLearningObjectsInFolder(
                int.parse(currentLevel), mfolder.id, gridColumns);
        lucasState.saveObject(StateProperties.learningObjects, learningObjects);
      }

      _unselectAllObjects();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  _onItemLongPress(MObject mObject) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    _unselectAllObjects();

    if (mObject is MFolder) {
      MFolder mfolder = mObject;

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      lucasState.saveObject(StateProperties.selectedFolder, mfolder);
    }

    await MObject.toggleVisibility(mObject);
    int currentLearningFolderId =
        await LocalPreferences.getInt('currentLearningFolderId', -2);

    if (currentLearningFolderId == -2) {
      currentLearningFolderId =
          await LocalPreferences.getInt('defaultFolderId', -2);
    }

    await updateLearningObjects(currentLearningFolderId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  _unselectAllObjects() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    lucasState.saveObject(StateProperties.selectedFolder, null);
    lucasState.saveObject(StateProperties.selectedImage, null);
    lucasState.saveObject(StateProperties.selectedVideo, null);
    lucasState.saveObject(StateProperties.selectedSound, null);
    lucasState.saveObject(StateProperties.selectedEmpty, null);
  }

  showFolderAndRelationsInfo() async {
    List<MFolder> folders = await MFolder.getAll();
    List<MRelation> relations = await MRelation.getAll();
    List<MRelation> duplicatedRelations = <MRelation>[];
    for (int i = 0; i < relations.length; i++) {
      MRelation iRelation = relations[i];

      for (int j = i + 1; j < relations.length; j++) {
        MRelation jRelation = relations[j];
        if (jRelation.cardFolderId == iRelation.cardFolderId &&
            jRelation.cardImageId == iRelation.cardImageId &&
            jRelation.cardEmptyId == iRelation.cardEmptyId &&
            jRelation.cardType == iRelation.cardType &&
            jRelation.parentFolderId == iRelation.parentFolderId) {
          duplicatedRelations.add(jRelation);
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Folders information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total folders: ${folders.length}'),
                Text('Total relations: ${relations.length}'),
                Text('Duplicated relations: ${duplicatedRelations.length}'),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: L.getUpperText('accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: L.getUpperText('delete duplicated'),
              onPressed: () async {
                await MRelation.deleteDuplicated();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: L.getText('add'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.create_new_folder)),
                      Expanded(child: L.getText('add folder')),
                    ],
                  ),
                  onPressed: () async {
                    await addFolder();
                  },
                ),
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.add_photo_alternate)),
                      Expanded(child: L.getText('add image')),
                    ],
                  ),
                  onPressed: () async {
                    await addImage();
                  },
                ),
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.video_call)),
                      Expanded(child: L.getText('add video')),
                    ],
                  ),
                  onPressed: () async {
                    await addVideo();
                  },
                ),
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(4.0), child: Icon(Icons.mic)),
                      Expanded(child: L.getText('add sound')),
                    ],
                  ),
                  onPressed: () async {
                    await addSound();
                  },
                ),
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.no_sim)),
                      Expanded(child: L.getText('add empty')),
                    ],
                  ),
                  onPressed: () async {
                    await addEmpty();
                  },
                ),
                // Text('Total folders: ${folders.length}'),
                // Text('Total relations: ${relations.length}'),
                // Text('Duplicated relations: ${duplicatedRelations.length}'),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: L.getUpperText('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addFolder() async {
    setState(() {
      isLoading = true;
    });

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    // add folder
    int maxFolderId = await MFolder.maxId();
    MFolder mFolder = MFolder(
      id: maxFolderId,
      parentFolderId: currentFolder.id,
      fileName: 'assets/images/folders_folder.png',
      categoryId: -1,
      isVisible: 1,
    );
    await MFolder.createWithID(mFolder);

    // add translation
    int maxId;
    List<Language> languages = Language.getAll();
    for (Language language in languages) {
      String textToShow =
          await L.itemInL(language.languageCode, 'new folder name');
      String textToSay = textToShow;

      Translation entity = Translation(
        tableName: MFolder.TableName,
        itemId: maxFolderId,
        language: language.languageCode,
        textToShow: textToShow,
        textToSay: textToSay,
      );

      await Translation.create(entity);
    }

    // Get visibleIndex
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    int visibleIndex = 1;
    if (objects.length > 0)
      visibleIndex = objects[objects.length - 1].visibleIndex + 1;

    // Add relation
    maxId = await MRelation.maxId();
    MRelation entity = MRelation(
      id: maxId,
      parentFolderId: currentFolder.id,
      cardType: 'folder',
      cardFolderId: maxFolderId,
      cardImageId: -1,
      cardEmptyId: -1,
      visibleIndex: visibleIndex,
      userCreated: 1,
    );

    await MRelation.createWithID(entity);

    // refresh info
    //await refreshFolder(currentFolder);
    objects = await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    // close dialog
    Navigator.of(context).pop();

    mFolder = await MFolder.getByID(maxFolderId);
    mFolder.relationId = maxId;
    await MFolder.update(mFolder);

    setState(() {
      isLoading = false;
    });

    await lucasState.saveObject(StateProperties.objectToEdit, mFolder);
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'edit object');

    Route route = MaterialPageRoute(
        builder: (context) => EditObject(mFolder, _onRefresh));
    Navigator.push(context, route);
  }

  Future<void> addEmpty() async {
    setState(() {
      isLoading = true;
    });

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    // add empty
    int maxEmptyId = await MEmpty.maxId();
    MEmpty mEmpty = MEmpty(
      id: maxEmptyId,
    );
    await MEmpty.createWithID(mEmpty);

    // Get visibleIndex
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    int visibleIndex = 1;
    if (objects.length > 0)
      visibleIndex = objects[objects.length - 1].visibleIndex + 1;

    // Add relation
    int maxId = await MRelation.maxId();
    MRelation entity = MRelation(
      id: maxId,
      parentFolderId: currentFolder.id,
      cardType: 'empty',
      cardFolderId: -1,
      cardImageId: -1,
      cardEmptyId: maxEmptyId,
      visibleIndex: visibleIndex,
      userCreated: 1,
    );

    await MRelation.createWithID(entity);

    // refresh info
    //await refreshFolder(currentFolder);
    objects = await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    // close dialog
    Navigator.of(context).pop();

    // mEmpty = await MEmpty.getByID(maxEmptyId);
    // mEmpty.relationId = maxId;

    setState(() {
      isLoading = false;
    });

    // await lucasState.saveObject(StateProperties.objectToEdit, mEmpty);
    // await LocalPreferences.setString(
    //     StateProperties.currentActivity, 'edit object');

    // Route route = MaterialPageRoute(builder: (context) => EditObject(mImage));
    // Navigator.push(context, route);
  }

  Future<void> addImage() async {
    setState(() {
      isLoading = true;
    });

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    if (currentFolder == null) {
      return;
    }

    // add folder
    int maxImageId = await MImage.maxId();
    MImage mImage = MImage(
      id: maxImageId,
      fileName: 'assets/images/new_image.png',
      categoryId: -1,
      isVisible: 1,
      isUnderstood: 0,
    );
    await MImage.createWithID(mImage);

    // add translation
    int maxId;
    List<Language> languages = Language.getAll();
    for (Language language in languages) {
      String textToShow =
          await L.itemInL(language.languageCode, 'new image name');
      String textToSay = textToShow;

      Translation entity = Translation(
        tableName: MImage.TableName,
        itemId: maxImageId,
        language: language.languageCode,
        textToShow: textToShow,
        textToSay: textToSay,
      );

      await Translation.create(entity);
    }

    // Get visibleIndex
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    int visibleIndex = 1;
    if (objects.length > 0)
      visibleIndex = objects[objects.length - 1].visibleIndex + 1;

    // Add relation
    maxId = await MRelation.maxId();
    MRelation entity = MRelation(
      id: maxId,
      parentFolderId: currentFolder.id,
      cardType: 'image',
      cardFolderId: -1,
      cardImageId: maxImageId,
      visibleIndex: visibleIndex,
      cardEmptyId: -1,
      userCreated: 1,
    );

    await MRelation.createWithID(entity);

    // refresh info
    //await refreshFolder(currentFolder);
    objects = await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    // close dialog
    Navigator.of(context).pop();

    mImage = await MImage.getByID(maxImageId);
    mImage.relationId = maxId;

    setState(() {
      isLoading = false;
    });

    await lucasState.saveObject(StateProperties.objectToEdit, mImage);
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'edit object');

    Route route =
        MaterialPageRoute(builder: (context) => EditObject(mImage, _onRefresh));
    Navigator.push(context, route);
  }

  Future<void> addVideo() async {
    setState(() {
      isLoading = true;
    });

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    // add video
    int maxVideoId = await MVideo.maxId();
    MVideo mVideo = MVideo(
      id: maxVideoId,
      fileName: 'assets/images/new_video.png',
      categoryId: -1,
      isVisible: 1,
      isUnderstood: 0,
    );
    await MVideo.createWithID(mVideo);

    // add translation
    int maxId;
    List<Language> languages = Language.getAll();
    for (Language language in languages) {
      String textToShow =
          await L.itemInL(language.languageCode, 'new video name');
      String textToSay = textToShow;

      Translation entity = Translation(
        tableName: MVideo.TableName,
        itemId: maxVideoId,
        language: language.languageCode,
        textToShow: textToShow,
        textToSay: textToSay,
      );

      await Translation.create(entity);
    }

    // Get visibleIndex
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    int visibleIndex = 1;
    if (objects.length > 0)
      visibleIndex = objects[objects.length - 1].visibleIndex + 1;

    // Add relation
    maxId = await MRelation.maxId();
    MRelation entity = MRelation(
      id: maxId,
      parentFolderId: currentFolder.id,
      cardType: 'video',
      cardFolderId: -1,
      cardVideoId: maxVideoId,
      visibleIndex: visibleIndex,
      cardEmptyId: -1,
      userCreated: 1,
    );

    await MRelation.createWithID(entity);

    // refresh info
    //await refreshFolder(currentFolder);
    objects = await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    // close dialog
    Navigator.of(context).pop();

    mVideo = await MVideo.getByID(maxVideoId);
    mVideo.relationId = maxId;

    setState(() {
      isLoading = false;
    });

    await lucasState.saveObject(StateProperties.objectToEdit, mVideo);
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'edit object');

    Route route =
        MaterialPageRoute(builder: (context) => EditObject(mVideo, _onRefresh));
    Navigator.push(context, route);
  }

  Future<void> addSound() async {
    setState(() {
      isLoading = true;
    });

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    currentFolder = lucasState.getObject(StateProperties.currentFolder);

    // add sound
    int maxSoundId = await MSound.maxId();
    MSound mSound = MSound(
      id: maxSoundId,
      fileName: 'assets/images/new_sound.png',
      categoryId: -1,
      isVisible: 1,
      isUnderstood: 0,
    );
    await MSound.createWithID(mSound);

    // add translation
    int maxId;
    List<Language> languages = Language.getAll();
    for (Language language in languages) {
      String textToShow =
          await L.itemInL(language.languageCode, 'new sound name');
      String textToSay = textToShow;

      Translation entity = Translation(
        tableName: MSound.TableName,
        itemId: maxSoundId,
        language: language.languageCode,
        textToShow: textToShow,
        textToSay: textToSay,
      );

      await Translation.create(entity);
    }

    // Get visibleIndex
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    int visibleIndex = 1;
    if (objects.length > 0)
      visibleIndex = objects[objects.length - 1].visibleIndex + 1;

    // Add relation
    maxId = await MRelation.maxId();
    MRelation entity = MRelation(
      id: maxId,
      parentFolderId: currentFolder.id,
      cardType: 'sound',
      cardFolderId: -1,
      cardSoundId: maxSoundId,
      visibleIndex: visibleIndex,
      cardEmptyId: -1,
      userCreated: 1,
    );

    await MRelation.createWithID(entity);

    // refresh info
    //await refreshFolder(currentFolder);
    objects = await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    // close dialog
    Navigator.of(context).pop();

    mSound = await MSound.getByID(maxSoundId);
    mSound.relationId = maxId;

    setState(() {
      isLoading = false;
    });

    await lucasState.saveObject(StateProperties.objectToEdit, mSound);
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'edit object');

    Route route =
        MaterialPageRoute(builder: (context) => EditObject(mSound, _onRefresh));
    Navigator.push(context, route);
  }

  Future<void> refreshFolder(MFolder folder) async {
    _onItemDoubleTap(folder);

    int currentLearningFolderId =
        await LocalPreferences.getInt('currentLearningFolderId', -2);

    if (currentLearningFolderId == -2) {
      currentLearningFolderId =
          await LocalPreferences.getInt('defaultFolderId', -2);
    }

    await updateLearningObjects(currentLearningFolderId);
  }

  Future<void> reorderVisibleIndex() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int gridColumns = lucasState.getGridColumns();
    MFolder currentFolder = lucasState.getObject(StateProperties.currentFolder);

    // Clean relations (only one relation per image/video/empty/sound)
    // First find unique relations
    List<MRelation> relations =
        await MRelation.getInFolder(gridColumns, currentFolder.id);
    List<MRelation> uniqueRelations = <MRelation>[];
    for (MRelation relation in relations) {
      bool found = false;
      for (MRelation uniqueRelation in uniqueRelations) {
        if (relation.cardType == uniqueRelation.cardType &&
            relation.cardEmptyId == uniqueRelation.cardEmptyId &&
            relation.cardFolderId == uniqueRelation.cardFolderId &&
            relation.cardImageId == uniqueRelation.cardImageId &&
            relation.cardSoundId == uniqueRelation.cardSoundId &&
            relation.cardVideoId == uniqueRelation.cardVideoId) {
          found = true;
          break;
        }
      }
      if (!found) {
        uniqueRelations.add(relation);
      }
    }
    // Now delete duplicated relations
    for (MRelation uniqueRelation in uniqueRelations) {
      int numberRepetions = 0;
      for (MRelation relation in relations) {
        if (relation.cardType == uniqueRelation.cardType &&
            relation.cardEmptyId == uniqueRelation.cardEmptyId &&
            relation.cardFolderId == uniqueRelation.cardFolderId &&
            relation.cardImageId == uniqueRelation.cardImageId &&
            relation.cardSoundId == uniqueRelation.cardSoundId &&
            relation.cardVideoId == uniqueRelation.cardVideoId) {
          numberRepetions++;
          if (numberRepetions > 1) {
            await MRelation.delete(relation);
          }
        }
      }
    }

    // Order visible index
    relations = await MRelation.getInFolder(gridColumns, currentFolder.id);
    int visibleIndex = 0;
    for (MRelation relation in relations) {
      relation.visibleIndex = visibleIndex;
      //await MRelation.update(relation);
      visibleIndex++;
    }

    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);

    visibleIndex = 0;
    for (MObject mObject in objects) {
      MRelation mRelation = await MRelation.getByID(mObject.relationId);
      mRelation.visibleIndex = visibleIndex;
      //await MRelation.update(mRelation);
      visibleIndex++;
    }

    //objects = await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
    //for (MFolder f in objects) {
    //var element = f.textToShow;
    //}
    await lucasState.saveObject(StateProperties.gridObjects, objects);
  }
}
