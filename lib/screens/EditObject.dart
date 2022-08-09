import 'dart:async';
//import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sound/flutter_sound.dart';
//import 'package:flutter_sound/flutter_sound.dart';
//import 'package:flutter_sound/android_encoder.dart';
//import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MCategory.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/models/Translation.dart';
import 'package:lucas/widgets/BlinkingText.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uuid/uuid.dart';
//import 'package:wc_flutter_share/wc_flutter_share.dart';

import 'ImageSettings.dart';
import 'TextToSpeech.dart';

class EditObject extends StatefulWidget {
  final MObject mObject;
  final ValueChanged<MObject>
      onRefreshParentWidget; // callback for refreshing parent widget

  EditObject(this.mObject, this.onRefreshParentWidget);

  @override
  _EditObjectState createState() =>
      _EditObjectState(this.onRefreshParentWidget);
}

class _EditObjectState extends State<EditObject> {
  String currentLevel = '1';
  String strNameOfCategory = '';
  final ValueChanged<MObject>
      onRefreshParentWidget;

  // callback for refreshing parent widget

  final TextEditingController _controller = TextEditingController();

  List<String> translationItems = [
    'unlock',
    'lock',
    'understood',
    'not understood',
    'edit',
    'is understood',
    'is not understood',
    'conceptIsUnderstood',
    'conceptIsUnderstoodInstructions',
    'object visible',
    'object not visible',
    'folder not empty will not delete',
    'visibility',
    'visibility instructions',
    'text to show',
    'text to show instructions',
    'text to show hint',
    'text to say',
    'text to say instructions',
    'text to say hint',
    'select folder',
    'default folder',
    'default folder instructions',
    'category',
    'local device',
    'library',
    'camara',
    'delete',
    'delete confirmation',
    'warning not user created',
    'select sound',
    'select sound instructions',
    'please confirm',
    'replace sound confirmation',
    'replace',
    'recording',
    'select video',
    'selected video',
    'item availability',
    'item availability instructions',
    'is available',
    'is not available',
    'not available',
    'available',
    'share item',
    'background color',
    'Minimum level to show',
    'level1',
    'level2',
    'level3',
    'level4',
    'level5',
    'level6',
    'level7',
    'level8',
    'level9',
    'level10',
    'level11',
    'level1 name',
    'level2 name',
    'level3 name',
    'level4 name',
    'level5 name',
    'level6 name',
    'level7 name',
    'level8 name',
    'level9 name',
    'level10 name',
    'level11 name',
  ];

  bool isLoading = false;

  int categoryId = -1;
  String localFileName = '';
  //String assetFileName = '';
  String localVideoPath = '';
  // bool modifiedTextToShow = false;
  // bool modifiedTextToSay = false;
  // bool modifiedCategoryId = false;
  // bool modifiedLocalFileName = false;
  // bool modifiedAssetFileName = false;
  // bool modifiedSoundFileName = false;
  // bool modifiedLocalVideoPath = false;

  bool _isRecording = false;
  String _path;
  // bool _isPlaying = false;
  // StreamSubscription _recorderSubscription;
  // StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSoundPlayer flutterSoundPlayer;
  FlutterSoundRecorder flutterSoundRecorder;

  // String _recorderTxt = '00:00:00';
  // String _playerTxt = '00:00:00';
  // double _dbLevel;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;

  Map<String, String> translations = Map<String, String>();

  List<MCategory> categories = <MCategory>[];
  //MCategory currentCategory;

  MObject mObject;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextEditingController controllerTextToShow = TextEditingController();
  // TextEditingController controllerTextToSay = TextEditingController();
  List<MRelation> objectInFolders;

  // local variables holding the properties of the object:
  String objectAssetFileName = '';
  int objectUseAsset = 1;
  String objectLocalFileName = '';
  int objectIsAvailable = 1;
  String objectTextToShow = '';
  String objectTextToSay = '';
  int objectCategoryId = -1;
  //Color objectBackgroundColor = Colors.white;
  String objectLocalSoundFileName = '';
  int mObjectIsVisible = 0;
  int mObjectIsUnderstood = 0;
  Color backgroundColor = Colors.white;
  int minLevelToShow = 1;

  _EditObjectState(this.onRefreshParentWidget) {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
  }

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      if (mounted) {
        setState(() {});
      }
    });

    flutterSoundPlayer = new FlutterSoundPlayer();

    //flutterSoundPlayer.setSubscriptionDuration(Duration()); //0.01);
    // flutterSoundRecorder.setDbPeakLevelUpdate(0.8);
    // flutterSoundPlayer.setDbLevelEnabled(true);
  }

  Future<void> initialize() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    mObject = await lucasState.getObject(StateProperties.objectToEdit);

    // currentLevel
    currentLevel = await LocalPreferences.getString("currentLevel", "1");

    MCategory mCategory = await MCategory.getByID(mObject.categoryId);
    strNameOfCategory = "";
    if (mCategory != null) strNameOfCategory = mCategory.textToShow;

    Map<String, String> result = await L.getItems(translationItems);

    categories = await MCategory.getAll();

    Color objectBGColor = await getImageBackgroundColor();
    backgroundColor = objectBGColor;

    if (mounted) {
      setState(() {
        translations = result;

        objectAssetFileName = mObject.fileName;
        mObjectIsVisible = mObject.isVisible;
        objectUseAsset = mObject.useAsset;
        objectLocalFileName = mObject.localFileName;
        objectIsAvailable = mObject.isAvailable;
        objectTextToShow = mObject.textToShow;
        objectTextToSay = mObject.textToSay;
        objectCategoryId = mObject.categoryId;
        backgroundColor = objectBGColor;
        minLevelToShow = mObject.minLevelToShow;
        mObjectIsUnderstood = mObject.isUnderstood;
        if (mObject is MSound) {
          MSound mSound = mObject;
          objectLocalSoundFileName = mSound.localSoundFileName;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (translations == null || translations.isEmpty) {
      return Container();
    }

    if (mObject == null) return Container();

    //String textToShow = mObject.textToShow;
    String textToSay = mObject.textToSay;
    String fileName = mObject.fileName;
    String strObjectId = "";
    if (mObject != null) {
      strObjectId = " (ID: " + mObject.id.toString() + ")";
    }
    // controllerTextToShow.text = mObject.textToShow;
    // controllerTextToSay.text = mObject.textToSay;

    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: Colors.grey[350],
        appBar: AppBar(
          title: (translations == null || translations.isEmpty)
              ? Container()
              : Text(translations['edit'] + strObjectId),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: (translations == null || translations.isEmpty)
            ? Container()
            : Column(
                children: <Widget>[
                  workingProgressIndicator(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 1.0,
                            width: 0.0,
                          ),
                          mObject is MEmpty
                              ? Container()
                              : getImageCard(fileName),
                          mObject is MEmpty ? Container() : getBackgroundCard(),
                          mObject is MEmpty
                              ? Container()
                              : getMinLevelToShowCard(),
                          //mObject is MEmpty ? Container() : getCategoryCard(),
                          mObject is MEmpty ? Container() : getTextToShowCard(),
                          mObject is MEmpty
                              ? Container()
                              : getTextToSayCard(textToSay),
                          mObject is MEmpty ? Container() : getSoundCard(),
                          mObject is MEmpty
                              ? Container()
                              : getVideoCard(fileName),
                          mObject is MEmpty ? Container() : getVisibilityCard(),
                          (mObject is MImage ||
                                  mObject is MVideo ||
                                  mObject is MSound)
                              ? getConceptUnderstoodCard()
                              : Container(),
                          (mObject is MImage ||
                                  mObject is MVideo ||
                                  mObject is MSound)
                              ? getIsAvailableCard()
                              : Container(),
                          (mObject is MFolder && currentLevel == '5')
                              ? getSelectDefaultFolderCard()
                              : Container(),
                          getDeleteCard(),
                          //se comento
                          //mObject is MEmpty ? Container() : getShareItem(),
                          // (mObject is MImage ||
                          //         mObject is MVideo ||
                          //         mObject is MSound)
                          //     ? getShareItem()
                          //     : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    if (flutterSoundPlayer != null && flutterSoundPlayer.isPlaying)
      flutterSoundPlayer.stopPlayer();
    if (flutterSoundRecorder != null && flutterSoundRecorder.isRecording)
      flutterSoundRecorder.stopRecorder();
    super.dispose();
  }

  Widget workingProgressIndicator() {
    if (!isLoading) return Container();

    return Container(
      height: Helper.LinearProgressIndicatorHeight,
      child: LinearProgressIndicator(
        value: null,
        valueColor:
            new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget getImageCard(String fileName) {
    Widget objectCard = getObjectCard();

    Widget buttons = Wrap(
      direction: Axis.horizontal,
      spacing: 5.0,
      runSpacing: 5.0,
      children: <Widget>[
        ElevatedButton(
          // shape: RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () async {
            Route route = MaterialPageRoute(
                builder: (context) => ImageSettings(false, false, false, true));
            var result = await Navigator.push(context, route);
            if (mounted) {
              setState(() {
                if (result != null) {
                  objectUseAsset = 1;
                  objectAssetFileName = result.toString();
                }
              });
            }
            await saveObject();
          },
          child: Text(translations['library'].toUpperCase()),
        ),
        ElevatedButton(
          // shape: RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () async {
            PickedFile pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery, maxHeight: 618.0, maxWidth: 618.0);
            File file = File(pickedFile.path);
            if (file != null) {
              // copy file from path to local lucas directory
              File copiedFfile = await file
                  .copy('${Helper.appDirectory}/${file.path.split('/').last}');
              if (copiedFfile != null) {
                localFileName = file.path.split('/').last;

                objectUseAsset = 0;
                objectLocalFileName = localFileName ?? '';

                await saveObject();
              }
            }
          },
          child: Text(translations['local device'].toUpperCase()),
        ),
        ElevatedButton(
          // shape: RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () async {
            PickedFile pickedfile = await ImagePicker().getImage(
                source: ImageSource.camera, maxHeight: 618.0, maxWidth: 618.0);
            if (pickedfile != null) {
              File file = File(pickedfile.path);
              if (file != null) {
                // copy file from path to local lucas directory
                File copiedFfile = await file.copy(
                    '${Helper.appDirectory}/${file.path.split('/').last}');
                if (copiedFfile != null) {
                  localFileName = file.path.split('/').last;

                  objectUseAsset = 0;
                  objectLocalFileName = localFileName ?? '';

                  await saveObject();
                }
              }
            }
          },
          child: Text(translations['camara'].toUpperCase()),
        ),
      ],
    );

    return Card(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              height: MediaQuery.of(context).size.height / 2.5,
              //width: MediaQuery.of(context).size.width / 2.5,
              child: objectCard),
          buttons,
        ],
      ),
    );
  }

  Widget getObjectCard() {
    if (objectAssetFileName.length == 0) return Container();

    Image localImage;
    if (objectUseAsset == 0) {
      File f = File('${Helper.appDirectory}/$objectLocalFileName');
      localImage = Image.file(f);
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        children: <Widget>[
          (objectUseAsset == 0 && localImage == null)
              ? new Container(
                  height: 2.0,
                  child: LinearProgressIndicator(
                    value: null,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                    backgroundColor: Colors.white,
                  ),
                )
              : Container(),
          Expanded(
            flex: currentLevel == "10" ? 1 : Helper.imageFlexSize,
            child: Stack(
              children: <Widget>[
                Center(
                  child: objectUseAsset == 1
                      ? Image.asset(
                                objectAssetFileName,
                              ) !=
                              null
                          ? Image.asset(
                              objectAssetFileName,
                              //height: 50.0,
                            )
                          : Image.asset(Helper.imageNotFound)
                      : localImage == null
                          ? Container()
                          : FadeInImage(
                              fadeInDuration:
                                  Duration(milliseconds: Helper.fadeInDuration),
                              placeholder: MemoryImage(kTransparentImage),
                              //placeholder: kTransparentImage,
                              image: localImage.image,
                            ),
                ),
                objectIsAvailable == 1
                    ? Container()
                    : Center(
                        child: Icon(
                          Icons.not_interested,
                          size: 55.0,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            flex: currentLevel == "10" ? Helper.imageFlexSize : 1,
            child: Text(
              objectTextToShow,
              overflow: currentLevel == "10" ? null : TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: Helper.getFontSize(currentLevel),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getBackgroundCard() {
    Map<int, String> colors = new Map();
    colors[1] = "ef9a9a";
    colors[2] = "f48fb1";
    colors[3] = "ce93d8";
    colors[4] = "b39ddb";
    colors[5] = "9fa8da";
    colors[6] = "90caf9";
    colors[7] = "81d4fa";
    colors[8] = "80deea";
    colors[9] = "80cbc4";
    colors[10] = "a5d6a7";
    colors[11] = "c5e1a5";
    colors[12] = "e6ee9c";
    colors[13] = "fff59d";
    colors[14] = "ffe082";
    colors[15] = "ffcc80";
    colors[16] = "ffffff";

    List<Widget> colorsPalette = <Widget>[];
    colors.forEach(
      (key, value) {
        Widget colorPalette = Container(
          width: 25,
          height: 30.0,
          padding: EdgeInsets.all(1),
          child: MaterialButton(
            padding: EdgeInsets.all(0),
            color: hexToColor('#$value'),
            onPressed: () async {
              // MCategory objectCategory =
              //     await MCategory.getByID(objectCategoryId);
              if (mounted) {
                setState(() {
                  backgroundColor = hexToColor('#$value');
                  //objectCategoryId = -1;
                  // if (objectCategory != null)
                  //   minLevelToShow = objectCategory.minLevelToShow;
                  // else
                  //   minLevelToShow = 1;
                });
              }
              await saveObject();
            },
          ),
        );

        colorsPalette.add(colorPalette);
      },
    );

    final rows = <Widget>[];
    int index = 0;
    int columnIndex = 1;
    Row column;
    List<Widget> cells;
    int gridColumns = 6;

    while (index < colorsPalette.length) {
      Widget widget = colorsPalette[index];

      if (columnIndex == 1) {
        cells = <Widget>[];
      }

      cells.add(widget);

      if (columnIndex >= gridColumns || index == colorsPalette.length - 1) {
        if (index == colorsPalette.length - 1) {
          for (int missing = columnIndex; missing < gridColumns; missing++) {
            cells.add(Container(
              height: Helper.tileHeight(context),
              width: Helper.tileHeight(context),
            ));
          }
        }

        columnIndex = 0;

        column = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: cells,
        );

        rows.add(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: column,
        ));
      }

      index++;
      columnIndex++;
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translations['background color'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // Text(': '),
                // Text(strNameOfCategory)
              ],
            ),
            subtitle: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: rows,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Color> getImageBackgroundColor() async {
    //MCategory objectCategory = await MCategory.getByID(objectCategoryId);

    Color imageBackgroundColor = Colors.white;

    if (mObject.backgroundColor.length > 0) {
      if (mObject.backgroundColor.length > 6) {
        imageBackgroundColor =
            hexToColor('#${mObject.backgroundColor.substring(2)}');
      } else {
        imageBackgroundColor = hexToColor('#${mObject.backgroundColor}');
      }
    }

    // if (objectCategory == null) {
    //   imageBackgroundColor = backgroundColor;
    // }
    // else {
    //   imageBackgroundColor =
    //       Helper.colorFromHex(objectCategory.backgroundColor);
    // }

    return imageBackgroundColor;
  }

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
  // Color hexToColor(String code) {
  //   return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  // }

  Widget getMinLevelToShowCard() {
    List<DropdownMenuItem<int>> items = <DropdownMenuItem<int>>[];
    for (int i = 1; i <= 11; i++) {
      items.add(
        DropdownMenuItem(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                translations['level$i'],
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                translations['level$i name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          value: i,
        ),
      );
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  translations['Minimum level to show'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        //hint: Text("Select Device"),
                        value: minLevelToShow,
                        isDense: true,
                        onChanged: (newValue) async {
                          if (mounted) {
                            setState(() {
                              //if (result != null) {
                              minLevelToShow = newValue;
                              //}
                            });
                          }
                          await saveObject();
                          // await saveChanges(
                          //     'categoryId', newValue.toString());
                        },
                        items: items,
                      ),
                    ),
                  ),
                ),
                // Text(': '),
                // Text(strNameOfCategory)
              ],
            ),
            //subtitle: Text(_strCategoryInstructions),
          ),
        ],
      ),
    );
  }

  Widget getCategoryCard() {
    List<DropdownMenuItem> items = categories.map((MCategory category) {
      return DropdownMenuItem(
        child: new Text(category.textToShow),
        value: category.id,
      );
    }).toList();

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translations['category'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      //hint: Text("Select Device"),
                      value: objectCategoryId,
                      isDense: true,
                      onChanged: (newValue) async {
                        if (mounted) {
                          setState(() {
                            //if (result != null) {
                            objectCategoryId = newValue;
                            //}
                          });
                        }
                        await saveObject();
                        // await saveChanges(
                        //     'categoryId', newValue.toString());
                      },
                      items: items,
                    ),
                  ),
                ),
                // Text(': '),
                // Text(strNameOfCategory)
              ],
            ),
            //subtitle: Text(_strCategoryInstructions),
          ),
        ],
      ),
    );
  }

  Widget getTextToShowCard() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['text to show'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(translations['text to show instructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: TextFormField(
              initialValue: mObject.textToShow,
              onChanged: (text) async {
                if (mounted) {
                  _controller.text = text;
                  setState(() {
                    objectTextToShow = text;
                    objectTextToSay = text;
                  });
                }
                await saveObject();
                //await saveChanges('textToShow', text);
              },
              //style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.all(5.0),
                  hintText: translations['text to show hint']),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTextToSayCard(String textToSay) {
    if (mObject is MSound) {
      return Container();
    }
    if (mObject is MVideo) {
      return Container();
    }
    _controller.text = mObject.textToSay;

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['text to say'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(translations['text to say instructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: TextFormField(
              controller: _controller,
              readOnly: true,
              onChanged: (text) async {

                if (mounted) {
                  _controller.text = text;
                  setState(() {
                    objectTextToSay = text;
                  });
                }
                await saveObject();
                //await saveChanges('textToSay', text);
              },
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.all(5.0),
                  suffix: IconButton(
                    icon: new Icon(
                      Icons.record_voice_over,
                    ),
                    onPressed: () {
                      sayImage();
                    },
                  ),
                  // labelStyle: TextStyle(fontSize: 18.0),
                  // labelText: 'Text to say',
                  hintText: translations['text to say hint']),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSoundCard() {
    bool isSound = (mObject is MSound);
    if (!isSound) {
      return Container();
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['select sound'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(translations['select sound instructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: _isRecording
                      ? BlinkingText(translations['recording'])
                      : Container(
                          width: 1.0,
                          height: 1.0,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            // if (!this._isRecording) {
                            //   return this.startRecorder();
                            // }
                            // this.stopRecorder();
                            MSound mSound = mObject;
                            if (mSound.localSoundFileName.isNotEmpty &&
                                !this._isRecording) {
                              confirmOverwriteSound();
                            } else {
                              if (!this._isRecording) {
                                return this.startRecorder();
                              }
                              this.stopRecorder();
                            }
                          },
                          child: this._isRecording
                              ? Icon(Icons.stop)
                              : Icon(Icons.mic)),
                    ),
                    Container(
                      width: 56.0,
                      height: 56.0,
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              if (this._isRecording) {
                                this.stopRecorder();
                              }

                              startPlayer();
                            },
                            child: Icon(Icons.play_circle_filled),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 56.0,
                    //   height: 56.0,
                    //   child: ClipOval(
                    //     child: TextButton(
                    //       onPressed: () {
                    //         pausePlayer();
                    //       },
                    //       padding: EdgeInsets.all(8.0),
                    //       child: Icon(Icons.pause),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   width: 56.0,
                    //   height: 56.0,
                    //   child: ClipOval(
                    //     child: TextButton(
                    //       onPressed: () {
                    //         stopPlayer();
                    //       },
                    //       padding: EdgeInsets.all(8.0),
                    //       child: Icon(Icons.stop),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getVideoCard(String fileName) {
    bool isVideo = (mObject is MVideo);
    if (!isVideo) {
      return Container();
    }

    MVideo mVideo = mObject;

    Widget buttons = Wrap(
      direction: Axis.horizontal,
      spacing: 5.0,
      runSpacing: 5.0,
      children: <Widget>[
        ElevatedButton(
          // shape: RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () async {
            String path = await _openFileExplorer(FileType.video);
            await saveChanges('localVideoPath', path);
          },
          child: Text(translations['select video'].toUpperCase()),
        ),
      ],
    );

    return Card(
      child: Column(
        children: <Widget>[
          mVideo.localVideoPath.isEmpty
              ? Container()
              : Row(
                  children: <Widget>[
                    Text(translations['selected video']),
                    Text(mVideo.localVideoPath.split('/').last),
                  ],
                ),
          buttons,
        ],
      ),
    );
  }

  Widget getVisibilityCard() {
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
      return mObjectIsVisible == 0 ? Colors.green : Colors.red;
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['visibility'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(translations['visibility instructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: mObjectIsVisible == 1
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            translations['object visible'],
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(translations['object not visible'],
                              style: TextStyle(color: Colors.red)),
                        ),
                ),
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith(getBackgroundColor),
                      ),
                      onPressed: () async {
                        if (mounted) {
                          setState(() {
                            if (mObjectIsVisible == 1)
                              mObjectIsVisible = 0;
                            else
                              mObjectIsVisible = 1;
                          });
                        }
                        await saveObject();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            mObjectIsVisible == 1
                                ? Icon(Icons.lock_outline)
                                : Icon(Icons.lock_open),
                            mObjectIsVisible == 0
                                ? Text(
                                    translations['unlock'],
                                    //style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    translations['lock'],
                                    //style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getConceptUnderstoodCard() {
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
      return mObjectIsUnderstood == 0 ? Colors.green : Colors.red;
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['conceptIsUnderstood'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(translations['conceptIsUnderstoodInstructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: mObjectIsUnderstood == 1
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            translations['is understood'],
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            translations['is not understood'],
                          ),
                        ),
                ),
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith(getBackgroundColor),
                      ),
                      onPressed: () async {
                        if (mounted) {
                          setState(() {
                            if (mObjectIsUnderstood == 1)
                              mObjectIsUnderstood = 0;
                            else
                              mObjectIsUnderstood = 1;
                          });
                        }
                        await saveObject();

                        // if (mounted) {
                        //   setState(() {
                        //     if (mObjectIsUnderstood == 1)
                        //       mObjectIsUnderstood = 0;
                        //     else
                        //       mObjectIsUnderstood = 1;

                        //     saveObject();
                        //   });
                        // }

                        // if (mounted) {
                        //   setState(() {
                        //     isLoading = true;
                        //   });
                        // }
                        // if (mObjectIsUnderstood == 1)
                        //   mObjectIsUnderstood = 0;
                        // else
                        //   mObjectIsUnderstood = 1;

                        // if (mObject is MImage)
                        //   await MImage.updateIsUnderstood(
                        //       mObject.id, mObjectIsUnderstood);
                        // else if (mObject is MFolder)
                        //   await MFolder.updateIsUnderstood(
                        //       mObject.id, mObjectIsUnderstood);
                        // else if (mObject is MVideo)
                        //   await MVideo.updateIsUnderstood(
                        //       mObject.id, mObjectIsUnderstood);
                        // else if (mObject is MSound)
                        //   await MSound.updateIsUnderstood(
                        //       mObject.id, mObjectIsUnderstood);

                        // if (mounted) {
                        //   setState(() {
                        //     mObject = mObject;
                        //   });
                        // }

                        // MRelation relation =
                        //     await MRelation.getByID(mObject.relationId);
                        // MFolder parentFolder =
                        //     await MFolder.getByID(relation.parentFolderId);

                        // await refreshFolder(parentFolder);

                        // if (mounted) {
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        // }
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: mObjectIsUnderstood == 1
                                  ? Icon(Icons.thumb_down)
                                  : Icon(Icons.thumb_up),
                            ),
                            mObjectIsUnderstood == 1
                                ? Text(
                                    translations['not understood'],
                                    //style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    translations['understood'],
                                    //style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getIsAvailableCard() {
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
      return objectIsAvailable == 0 ? Colors.green : Colors.red;
    }

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['item availability'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(translations['item availability instructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: objectIsAvailable == 1
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            translations['is available'],
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            translations['is not available'],
                          ),
                        ),
                ),
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith(getBackgroundColor),
                      ),
                      onPressed: () async {
                        if (mounted) {
                          setState(() {
                            if (objectIsAvailable == 1)
                              objectIsAvailable = 0;
                            else
                              objectIsAvailable = 1;
                          });
                        }
                        await saveObject();

                        // if (mounted) {
                        //   setState(() {
                        //     isLoading = true;
                        //   });
                        // }
                        // if (objectIsAvailable == 1)
                        //   objectIsAvailable = 0;
                        // else
                        //   objectIsAvailable = 1;

                        // if (mObject is MImage)
                        //   await MImage.updateIsAvailable(
                        //       mObject.id, objectIsAvailable);
                        // else if (mObject is MFolder)
                        //   await MFolder.updateIsAvailable(
                        //       mObject.id, objectIsAvailable);
                        // else if (mObject is MVideo)
                        //   await MVideo.updateIsAvailable(
                        //       mObject.id, objectIsAvailable);
                        // else if (mObject is MSound)
                        //   await MSound.updateIsAvailable(
                        //       mObject.id, objectIsAvailable);

                        // if (mounted) {
                        //   setState(() {
                        //     mObject = mObject;
                        //   });
                        // }
                        // MRelation relation =
                        //     await MRelation.getByID(mObject.relationId);
                        // MFolder parentFolder =
                        //     await MFolder.getByID(relation.parentFolderId);

                        // await refreshFolder(parentFolder);

                        // if (mounted) {
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        // }
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: objectIsAvailable == 1
                                  ? Icon(Icons.not_interested)
                                  : Icon(Icons.check),
                            ),
                            objectIsAvailable == 1
                                ? Text(
                                    translations['not available'],
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    translations['available'],
                                    overflow: TextOverflow.ellipsis,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectDefaultFolderCard() {
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
      return Theme.of(context).accentColor;
    }

    Icon icon = Icon(Icons.check_circle_outline);
    String strButton = translations['select folder'].toUpperCase();

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(translations['default folder']),
            subtitle: Text(translations['default folder instructions']),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4.0),
                      //alignment: Alignment(0.0, 0.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              getBackgroundColor),
                        ),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: new BorderRadius.circular(18.0),
                        //   //side: BorderSide(color: Colors.white),// Theme.of(context).primaryColor),
                        // ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 3.0, 0.0),
                              child: icon,
                            ),
                            Text(
                              strButton,
                            ),
                          ],
                        ),
                        onPressed: () async {
                          MFolder mFolder = mObject;
                          selectDefaultFolder(mFolder);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget getShareItem() {
  //   return Card(
  //     child: Column(
  //       children: <Widget>[
  //         ListTile(
  //           title: Text(
  //             translations['share item'],
  //             style: TextStyle(
  //               color: Theme.of(context).primaryColor,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               Column(
  //                 children: <Widget>[
  //                   RaisedButton(
  //                     onPressed: () async {
  //                       //MImage mImage = mObject;

  //                       if (objectUseAsset == 1) {
  //                         final ByteData bytes =
  //                             await rootBundle.load(objectAssetFileName);
  //                         await WcFlutterShare.share(
  //                             sharePopupTitle: objectTextToShow,
  //                             fileName: 'share.png',
  //                             mimeType: 'image/png',
  //                             bytesOfFile: bytes.buffer.asUint8List());
  //                       } else {
  //                         String strBase64 = '';
  //                         File f =
  //                             File('${Helper.appDirectory}/$localFileName');
  //                         FileImage fileImage = FileImage(f);
  //                         strBase64 = Base64Encoder()
  //                             .convert(fileImage.file.readAsBytesSync());

  //                         await WcFlutterShare.share(
  //                           sharePopupTitle: translations['share item'],
  //                           fileName: objectAssetFileName,
  //                           mimeType: 'image/png',
  //                           bytesOfFile: Helper.dataFromBase64String(strBase64),
  //                         );
  //                       }
  //                     },
  //                     child: Container(
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: <Widget>[
  //                           Container(
  //                             padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
  //                             child: Icon(Icons.share),
  //                           ),
  //                           Text(
  //                             translations['share item'],
  //                             overflow: TextOverflow.ellipsis,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<void> saveObject() async {
    //Color objectBGColor = await getImageBackgroundColor();

    // if (mounted) {
    //   setState(() {
    //     backgroundColor = objectBGColor;
    //   });
    // }

    String tableName = '';
    if (mObject is MEmpty) {
      // do nothing
    }

    MObject updateObject;

    if (mObject is MImage) {
      tableName = MImage.TableName;
      MImage entity = new MImage();

      entity.id = mObject.id;
      entity.fileName = objectAssetFileName;
      entity.useAsset = objectUseAsset;
      entity.localFileName = objectLocalFileName;
      entity.isAvailable = objectIsAvailable;
      entity.textToShow = objectTextToShow;
      entity.textToSay = objectTextToSay;
      entity.categoryId = objectCategoryId;
      entity.isVisible = mObjectIsVisible;
      entity.isUnderstood = mObjectIsUnderstood;
      entity.minLevelToShow = minLevelToShow;
      entity.relationId = mObject.relationId;
      entity.backgroundColor = '${backgroundColor.value.toRadixString(16)}';
      await MImage.update(entity);

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      await lucasState.saveObject(StateProperties.objectToEdit, entity);

      updateObject = entity;
    }

    if (mObject is MFolder) {
      tableName = MFolder.TableName;
      MFolder entity = new MFolder();

      entity.id = mObject.id;
      entity.fileName = objectAssetFileName;
      entity.useAsset = objectUseAsset;
      entity.localFileName = objectLocalFileName;
      entity.isAvailable = objectIsAvailable;
      entity.textToShow = objectTextToShow;
      entity.textToSay = objectTextToSay;
      entity.categoryId = objectCategoryId;
      entity.isVisible = mObjectIsVisible;
      entity.isUnderstood = mObjectIsUnderstood;
      entity.minLevelToShow = minLevelToShow;
      entity.relationId = mObject.relationId;
      entity.backgroundColor = '${backgroundColor.value.toRadixString(16)}';
      await MFolder.update(entity);

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      await lucasState.saveObject(StateProperties.objectToEdit, entity);

      updateObject = entity;
    }

    if (mObject is MVideo) {
      tableName = MVideo.TableName;
      MVideo entity = new MVideo();

      entity.id = mObject.id;
      entity.fileName = objectAssetFileName;
      entity.useAsset = objectUseAsset;
      entity.localFileName = objectLocalFileName;
      entity.isAvailable = objectIsAvailable;
      entity.textToShow = objectTextToShow;
      entity.textToSay = objectTextToSay;
      entity.categoryId = objectCategoryId;
      entity.isVisible = mObjectIsVisible;
      entity.isUnderstood = mObjectIsUnderstood;
      entity.minLevelToShow = minLevelToShow;
      entity.relationId = mObject.relationId;
      entity.backgroundColor = '${backgroundColor.value.toRadixString(16)}';
      await MVideo.update(entity);

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      await lucasState.saveObject(StateProperties.objectToEdit, entity);

      updateObject = entity;
    }

    if (mObject is MSound) {
      tableName = MSound.TableName;
      MSound entity = new MSound();

      entity.id = mObject.id;
      entity.fileName = objectAssetFileName;
      entity.useAsset = objectUseAsset;
      entity.localFileName = objectLocalFileName;
      entity.isAvailable = objectIsAvailable;
      entity.textToShow = objectTextToShow;
      entity.textToSay = objectTextToSay;
      entity.categoryId = objectCategoryId;
      entity.localSoundFileName = objectLocalSoundFileName;
      entity.isVisible = mObjectIsVisible;
      entity.isUnderstood = mObjectIsUnderstood;
      entity.minLevelToShow = minLevelToShow;
      entity.relationId = mObject.relationId;
      entity.backgroundColor = '${backgroundColor.value.toRadixString(16)}';
      await MSound.update(entity);

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      await lucasState.saveObject(StateProperties.objectToEdit, entity);

      updateObject = entity;
    }

    String languageCode =
        await LocalPreferences.getString('languageCode', 'en');

    // update translation in database
    await updateTranslation(
        tableName, mObject.id, languageCode, objectTextToShow, objectTextToSay);

    // Translation mTranslation =
    //     await Translation.getLocalized(tableName, mObject.id, languageCode);
    // if (mTranslation != null) {
    //   mTranslation.textToShow = objectTextToShow;
    //   mTranslation.textToSay = objectTextToSay;
    //   await Translation.update(mTranslation);
    // }

    if (updateObject != null) {
      if (mounted) {
        setState(() {
          mObject = updateObject;
        });
      }
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    final file = File('${Helper.appDirectory}/tmp.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Widget getDeleteCard() {
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
      return Colors.red;
    }

    //if (mObject.userCreated == 0) return Container();

    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith(getBackgroundColor),
                      ),
                      onPressed: () async {
                        await confirmDelete();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                            Text(
                              translations['delete'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  selectDefaultFolder(MFolder _selectedFolder) async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int defaultFolderId = _selectedFolder.id;
    await lucasState.saveObject(
        StateProperties.defaultFolderId, defaultFolderId);

    await lucasState.saveObject(StateProperties.parentFolder, _selectedFolder);

    await lucasState.saveObject(StateProperties.currentFolder, _selectedFolder);

    // Set folder visible
    await MFolder.updateIsVisible(_selectedFolder.relationId, 1);
    _selectedFolder.isVisible = 1;
    // MRelation relation = await MRelation.getByID(_selectedFolder.relationId);
    // if (relation != null) {
    //   relation.isVisible = 1;
    //   await MRelation.update(relation);
    //   _selectedFolder.isVisible = 1;
    // }

    await LocalPreferences.setInt('defaultFolderId', defaultFolderId);
    String folderBreadcrumb = await MFolder.getBreadcrumb(defaultFolderId);
    if (folderBreadcrumb.isEmpty) folderBreadcrumb = '/';

    await LocalPreferences.setString(
        StateProperties.folderBreadcrumb, folderBreadcrumb);
    await lucasState.saveObject(
        StateProperties.folderBreadcrumb, folderBreadcrumb);

    await updateLearningObjects(defaultFolderId);
    showOperationSuccessfull();
  }

  updateLearningObjects(int defaultFolderId) async {
    if (context == null) return;

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    String strCurrentLevel =
        await LocalPreferences.getString("currentLevel", "1");
    int currentLevel = int.parse(strCurrentLevel);

    int gridColumns = lucasState.getGridColumns();

    List<MObject> learningObjects = await MRelation.getLearningObjectsInFolder(
        currentLevel, defaultFolderId, gridColumns);
    await lucasState.saveObject(
        StateProperties.learningObjects, learningObjects);

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

  showOperationNotSuccessfull(msg) {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: Text(msg),
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  getObject(int index) async {
    return objectInFolders[index];
  }

  Future<List<MRelation>> getMRelations() async {
    List<MRelation> result;

    if (mObject is MEmpty) {
      MEmpty mEmpty = mObject;
      result = await MRelation.getAllRelationsOfItemId('empty', mEmpty.id);
    }
    if (mObject is MImage) {
      MImage mImage = mObject;
      result = await MRelation.getAllRelationsOfItemId('image', mImage.id);
    }
    if (mObject is MFolder) {
      MFolder mFolder = mObject;
      result = await MRelation.getAllRelationsOfItemId('folder', mFolder.id);
    }
    if (mObject is MVideo) {
      MVideo mVideo = mObject;
      result = await MRelation.getAllRelationsOfItemId('video', mVideo.id);
    }
    if (mObject is MSound) {
      MSound mSound = mObject;
      result = await MRelation.getAllRelationsOfItemId('sound', mSound.id);
    }

    return result;
  }

  Future<void> saveChanges(String field, String text) async {
    /*
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    await lucasState.saveObject(StateProperties.savingEditedObject, true);

    setState(() {
      isLoading = true;
    });

    if (field == 'textToShow') {
      modifiedTextToShow = true;
      textToShow = text;
    }
    if (field == 'textToSay') {
      modifiedTextToSay = true;
      textToSay = text;
    }
    if (field == 'categoryId') {
      modifiedCategoryId = true;
      categoryId = int.parse(text);

      mObject.category = await MCategory.getByID(categoryId);
    }
    if (field == 'assetFileName') {
      modifiedAssetFileName = true;
      assetFileName = text;

      // visually update the object
      if (mObject is MImage) {
        MImage mImage = mObject;
        mImage.useAsset = 1;
        mImage.fileName = assetFileName;
      }
      if (mObject is MVideo) {
        MVideo mVideo = mObject;
        mVideo.useAsset = 1;
        mVideo.fileName = assetFileName;
      }
      if (mObject is MSound) {
        MSound mSound = mObject;
        mSound.useAsset = 1;
        mSound.fileName = assetFileName;
      }
      if (mObject is MFolder) {
        MFolder mFolder = mObject;
        mFolder.useAsset = 1;
        mFolder.fileName = assetFileName;
      }
    }
    if (field == 'localPath') {
      if (text != null && text != '') {
        // copy file from path to local lucas directory
        File file = File(text);
        if (file != null) {
          File copiedFfile =
              await file.copy('${Helper.appDirectory}/${text.split('/').last}');
          if (copiedFfile != null) {
            modifiedLocalFileName = true;
            localFileName = text.split('/').last;

            // visually update the object
            if (mObject is MImage) {
              MImage mImage = mObject;
              mImage.useAsset = 0;
              mImage.localFileName = localFileName;
            }
            if (mObject is MVideo) {
              MVideo mVideo = mObject;
              mVideo.useAsset = 0;
              mVideo.localFileName = localFileName;
            }
            if (mObject is MSound) {
              MSound mSound = mObject;
              mSound.useAsset = 0;
              mSound.localFileName = localFileName;
            }
          }
        }
      }
    }
    if (field == 'audio') {
      if (text != null && text != '') {
        modifiedSoundFileName = true;
        localSoundFileName = text;

        if (mObject is MSound) {
          MSound mSound = mObject;
          mSound.localSoundFileName = localSoundFileName;
        }
      }
    }
    if (field == 'localVideoPath') {
      if (text != null && text != '') {
        modifiedLocalVideoPath = true;
        localVideoPath = text;

        if (mObject is MVideo) {
          MVideo mVideo = mObject;
          mVideo.localVideoPath = localVideoPath;
        }
      }
    }

    String typeOfConcept = '';
    if (mObject is MImage) {
      typeOfConcept = 'image';
      MImage mImage = mObject;
      MImage.update(mImage);
    }
    if (mObject is MVideo) {
      typeOfConcept = 'video';
      MVideo mVideo = mObject;
      MVideo.update(mVideo);
    }
    if (mObject is MSound) {
      typeOfConcept = 'sound';
      MSound mSound = mObject;
      MSound.update(mSound);
    }
    if (mObject is MFolder) {
      typeOfConcept = 'folder';
      MFolder mFolder = mObject;
      MFolder.update(mFolder);
    }

    MRelation relation = await MRelation.getByID(mObject.relationId);
    if (relation == null) {
      List<MRelation> relations =
          await MRelation.getAllRelationsOfItemId(typeOfConcept, mObject.id);
      if (relations.length > 0) relation = relations.first;
    }
    if (relation != null) {
      MFolder parentFolder = await MFolder.getByID(relation.parentFolderId);
      await refreshFolder(parentFolder);
    }

    setState(() {
      isLoading = false;
    });

    await lucasState.saveObject(StateProperties.savingEditedObject, false);
    */
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException {
      //catch (e) {
      // if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  Future<bool> handleBackButton() async {
    // MFolder.clearMemoryTables();
    // MEmpty.clearMemoryTables();
    // MImage.clearMemoryTables();
    // MSound.clearMemoryTables();
    // MVideo.clearMemoryTables();

    await LocalPreferences.setString(
        StateProperties.currentActivity, 'Folders');

    String typeOfConcept = '';
    if (mObject is MFolder) {
      typeOfConcept = 'folder';
    }
    if (mObject is MEmpty) {
      typeOfConcept = 'empty';
    }
    if (mObject is MImage) {
      typeOfConcept = 'image';
    }
    if (mObject is MVideo) {
      typeOfConcept = 'video';
    }
    if (mObject is MSound) {
      typeOfConcept = 'sound';
    }

    MRelation mRelation = await MRelation.getByID(mObject.relationId);
    if (mRelation == null) {
      List<MRelation> relations =
          await MRelation.getAllRelationsOfItemId(typeOfConcept, mObject.id);
      if (relations.length > 0) mRelation = relations.first;
    }
    if (mRelation != null) {
      MFolder parentFolder = await MFolder.getByID(mRelation.parentFolderId);
      await refreshFolder(parentFolder);
    }

    // refresh info
    if (onRefreshParentWidget != null) {
      onRefreshParentWidget(null);
    }

    // Update objects in grid
    if (mRelation != null) {
      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      int gridColumns = lucasState.getGridColumns();
      List<MObject> objects = await MRelation.getObjectsInFolder(
          gridColumns, mRelation.parentFolderId);
      await lucasState.saveObject(StateProperties.gridObjects, objects);
    }

    // Translation tTranslation = await Translation.getByID(23090);
    // MFolder.clearMemoryTables();
    // MFolder tFolder = await MFolder.getByID(107);
    if (context != null) Navigator.pop(context);
    return false;
  }

  void sayImage() async {
    // say out loud
    //if (index == 0) {
    FlutterTts flutterTts = new FlutterTts();
    String languageCountry =
        await LocalPreferences.getString("languageCountry", "");

    bool isLanguageAvailable =
        await flutterTts.isLanguageAvailable(languageCountry);
    String settingsText = await L.item("settings title");

    await flutterTts.isLanguageAvailable(languageCountry);
    if (isLanguageAvailable) {
      await flutterTts.setLanguage(languageCountry);
      //String t = L.word(imageCard.id.toString());

      double ttsSpeed = await LocalPreferences.getDouble("ttsSpeed", 0.5);
      await flutterTts.setSpeechRate(ttsSpeed);

      await flutterTts.speak(objectTextToSay);
    } else {
      if (mounted) {
        final snackBar = SnackBar(
          content: L.getLocalizedText('no voice selected'),
          action: SnackBarAction(
            label: settingsText,
            onPressed: () {
              // open TextToSpeech settings
              Route route =
                  MaterialPageRoute(builder: (context) => TextToSpeech());
              Navigator.push(context, route);
            },
          ),
        );

        if (_scaffoldKey.currentState != null) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //_scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    }
  }

  // Future<bool> _onBackPressed() async {
  //   return true;
  // }

  BoxDecoration myInnerBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.white,
      ),
    );
  }

  BoxDecoration myOuterBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.grey,
      ),
    );
  }

  Future<void> refreshFolder(MFolder folder) async {
    if (context == null) return;

    // Update gridObjects using the objects parentFolder (parameter folder)
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int gridColumns = lucasState.getGridColumns();

    List<MObject> objects =
        await MRelation.getObjectsInFolder(gridColumns, folder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    int currentLearningFolderId =
        await LocalPreferences.getInt('currentLearningFolderId', -2);

    if (currentLearningFolderId == -2) {
      currentLearningFolderId =
          await LocalPreferences.getInt('defaultFolderId', -2);
    }

    await updateLearningObjects(currentLearningFolderId);
  }

  Future<String> _openFileExplorer(FileType _pickingType) async {
    //FileType _pickingType = FileType.IMAGE;
    // if (mObject is MImage) _pickingType = FileType.IMAGE;
    // if (mObject is MVideo) _pickingType = FileType.VIDEO;
    // if (mObject is MSound) _pickingType = FileType.AUDIO;

    String _path = '';
    //String _extension = '';

    try {
      FilePickerResult filePickerResult =
          await FilePicker.platform.pickFiles(type: FileType.any);
      if (filePickerResult != null) {
        PlatformFile file = filePickerResult.files.first;

        _path = file.path;
      }
      // else {
      // User canceled the picker
      // }

      //_path = await FilePicker.platform.pickFiles(type: FileType.any);
      //FilePicker.getFilePath(type: _pickingType); //, fileExtension: _extension);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    return _path;
    // if (!mounted) return;
    // setState(() {
    //   _loadingPath = false;
    //   _fileName = _path.split('/').last;
    // });
  }

  // void _openImageExplorer() async {
  //   setState(() => _loadingPath = true);
  //   try {
  //     _path = await FilePicker.getFilePath(
  //         type: _pickingType, fileExtension: _extension);
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _loadingPath = false;
  //     _fileName = _path.split('/').last;
  //   });
  // }

  Future<void> confirmDelete() async {
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
      return Colors.red;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(translations['delete']),
          content: Column(
            children: <Widget>[
              Text(translations['delete confirmation']),
              (mObject.userCreated == 0)
                  ? Text(
                      translations['warning not user created'],
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : Container(),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith(getBackgroundColor),
              ),
              child: new Text(
                translations['delete'],
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // MRelation relation;
                // if (mObject.relationId != null) {
                //   relation = await MRelation.getByID(mObject.relationId);
                // }

                String typeOfConcept = await Helper.deleteAnObject(mObject);
                /*
                String typeOfConcept = '';
                if (mObject is MFolder) {
                  typeOfConcept = 'folder';
                  MFolder mFolder = mObject;
                  await MFolder.delete(mFolder);
                  
                  await Translation.deleteForObject("folders", mObject.id);
                }

                if (mObject is MEmpty) {
                  typeOfConcept = 'empty';
                  MEmpty mEmpty = mObject;
                  await MEmpty.delete(mEmpty);
                }

                if (mObject is MImage) {
                  typeOfConcept = 'image';
                  MImage mImage = mObject;
                  await MImage.delete(mImage);

                  if (mImage.useAsset == 0) {
                    await Helper.deleteLocalFile(mImage.localFileName);
                  }
                  
                  await Translation.deleteForObject("images", mObject.id);
                }

                if (mObject is MVideo) {
                  typeOfConcept = 'video';
                  MVideo mVideo = mObject;
                  await MVideo.delete(mVideo);

                  if (mVideo.useAsset == 0) {
                    await Helper.deleteLocalFile(mVideo.localFileName);
                  }
                  
                  await Translation.deleteForObject("videos", mObject.id);
                }

                if (mObject is MSound) {
                  typeOfConcept = 'sound';
                  MSound mSound = mObject;
                  await MSound.delete(mSound);

                  if (mSound.useAsset == 0) {
                    await Helper.deleteLocalFile(mSound.localFileName);
                  }
                  
                  await Translation.deleteForObject("sounds", mObject.id);
                }
                */

                MRelation relation =
                    await MRelation.getByID(mObject.relationId);

                List<MRelation> relations =
                    await MRelation.getAllRelationsOfItemId(
                        typeOfConcept, mObject.id);
                for (int i = 0; i < relations.length; i++) {
                  await MRelation.delete(relations[i]);
                }

                final lucasState = PropertyChangeProvider.of<LucasState>(
                        context,
                        listen: false)
                    .value;

                // update environment
                if (relations.length == 1) {
                  relation = relations.first;
                }
                MFolder parentFolder =
                    await MFolder.getByID(relation.parentFolderId);
                await refreshFolder(parentFolder);
                await lucasState.saveObject(
                    StateProperties.currentFolder, parentFolder);
                await lucasState.saveObject(
                    StateProperties.selectedFolder, parentFolder);

                await lucasState.saveObject(
                    StateProperties.selectedImage, null);
                await lucasState.saveObject(
                    StateProperties.selectedVideo, null);
                await lucasState.saveObject(
                    StateProperties.selectedSound, null);
                await lucasState.saveObject(
                    StateProperties.selectedEmpty, null);

                if (onRefreshParentWidget != null) {
                  onRefreshParentWidget(null);
                }

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmOverwriteSound() async {
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
      return Colors.red;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(translations['please confirm']),
          content: Text(translations['replace sound confirmation']),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith(getBackgroundColor),
              ),
              child: new Text(
                translations['replace'],
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                MSound mSound = mObject;

                File f = File(mSound.localSoundFileName);
                if (f != null) f.delete();

                mSound.localSoundFileName = '';

                if (!this._isRecording) {
                  return this.startRecorder();
                }
                this.stopRecorder();
              },
            ),
            TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void startRecorder() async {
    try {
      if (flutterSoundRecorder.isRecording) return;

      Uuid uuid = new Uuid();
      String audioFileName = 'l' + uuid.v1().replaceAll('-', '') + '.aac';
      //String audioPath = '${Helper.appDirectory}/$audioFileName';

      //String path =
      await flutterSoundRecorder.startRecorder(
        toFile: audioFileName,
        // codec: t_CODEC.CODEC_AAC,
        // audioSource: AudioSource.defaultSource,
        // androidEncoder: AndroidEncoder.AAC,
        // androidAudioSource: AndroidAudioSource.MIC,
      );
      // String path = await flutterSound.startRecorder(
      //   Platform.isIOS ? 'ios.aac' : 'android.aac',
      //   androidEncoder: AndroidEncoder.AAC,
      //   androidAudioSource: AndroidAudioSource.MIC,
      // );
      //print('startRecorder: $path');

      if (mounted) {
        setState(() {
          _isRecording = true;
        });
      }
      //_recorderSubscription = flutterSoundRecorder.onRecorderStateChanged.listen((e) {
      /* DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        //String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        String txt = '${date.minute}:${date.second}:${date.millisecond}';
        txt = e.currentPosition.toInt().toString();
        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        }); */
      //});
      // _dbPeakSubscription =
      //     flutterSoundRecorder.onRecorderDbPeakChanged.listen((value) {
      //   print("got update -> $value");
      //   // setState(() {
      //   //   this._dbLevel = value;
      //   // });
      // });

      if (mounted) {
        this.setState(() {
          this._isRecording = true;
          this._path = audioFileName; //path;
        });
      }
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async {
    try {
      if (!flutterSoundRecorder.isRecording) return;

      //String result = await flutterSound.stopRecorder();
      await flutterSoundRecorder.stopRecorder();

      // if (_recorderSubscription != null) {
      //   _recorderSubscription.cancel();
      //   _recorderSubscription = null;
      // }
      // if (_dbPeakSubscription != null) {
      //   _dbPeakSubscription.cancel();
      //   _dbPeakSubscription = null;
      // }

      //await saveChanges('audio', this._path);

      File file = File(_path);
      if (file != null) {
        File copiedFfile =
            await file.copy('${Helper.appDirectory}/${_path.split('/').last}');

        if (copiedFfile != null) {
          localFileName = copiedFfile.path.split('/').last;
          objectLocalSoundFileName = localFileName; //this._path;
          await saveObject();
        }
      }

      // if (mObject is MSound) {
      //   MSound mSound = mObject;
      //   mSound.localSoundFileName = localSoundFileName;
      // }

      if (mounted) {
        this.setState(() {
          this._isRecording = false;
        });
      }
      // print('stopRecorder: $result');
      // print('path: ${this._path}}');
    } catch (err) {
      print('stopRecorder error: $err');
      if (mounted) {
        this.setState(() {
          this._isRecording = false;
        });
      }
    }
  }

  void startPlayer() async {
    try {
      //if (flutterSound.isRecording) return;
      if (flutterSoundPlayer.isPlaying) return;

      String soundFileName = '';
      if (mObject is MSound) {
        soundFileName = '${Helper.appDirectory}/$objectLocalSoundFileName';
      }

      if (soundFileName == '') return;
      //String soundUrl = '${Helper.appDirectory}/$soundFileName';
      await flutterSoundPlayer.startPlayer(fromURI: soundFileName);
      await flutterSoundPlayer.setVolume(1.0);

      /* _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          sliderCurrentPosition = e.currentPosition;
          maxDuration = e.duration;

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          //String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          String txt = date.toIso8601String();
          this.setState(() {
            //this._isPlaying = true;
            this._playerTxt = txt.substring(0, 8);
          });
        }
      }); */
    } catch (err) {
      print('error: $err');
      showOperationNotSuccessfull(err.toString());
      stopPlayer();
    }
  }

  void stopPlayer() async {
    try {
      if (!flutterSoundPlayer.isPlaying) return;

      //String result =
      await flutterSoundPlayer.stopPlayer();
      //print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      if (mounted) {
        this.setState(() {
          //this._isPlaying = false;
        });
      }
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    //String result =
    await flutterSoundPlayer.pausePlayer();
    //print('pausePlayer: $result');
  }

  void resumePlayer() async {
    //String result =
    await flutterSoundPlayer.resumePlayer();
    //print('resumePlayer: $result');
  }

  void seekToPlayer(int milliSecs) async {
    //String result =
    await flutterSoundPlayer.seekToPlayer(Duration(milliseconds: milliSecs));
    //print('seekToPlayer: $result');
  }

  Future<void> updateTranslation(String tableName, int itemId,
      String languageCode, String textToShow, String textToSay) async {
    // update all translations of object in the selected language
    List<Translation> translations =
        await Translation.getAllTranslationsOfObject(tableName, itemId);
    Translation selectedUniqueTranslation;
    int numberOfTranslations = 0;
    for (var t in translations) {
      if (t.language == languageCode) {
        t.textToShow = textToShow;
        t.textToSay = textToSay;
        await Translation.update(t);

        selectedUniqueTranslation = t;
        numberOfTranslations++;
      }
    }

    // if more than one translation exist, delete all but one.
    if (numberOfTranslations > 1) {
      for (var t in translations) {
        if (t.id != selectedUniqueTranslation.id &&
            t.language == languageCode) {
          await Translation.deleteById(t.id);
        }
      }
    }

    // If no translations exist, create one
    if (numberOfTranslations == 0) {
      Translation entity = Translation(
        tableName: tableName,
        itemId: itemId,
        language: languageCode,
        textToShow: textToShow,
        textToSay: textToSay,
      );

      await Translation.create(entity);
    }
  }
}
