import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/Language.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/Translation.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/widgets/WFolder.dart';
import 'package:lucas/widgets/WImage.dart';
import 'package:lucas/widgets/WOnboard.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewPictureScreen.dart';

class ImageSettings extends StatefulWidget {
  final bool selectFirstReinforcer;
  final bool selectSecondReinforcer;
  final bool selectThirdReinforcer;
  final bool isSelectingObject;
  final bool findInAssetLibrary;

  ImageSettings(this.selectFirstReinforcer, this.selectSecondReinforcer,
      this.selectThirdReinforcer, this.findInAssetLibrary,
      {Key key, this.isSelectingObject})
      : super(key: key);

  @override
  _ImageSettingsState createState() {
    SharedPreferences.getInstance().then((prefs) {
      bool darkMode = prefs.getBool('darkMode') ?? true;
      String languageCode = prefs.getString('languageCode') ?? "en";
      return _ImageSettingsState(
        darkMode,
        languageCode,
        selectFirstReinforcer,
        selectSecondReinforcer,
        selectThirdReinforcer,
        findInAssetLibrary,
        isSelectingObject == null ? false : isSelectingObject,
      );
    });
    return _ImageSettingsState(
      true,
      'en',
      selectFirstReinforcer,
      selectSecondReinforcer,
      selectThirdReinforcer,
      findInAssetLibrary,
      isSelectingObject == null ? false : isSelectingObject,
    );
  }
}

class _ImageSettingsState extends State<ImageSettings> {
  bool isLoading = false;
  bool selectFirstReinforcer = false;
  bool selectSecondReinforcer = false;
  bool selectThirdReinforcer = false;
  bool findInAssetLibrary = false;

  String textToSearch = '';
  final TextEditingController _textController = new TextEditingController();
  //final String hint = "";
  List<MImage> mImages;
  bool darkMode = true;
  String languageCode;
  bool isSelectingObject = false;

  List<MObject> objects = <MObject>[];

  Map<String, String> helpScreenTranslations = Map<String, String>();
  bool canShowHelpScreens = false;
  int crossAxisCount = 4;
  bool loading = true;

  _ImageSettingsState(
    bool darkMode,
    String languageCode,
    bool selectFirstReinforcer,
    bool selectSecondReinforcer,
    bool selectThirdReinforcer,
    bool findInAssetLibrary,
    bool isSelectingObject,
  ) {
    this.darkMode = darkMode;
    this.languageCode = languageCode;
    this.selectFirstReinforcer = selectFirstReinforcer;
    this.selectSecondReinforcer = selectSecondReinforcer;
    this.selectThirdReinforcer = selectThirdReinforcer;
    this.isSelectingObject = isSelectingObject;
    this.findInAssetLibrary = findInAssetLibrary;

    //imageCards = await MImage.getAll(textToSearch:_textController.text);
  }

  @override
  void initState() {
    super.initState();
    // initialize().then((result) {
    //   setState(() {});
    // });

    loadHelpScreensTranslationTexts().then((result) {
      setState(() {
        canShowHelpScreens = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    initialize().then((result) {
      setState(() {
        loading = false;
      });
    });

    super.didChangeDependencies();
  }

  Future<void> loadHelpScreensTranslationTexts() async {
    List<String> helpScreenTranslationsItems = [
      'showHelper_image-settings_title1',
      'showHelper_image-settings_title2',
      'showHelper_image-settings_title3',
      'showHelper_image-settings_title4',
      'showHelper_image-settings_text1',
      'showHelper_image-settings_text2',
      'showHelper_image-settings_text3',
      'showHelper_image-settings_text4',
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

  Future<void> initialize() async {
    try {
      final lucasState = PropertyChangeProvider.of<LucasState>(context).value;
      await lucasState.saveObjectWithoutNotifyingListeners(
          StateProperties.selectFirstReinforcer, selectFirstReinforcer);
      await lucasState.saveObjectWithoutNotifyingListeners(
          StateProperties.selectSecondReinforcer, selectSecondReinforcer);
      await lucasState.saveObjectWithoutNotifyingListeners(
          StateProperties.selectThirdReinforcer, selectThirdReinforcer);
      await lucasState.saveObjectWithoutNotifyingListeners(
          StateProperties.findInAssetLibrary, findInAssetLibrary);

      await getObjects('', true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getObjects(
  String textToSearch, bool first) async {

    if (mounted && !first) {
      setState(() {
        isLoading = true;
      });
      List<MObject> allObjects = await MObject.getAll(textToSearch);
      setState(() {
        objects = allObjects;
        isLoading = false;
      });
    }

    if(first && objects.length == 0){
      setState(() {
        isLoading = true;
      });
      List<MObject> allObjects = await MObject.getAll(textToSearch);
      setState(() {
        objects = allObjects;
        isLoading = false;
      });
    }

   // hide softkeyboard
   if(!first) {
     FocusScope.of(context).requestFocus(FocusNode());
   }

  }

  Widget showHelperScreens() {
    if (!canShowHelpScreens) return Container();

    List<String> images = [
      "assets/onboarding/image-settings-1.png",
      "assets/onboarding/image-settings-2.png",
      "assets/onboarding/image-settings-3.png",
      "assets/onboarding/image-settings-4.png",
    ];

    List<String> titles = [
      helpScreenTranslations['showHelper_image-settings_title1'],
      helpScreenTranslations['showHelper_image-settings_title2'],
      helpScreenTranslations['showHelper_image-settings_title3'],
      helpScreenTranslations['showHelper_image-settings_title4'],
    ];

    List<String> texts = [
      helpScreenTranslations['showHelper_image-settings_text1'],
      helpScreenTranslations['showHelper_image-settings_text2'],
      helpScreenTranslations['showHelper_image-settings_text3'],
      helpScreenTranslations['showHelper_image-settings_text4'],
    ];

    return WOnboard(images, titles, texts,
        StateProperties.showHelperImageSettings, onOnBoardBtnAccept);
  }

  onOnBoardBtnAccept(dynamic a) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Container();

    final lucasState = PropertyChangeProvider.of<LucasState>(context).value;
    if ((lucasState.getObject(StateProperties.showHelperImageSettings) ??
            'false') !=
        "false") {
      return showHelperScreens();
    }

    return PropertyChangeConsumer<LucasState>(
        properties: [
          StateProperties.showHelperImageSettings,
          StateProperties.currentFolder
        ],
        builder: (context, lucasState, property) {
          if (helpScreenTranslations == null || helpScreenTranslations.isEmpty)
            return Container();

          SharedPreferences.getInstance().then((prefs) {
            bool darkMode = prefs.getBool('darkMode') ?? true;
            String languageCode = prefs.getString('languageCode') ?? "en";
            return _ImageSettingsState(
                darkMode,
                languageCode,
                selectFirstReinforcer,
                selectSecondReinforcer,
                selectThirdReinforcer,
                findInAssetLibrary,
                isSelectingObject);
          });

          return WillPopScope(
            onWillPop: handleBackButton,
            child: Scaffold(
              appBar: AppBar(
                title: (selectFirstReinforcer
                    ? L.getAppBarLocalizedText("select reinforcer")
                    : (selectSecondReinforcer
                        ? L.getAppBarLocalizedText("select second reinforcer")
                        : (selectThirdReinforcer
                            ? L.getAppBarLocalizedText(
                                "select third reinforcer")
                            : L.getAppBarLocalizedText("images")))),
                actions: <Widget>[
                  TextButton(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      addImage();
                    },
                  ),
                  TextButton(
                    child: Icon(
                      Icons.grid_on,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        crossAxisCount++;
                        if (crossAxisCount > 7) crossAxisCount = 3;
                      });
                    },
                  ),
                  TextButton(
                    child: Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      String showHelpStatus = lucasState.getObject(
                              StateProperties.showHelperImageSettings) ??
                          '';
                      setState(() {
                        if (showHelpStatus == '')
                          lucasState.saveObject(
                              StateProperties.showHelperImageSettings, 'false');
                        else
                          lucasState.saveObject(
                              StateProperties.showHelperImageSettings, '');
                      });
                    },
                  )
                ],
              ),
              body: Column(
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
                  getSearchBar(),
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: getImagesListView(),
                  //   ),
                  // ),
                  Expanded(
                    child: getImagesListView(),
                  ),
                  //getImagesListView(),
                  //Expanded(child: imageListWidget()),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: imageCards.length,
                  //     itemBuilder: _futureBuilder,
                  //   ),
                  // ),
                ],
              ),
              //Container(child: getFutureLevelListView(context)),
              bottomNavigationBar: BottomNavigationOptions(),
            ),
          );
        });
  }

  Widget getSearchBar() {
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

    return Container(
      padding: EdgeInsets.all(5.0),
      child: Container(
        //color: Colors.transparent,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey),
          color: Colors.red,
        ),
        // decoration: new BoxDecoration(
        //   border: Border.all(color: LocalPreferences.AppBarBackgroundColor),
        // ),
        //padding: EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
          child: Container(
            height: 40.0,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              //border: Border.all(color: Theme.of(context).primaryColor),
              color: Colors.grey[200],
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _textController,
              /*
              onChanged: (newText) async {
                //if (isLoading) return;

                await getObjects(newText);
                // setState(() {
                //   textToSearch = newText; //_textController.text = '';
                // });
              },
              */
              style: new TextStyle(
                color: Colors.black87,
              ),
              decoration: new InputDecoration(
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.0),
                suffixIcon: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith(getBackgroundColor),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await getObjects(_textController.text, false);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addImage() async {
    PickedFile pickedfile = await ImagePicker().getImage(
        source: ImageSource.camera, maxHeight: 618.0, maxWidth: 618.0);
    File file = File(pickedfile.path);
    if (file != null) {
      await saveChanges('localPath', file.path);
    }
  }

  Future<void> saveChanges(String field, String text) async {
    setState(() {
      isLoading = true;
    });

    if (field == 'localPath') {
      if (text != null && text != '') {
        // copy file from path to local lucas directory
        File file = File(text);
        if (file != null) {
          File copiedFfile =
              await file.copy('${Helper.appDirectory}/${text.split('/').last}');
          if (copiedFfile != null) {
            MFolder defaultUserFolder = await MFolder.getDefaultUserFolder();

            if (defaultUserFolder != null) {
              // add image
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
              String imageName = '';
              List<Language> languages = Language.getAll();
              String languageCode =
                  await LocalPreferences.getString('languageCode', 'en');
              for (Language language in languages) {
                String textToShow =
                    await L.itemInL(language.languageCode, 'new image name');
                String textToSay = textToShow;

                if (languageCode == language.languageCode) {
                  imageName = textToSay;
                }

                Translation entity = Translation(
                  tableName: MImage.TableName,
                  itemId: maxImageId,
                  language: language.languageCode,
                  textToShow: textToShow,
                  textToSay: textToSay,
                );

                await Translation.create(entity);
              }

              // Add relation
              int maxId = await MRelation.maxId();
              MRelation relation = MRelation(
                id: maxId,
                parentFolderId: defaultUserFolder.id,
                cardType: 'image',
                cardFolderId: -1,
                cardEmptyId: -1,
                cardImageId: mImage.id,
                visibleIndex: -1,
                userCreated: 1,
              );

              await MRelation.createWithID(relation);

              //modifiedLocalFileName = true;
              String localFileName = text.split('/').last;

              // update the object
              mImage.useAsset = 0;
              mImage.localFileName = localFileName;
              mImage.relationId = relation.id;
              MImage.update(mImage);

              _textController.text = imageName;
              Navigator.pop(context);
              await getObjects(imageName, false);
            }
          }
        }
      }
    }

    setState(() {
      isLoading = false;
    });
    /*
    if (mObject is MImage) {
      MImage mImage = mObject;
      MImage.update(mImage);
    }

    MRelation relation = await MRelation.getByID(mObject.relationId);
    MFolder parentFolder = await MFolder.getByID(relation.parentFolderId);
    await refreshFolder(parentFolder);

    setState(() {
      isLoading = false;
    });

    lucasState.saveObject(StateProperties.savingEditedObject, false);
    */
  }

  Widget getImagesListView() {
    if (isLoading) return Container();

    return GridView(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 6,
          childAspectRatio: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 2),
      children: [
        for (final item in objects) buildListTile(item),
      ],
    );
  }

  Widget buildListTile(MObject mObject) {
    Widget leadingWidget = Container();
    if (mObject is MImage)
      leadingWidget = SizedBox(
        width: 50.0,
        height: 80.0,
        child: WImage(
          true,
          mObject,
          '11',
          (mObject) => {_viewPicture(mObject)},
          null,
          null,
          key: UniqueKey(),
        ),
      );
    if (mObject is MFolder)
      leadingWidget = SizedBox(
        width: 50.0,
        height: 80.0,
        child: WFolder(
          mObject,
          '11',
          (mObject) => {_viewPicture(mObject)},
          null,
          null,
          key: UniqueKey(),
        ),
      );

    ///TODO
    // if (mObject is MVideo)
    //   leadingWidget = SizedBox(
    //       width: 50.0,
    //       height: 80.0,
    //       child: WVideo(
    // true,
    // mObject,
    // '11',
    // (mObject) => {_viewPicture(mObject)},
    // null,
    // null,
    // key: UniqueKey(),);

    // if (mObject is MSound)
    //   leadingWidget = SizedBox(
    //       width: 50.0,
    //       height: 80.0,
    //       child: WSound(
    // true,
    // mObject,
    // '11',
    // (mObject) => {_viewPicture(mObject)},
    // null,
    // null,
    // key: UniqueKey(),);

    return leadingWidget;
  }

  Future getMImages() async {
    setState(() {
      isLoading = true;
    });

    List<MImage> list = await MImage.getAll(
        textToSearch: textToSearch); //_textController.text);

    setState(() {
      isLoading = false;
    });

    return list;
  }

  Widget imageListWidget() {
    return FutureBuilder(
      future: getMImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Container(
            height: Helper.LinearProgressIndicatorHeight,
            child: LinearProgressIndicator(
              value: null,
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
            ),
          );
        }

        mImages = snapshot.data;
        return ListView.builder(
          itemCount: mImages == null ? 0 : mImages.length,
          itemBuilder: _futureBuilder,
        );
      },
    );
  }

  Widget _futureBuilder(BuildContext context, int index) {
    return FutureBuilder(
      future: this._fetchEntry(index),
      builder: (context, snapshot) {
        return getListItem(context, snapshot, index);
      },
    );
  }

  _fetchEntry(int index) async {
    return mImages[index];
  }

  Widget getListItem(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.active:
      case ConnectionState.waiting:
        return Container(
          padding: getPadding(),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCircularProgressIndicator(),
                  getLoadingText(),
                ],
              )),
        );
      case ConnectionState.done:
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var imageCard = snapshot.data;
          return buildFormListTile(context, imageCard);
        }
    }
    return Container();
  }

  Widget buildFormListTile(BuildContext context, MImage imageCard) {
    // Future<Image> imageOfCard= FutureBuilder(
    //       future: _buildImage(Helper.imageNotFound, 32.0, 32.0),
    //       builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done)
    //           return snapshot.data;
    //         else
    //           return Image.asset("assets/images/null.png");
    //       },
    //     );

    // Image imageOfCard= Image.asset(Helper.imageNotFound, height: 32.0, width: 32.0);

    // try {
    //   imageOfCard = Image.asset(imageCard.fileName, height: 32.0, width: 32.0);
    // } catch(_) {
    // }

    Widget cardImage = Image.asset(
              imageCard.fileName,
            ) !=
            null
        ? Image.asset(
            imageCard.fileName,
          )
        : Image.asset(Helper.imageNotFound);

    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          //color: Colors.grey[200],
        )),
      ),
      child: ListTile(
        leading: GestureDetector(
          //onTap: () => {_viewPicture(context, imageCard)},
          child: Container(
            margin: const EdgeInsets.all(3.0),
            decoration: LocalPreferences.myOuterBoxDecoration(), //
            child: Container(
              decoration: LocalPreferences.myInnerBoxDecoration(), //
              height: LocalPreferences.ThumbnailHeigth,
              child: Container(
                decoration: BoxDecoration(
                  color: imageCard.category == null
                      ? Colors.white
                      : Helper.colorFromHex(imageCard.category.backgroundColor),
                ),
                child: Hero(
                    tag: "image_" + imageCard.id.toString(), child: cardImage),
                //fit: BoxFit.cover
              ),
            ),
            //Image.memory(Helper.dataFromBase64String(imageCard.base64)),
          ),
        ),
        onTap: () => {_viewPicture(imageCard)},
        dense: true,
        //leading: Icon(Icons.library_books),
        title: Text(
          imageCard.textToShow,
          style: LocalPreferences.SubTitleTextStyle,
        ),

        subtitle:
            Helper.debugMode ? Text(imageCard.id.toString()) : Container(),
      ),
    );
  }

  _viewPicture(MImage imageCard) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewPictureScreen(
              imageCard,
              selectFirstReinforcer,
              selectSecondReinforcer,
              selectThirdReinforcer,
              findInAssetLibrary,
              isSelectingObject)),
    );
  }

  EdgeInsetsGeometry getPadding() {
    return const EdgeInsets.fromLTRB(
        LocalPreferences.FormFieldHorizontalPadding,
        LocalPreferences.FormFieldTopVerticalPadding,
        LocalPreferences.FormFieldHorizontalPadding,
        LocalPreferences.FormFieldBottomVerticalPadding);
  }

  Widget getCircularProgressIndicator() {
    return CircularProgressIndicator(
      strokeWidth: 1.0,
      valueColor:
          new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );
  }

  Widget getLoadingText() {
    return Container(
      padding: getPadding(),
      child: Text('Cargando...'),
    );
  }

  getBreadCrumbs(BuildContext context, List parentFolder) {
    final items = <Widget>[];

    for (var i = 0; i < parentFolder.length; i++) {
      items.add(Text(
        parentFolder[i],
        style: TextStyle(
          // // fontWeight: TextFontWeight,
          fontSize: 15.0,
          // color: Theme.of(context).accentColor
        ),
      ));
      if (i != parentFolder.length - 1) {
        items.add(
          Icon(
            Icons.arrow_right,
            size: LocalPreferences.TitleTextFontSize,
            color: Theme.of(context).accentColor,
          ),
        );
      }
    }

    // ListView voicesListView = ListView(
    //   children: items,
    // );

    Row row = Row(
      children: items,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    final rowItems = <Widget>[];
    rowItems.add(row);
    return rowItems;
  }

  showImagesInfo() async {
    List<MImage> images = await MImage.getAll();

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
                Text('Total images: ${images.length}'),
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
          ],
        );
      },
    );
  }

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }
}
