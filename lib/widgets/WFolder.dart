// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/screens/TextToSpeech.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transparent_image/transparent_image.dart';

class WFolder extends StatefulWidget {
  final MFolder mFolder;
  final String currentLevel;
  //final bool isEditMode;
  final ValueChanged<MObject> _onItemTap; // callback for tapping a folder
  final ValueChanged<MObject>
      onItemDoubleTap; // callback for double tapping a folder
  final ValueChanged<MObject>
      onItemLongPress; // callback for long pressing a folder

  WFolder(this.mFolder, this.currentLevel, this._onItemTap,
      this.onItemDoubleTap, this.onItemLongPress,
      {Key key})
      : super(key: key);

  @override
  _WFolderState createState() {
    // SharedPreferences.getInstance().then((prefs) {
    //   //bool darkMode = prefs.getBool('darkMode') ?? true;
    //   String languageCode = prefs.getString('languageCode') ?? "en";

    // });

    return _WFolderState(this.mFolder, this.currentLevel, this._onItemTap,
        this.onItemDoubleTap, this.onItemLongPress);
    //   //true,
    //   'en',
    // );
  }
}

class _WFolderState extends State<WFolder> {
  MFolder mFolder;
  String currentLevel;
  //bool isEditMode;
  final ValueChanged<MObject> _onItemTap; // callback for on item Tap
  final ValueChanged<MObject>
      _onItemDoubleTap; // callback for double tapping a folder
  final ValueChanged<MObject> onItemLongPress; // callback for updating folder
  Image localImage;

  _WFolderState(this.mFolder, this.currentLevel, this._onItemTap,
      this._onItemDoubleTap, this.onItemLongPress);

  @override
  Widget build(BuildContext context) {
    // return PropertyChangeConsumer<LucasState>(
    //   properties: [
    //     StateProperties.isEditMode,
    //   ],
    //   builder: (context, model, property) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    bool isEditMode = lucasState.getObject(StateProperties.isEditMode);
    return GestureDetector(
      //onTap: () => onCardTap(context, mFolder, currentLevel),
      onTap: () {
        onFolderTap(context, mFolder, currentLevel);
      },
      onDoubleTap: () {
        onFolderDoubleTap(context, mFolder, currentLevel);
      },
      onLongPress: () {
        onFolderLongPress(context, mFolder, currentLevel);
      },
      // onLongPressUp: () => onDoubleTap(context, mFolder, currentLevel),
      child: Container(
        height: Helper.tileHeight(context),

        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment(200, 200),
              image: AssetImage('assets/App/blocked.png'),
              fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: BoxDecoration(),
        child: Center(
          child: Opacity(
            opacity: getOpacity(isEditMode),
            child: Container(
              //constraints: BoxConstraints.expand(),
              margin: const EdgeInsets.all(1.0),
              //decoration: myOuterBoxDecoration(isEditMode), //
              child: Container(
                decoration: myInnerBoxDecoration(isEditMode), //
                child: Container(
                  decoration: BoxDecoration(
                    //color: Helper.colorFromHex(mFolder.category.backgroundColor),
                    color: getFolderBackgroundColor(isEditMode),
                    //color: Colors.white,
                  ),
                  child: getFolderImage(isEditMode),
                ),
              ),
            ),
          ),
          //),
        ),
      ),
    );
    //   },
    // );
  }

  Widget getFolderImage(bool isEditMode) {
    bool isMFolderEmpty = false;
    if (mFolder == null) isMFolderEmpty = true;
    if (mFolder != null && mFolder.fileName == null) isMFolderEmpty = true;

    if (mFolder.useAsset == 0) {
      File f = File('${Helper.appDirectory}/${mFolder.localFileName}');
      localImage = Image.file(f);
    }

    return Container(
      //height: 50.0,
      // foregroundDecoration: BoxDecoration(
      //   color: overlayColor,
      //   backgroundBlendMode: BlendMode.saturation,
      // ),
      child: isMFolderEmpty
          ? CircularProgressIndicator()
          : Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: (Helper.tileHeight(context) - 10) / 1.5,
                      height: Helper.tileHeight(context) / 10,
                      color: Colors.white,
                    ),
                    ClipRRect(
                      // borderRadius:
                      //     BorderRadius.only(topLeft: Radius.circular(40)),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        width: 10,
                        height: Helper.tileHeight(context) / 10,
                        //color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                (mFolder.useAsset == 0 && localImage == null)
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: mFolder.useAsset == 1
                              ? Image.asset(
                                        mFolder.fileName,
                                      ) !=
                                      null
                                  ? Image.asset(
                                      mFolder.fileName,
                                      //height: 50.0,
                                    )
                                  : Image.asset(Helper.imageNotFound)
                              : localImage == null
                                  ? Container()
                                  : FadeInImage(
                                      fadeInDuration: Duration(
                                          milliseconds: Helper.fadeInDuration),
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      //placeholder: kTransparentImage,
                                      image: localImage.image,
                                    ),
                        ),
                        mFolder.isAvailable == 1
                            ? Container()
                            : Center(
                                child: Icon(
                                  Icons.not_interested,
                                  size: Helper.tileHeight(context) - 6,
                                  color: Colors.red,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: currentLevel == "10" ? Helper.imageFlexSize : 2,
                  child: Text(
                    mFolder.textToShow,
                    overflow:
                        currentLevel == "10" ? null : TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Helper.getFontSize(currentLevel),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    mFolder.minLevelToShow > 1 && isEditMode
                        ? Text(
                            mFolder.minLevelToShow.toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.white,
                              fontSize: Helper.getFontSize(currentLevel),
                            ),
                          )
                        : Container()
                  ],
                )
              ],
            ),
    );

    /* if (mFolder == null) {
      return Container(
        width: 0.0,
        height: 0.0,
      );
    }

    if (mFolder.useAsset == 0) {
      File f = File('${Helper.appDirectory}/${mFolder.localFileName}');
      localImage = Image.file(f);

      //   Helper.imageMap[mImage.id] = localImage;
      // }
    }

    return mFolder.fileName.isEmpty
        ? Container(
            width: 0.0,
            height: 0.0,
          )
        : Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Expanded(
                  flex: currentLevel == "10" ? 1 : Helper.imageFlexSize,
                  child: 
                  (mFolder.useAsset == 0 && localImage == null)
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
                      // Image.asset(
                      //       mFolder.fileName,
                      //       //fit: BoxFit.cover,
                      //       // width: 200.0,
                      //       // height: 100.0,
                      //     ) !=
                      //     null
                      // ? Image.asset(
                      //     mFolder.fileName,
                      //     //fit: BoxFit.cover,
                      //     // width: 200.0,
                      //     // height: 100.0,
                      //   )
                      // : Image.asset(Helper.imageNotFound),
                ),
                Expanded(
                  flex: currentLevel == "10" ? 6 - Helper.imageFlexSize : 1,
                  child: Text(
                        (Helper.debugMode ? " (${mFolder.id}) " : "") +
                            mFolder.textToShow,
                        overflow: currentLevel == "10"
                            ? null
                            : TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Helper.getFontSize(currentLevel),
                        )),
                )
              ]); */
  }

  double getOpacity(bool isEditMode) {
    if (mFolder.isVisible == 0 && !isEditMode) {
      return 0.0;
    }
    if (mFolder.isVisible == 1 && !isEditMode) {
      return 1.0;
    }
    if (mFolder.isVisible == 0 && isEditMode) {
      return 0.2;
    }
    if (mFolder.isVisible == 1 && isEditMode) {
      return 1.0;
    }
    return 1.0;
  }

  Color getOverlayForegroundColor(bool isEditMode) {
    if (mFolder.isVisible == 1) {
      return Colors.transparent;
    } else {
      if (isEditMode)
        return Colors.grey;
      else
        return Colors.transparent;
    }
  }

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  Color getFolderBackgroundColor(bool isEditMode) {
    Color folderBackgroundColor = Colors.white;

    if (mFolder.backgroundColor.length > 0) {
      if (mFolder.backgroundColor.length > 6) {
        folderBackgroundColor =
            hexToColor('#${mFolder.backgroundColor.substring(2)}');
      } else {
        folderBackgroundColor = hexToColor('#${mFolder.backgroundColor}');
      }
    }

    if (mFolder.isVisible == 0 && !isEditMode)
      folderBackgroundColor = Colors.transparent;

    return folderBackgroundColor;
  }

  onFolderLongPress(
      BuildContext context, MFolder mFolder, String currentLevel) async {
    if (onItemLongPress != null) {
      onItemLongPress(mFolder);
    }
  }

  onFolderTap(
      BuildContext context, MFolder mFolder, String currentLevel) async {
    if (Helper.folderShouldTalk) {
      await sayFolder();
    }

    if (_onItemTap != null) {
      _onItemTap(mFolder);
    }
  }

  onFolderDoubleTap(
      BuildContext context, MFolder mFolder, String currentLevel) async {

    if (_onItemTap != null) {
      _onItemDoubleTap(mFolder);
    }
  }

  onDoubleTap(
      BuildContext context, MFolder mFolder, String currentLevel) async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    lucasState.saveObject(StateProperties.currentFolderId, mFolder.id);
  }

  sayFolder() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    bool isEditMode = lucasState.getObject(StateProperties.isEditMode);
    if (isEditMode) return;

    FlutterTts flutterTts = new FlutterTts();
    String languageCountry =
        await LocalPreferences.getString("languageCountry", "");

    bool isLanguageAvailable =
        await flutterTts.isLanguageAvailable(languageCountry);
    //String settingsText = await L.item("settings title");

    await flutterTts.isLanguageAvailable(languageCountry);
    if (isLanguageAvailable) {
      await flutterTts.setLanguage(languageCountry);

      double ttsSpeed = await LocalPreferences.getDouble("ttsSpeed", 0.5);
      await flutterTts.setSpeechRate(ttsSpeed);

      await flutterTts.speak(mFolder.textToSay);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: L.getText('no valid voice found'),
            content: SingleChildScrollView(
              child: L.getText('no voice selected'),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: L.getUpperText('settings title'),
                onPressed: () {
                  Navigator.of(context).pop();

                  // open TextToSpeech settings
                  Route route =
                      MaterialPageRoute(builder: (context) => TextToSpeech());
                  Navigator.push(context, route);
                },
              ),
            ],
          );
        },
      );
    }
  }

  BoxDecoration myInnerBoxDecoration(bool isEditMode) {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: (mFolder.isVisible == 0 && !isEditMode)
            ? Colors.transparent
            : Colors.white,
      ),
    );
  }

  BoxDecoration myOuterBoxDecoration(bool isEditMode) {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: (mFolder.isVisible == 0 && !isEditMode)
            ? Colors.transparent
            : Colors.grey,
      ),
    );
  }
}
