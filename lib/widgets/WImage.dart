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
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/screens/TextToSpeech.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transparent_image/transparent_image.dart';

class WImage extends StatefulWidget {
  bool ignoreVisibility;
  MImage mImage;
  String currentLevel = "1";
  //bool isEditMode = false;
  ValueChanged<MObject> onItemTap; // callback for tapping a folder
  ValueChanged<MObject> onItemDoubleTap; // callback for double tapping a folder
  ValueChanged<MObject> onItemLongPress; // callback for updating folder

  WImage(ignoreVisibility, mImage, currentLevel, onItemTap, onItemDoubleTap,
      onItemLongPress,
      {Key key})
      : super(key: key) {
    this.ignoreVisibility = ignoreVisibility;
    this.mImage = mImage;
    this.currentLevel = currentLevel;
    //this.isEditMode = isEditMode;
    this.onItemTap = onItemTap;
    this.onItemDoubleTap = onItemDoubleTap;
    this.onItemLongPress = onItemLongPress;
  }

  // WImage.emptyConstructor(
  //     isEditMode, onItemTap, onItemDoubleTap, onItemLongPress,
  //     {Key key})
  //     : super(key: key) {
  //   this.isEditMode = isEditMode;
  //   this.onItemTap = onItemTap;
  //   this.onItemDoubleTap = onItemDoubleTap;
  //   this.onItemLongPress = onItemLongPress;
  // }

  @override
  _WImageState createState() {
    // SharedPreferences.getInstance().then((prefs) {
    //   //bool darkMode = prefs.getBool('darkMode') ?? true;
    //   String languageCode = prefs.getString('languageCode') ?? "en";
    //   return _WImageState(
    //     //darkMode,
    //     languageCode,
    //   );
    // });
    return _WImageState(
      this.ignoreVisibility,
      this.mImage,
      this.currentLevel,
      //this.isEditMode,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
    );
    //_wImageState.setMImage(mImage);
    //return _wImageState;
    //   //true,
    //   'en',
    // );
  }

  // setMImage(MImage mImage) {
  //   this.mImage = mImage;
  // }
}

class _WImageState extends State<WImage> {
  //bool dummyVar = false;
  bool ignoreVisibility;
  //bool mImageLoaded = false;
  MImage mImage;
  //WImage wImage = WImage.emptyConstructor();
  String currentLevel = "1";
  //bool isEditMode;
  Image localImage;

  ValueChanged<MObject> onItemTap; // callback for tapping a folder
  ValueChanged<MObject> onItemDoubleTap; // callback for double tapping a folder
  ValueChanged<MObject> onItemLongPress; // callback for updating folder

  _WImageState(
    this.ignoreVisibility,
    this.mImage,
    this.currentLevel,
    //this.isEditMode,
    this.onItemTap,
    this.onItemDoubleTap,
    this.onItemLongPress,
  );

  bool pressed = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
    Color overlayColor = getOverlayForegroundColor(isEditMode);
    double opacity = getOpacity(isEditMode);
    Widget cardImage = getCardImage(overlayColor, opacity, isEditMode);

    return GestureDetector(
      onTap: () => onTap(mImage, currentLevel),
      onDoubleTap: () => onTap(mImage, currentLevel),
      onLongPress: () => onLongPress(mImage, currentLevel),
      child: Container(
        height: ignoreVisibility && this.currentLevel == "1"
            ? MediaQuery.of(context).size.height / 2
            : (ignoreVisibility && this.currentLevel != "1")
                ? null
                : Helper.tileHeight(context),
        width: ignoreVisibility ? null : Helper.tileHeight(context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: getImageBackgroundColor(isEditMode),
            border: Border.all(
                color: pressed && int.parse(this.currentLevel) < 4 ? Colors.green : Colors.white,
                width: pressed ? 3.0 : 3.0)),
        child: Container(
          decoration: myInnerBoxDecoration(isEditMode),
          child: Container(
            height: Helper.voiceBoxHeight,
            decoration: BoxDecoration(
              color: getImageBackgroundColor(isEditMode),
            ),
            child: cardImage,
          ),
        ),
      ),
    );
    //   },
    // );
  }

  Widget getCardImage(Color overlayColor, double opacity, bool isEditMode) {
    bool isMImageEmpty = false;
    if (mImage == null) isMImageEmpty = true;
    if (mImage != null && mImage.fileName == null) isMImageEmpty = true;

    if (mImage.useAsset == 0) {
      File f = File('${Helper.appDirectory}/${mImage.localFileName}');
      localImage = Image.file(f);
    }

    return Container(
      decoration: opacity != 1.0
          ? BoxDecoration(
              image: DecorationImage(
                alignment: Alignment(200, 200),
                image: AssetImage('assets/App/blocked.png'),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(),
      foregroundDecoration: BoxDecoration(
        color: overlayColor,
        //backgroundBlendMode: BlendMode.saturation,
      ),
      child: Opacity(
        opacity: opacity,
        child: isMImageEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  (mImage.useAsset == 0 && localImage == null)
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
                    //flex: 1, //nelson
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: mImage.useAsset == 1
                              ? Image.asset(
                                        mImage.fileName,
                                      ) !=
                                      null
                                  ? getImage(mImage.fileName)
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
                        mImage.isAvailable == 1
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
                  Expanded(
                    flex: currentLevel == "10" ? Helper.imageFlexSize : 2,
                    child: Text(
                      mImage.textToShow,
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
                      mImage.minLevelToShow > 1 && isEditMode
                          ? Text(
                              mImage.minLevelToShow.toString(),
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
      ),
    );
  }

  getImage(path) {
    return Image.asset(
      path,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(Helper.imageNotFound);
      },
    );
  }

  double getOpacity(bool isEditMode) {
    if (mImage.isVisible == 1 || ignoreVisibility) {
      return 1.0;
    }

    if (isEditMode)
      return 0.2;
    else
      return 0.0;
  }

  Color getOverlayForegroundColor(bool isEditMode) {
    if (mImage.isVisible == 1 || ignoreVisibility) {
      return Colors.transparent;
    } else {
      if (isEditMode)
        return Colors.transparent;
      else
        return Colors.transparent;
    }
  }

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  Color getImageBackgroundColor(bool isEditMode) {
    Color imageBackgroundColor = Colors.white;

    if (mImage.backgroundColor.length > 0) {
      if (mImage.backgroundColor.length > 6) {
        imageBackgroundColor =
            hexToColor('#${mImage.backgroundColor.substring(2)}');
      } else {
        imageBackgroundColor = hexToColor('#${mImage.backgroundColor}');
      }
    }

    if (mImage.isVisible == 0 && !isEditMode && !ignoreVisibility)
      imageBackgroundColor = Colors.transparent;

    return imageBackgroundColor;
  }

  onTap(
      //BuildContext context,
      MImage imageCard,
      String currentLevel) async {
    setState(() {
      pressed = true;
    });
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    bool isEditMode = lucasState.getObject(StateProperties.isEditMode);
    if (!isEditMode) {
      // Immediate voice feedback is provided only for level 1-3
      if (currentLevel == '1' || currentLevel == '2' || currentLevel == '3') {
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
          await flutterTts.speak(imageCard.textToSay);
          await Future.delayed(const Duration(milliseconds: 1200));
          setState(() {
            pressed = false;
          });
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
                      Route route = MaterialPageRoute(
                          builder: (context) => TextToSpeech());
                      Navigator.push(context, route);
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }

    if (onItemTap != null) {
      onItemTap(imageCard);
    }
  }

  onDoubleTap(MImage mImage, String currentLevel) async {
    if (onItemLongPress != null) {
      onItemDoubleTap(mImage);
    }
  }

  onLongPress(MImage mImage, String currentLevel) async {
    //if (isEditMode) {
    if (onItemLongPress != null) {
      onItemLongPress(mImage);
    }
    //}
  }

  BoxDecoration myInnerBoxDecoration(bool isEditMode) {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.transparent,
        // (mSound.isVisible == 0 && !isEditMode && ignoreVisibility)
        //     ? Colors.transparent
        //     : mSound.isUnderstood == 1 ? Colors.greenAccent : Colors.white,
      ),
    );
  }

  BoxDecoration myOuterBoxDecoration(bool isEditMode) {
    return BoxDecoration(
      border: Border.all(
        width: (mImage.isVisible == 0 && !isEditMode && ignoreVisibility)
            ? 1
            : (mImage.isVisible == 0 && !isEditMode && ignoreVisibility)
                ? 1
                : mImage.isUnderstood == 1
                    ? 2
                    : 1,
        //1,
        color: (mImage.isVisible == 0 && !isEditMode && ignoreVisibility)
            ? Colors.transparent
            : (mImage.isVisible == 0 && !isEditMode && ignoreVisibility)
                ? Colors.transparent
                : mImage.isUnderstood == 1
                    ? Colors.greenAccent[700]
                    : Colors.white,
        //Colors.grey,
      ),
    );
  }
}
