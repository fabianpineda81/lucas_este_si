// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/screens/TextToSpeech.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transparent_image/transparent_image.dart';

class WSound extends StatefulWidget {
  bool ignoreVisibility;
  MSound mSound;
  String currentLevel = "1";
  //bool isEditMode = false;
  ValueChanged<MObject> onItemTap; // callback for tapping a folder
  ValueChanged<MObject> onItemDoubleTap; // callback for double tapping a folder
  ValueChanged<MObject> onItemLongPress; // callback for updating folder

  WSound(ignoreVisibility, mSound, currentLevel, onItemTap, onItemDoubleTap,
      onItemLongPress,
      {Key key})
      : super(key: key) {
    this.ignoreVisibility = ignoreVisibility;
    this.mSound = mSound;
    this.currentLevel = currentLevel;
    //this.isEditMode = isEditMode;
    this.onItemTap = onItemTap;
    this.onItemDoubleTap = onItemDoubleTap;
    this.onItemLongPress = onItemLongPress;
  }

  // WSound.emptyConstructor(
  //     isEditMode, onItemTap, onItemDoubleTap, onItemLongPress,
  //     {Key key})
  //     : super(key: key) {
  //   this.isEditMode = isEditMode;
  //   this.onItemTap = onItemTap;
  //   this.onItemDoubleTap = onItemDoubleTap;
  //   this.onItemLongPress = onItemLongPress;
  // }

  @override
  _WSoundState createState() {
    // SharedPreferences.getInstance().then((prefs) {
    //   //bool darkMode = prefs.getBool('darkMode') ?? true;
    //   String languageCode = prefs.getString('languageCode') ?? "en";
    //   return _WSoundState(
    //     //darkMode,
    //     languageCode,
    //   );
    // });
    return _WSoundState(
      this.ignoreVisibility,
      this.mSound,
      this.currentLevel,
      //this.isEditMode,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
    );
    //_WSoundState.setMSound(mSound);
    //return _WSoundState;
    //   //true,
    //   'en',
    // );
  }

  // setMSound(MSound mSound) {
  //   this.mSound = mSound;
  // }
}

class _WSoundState extends State<WSound> {
  bool ignoreVisibility;
  MSound mSound;
  String currentLevel = "1";
  Image localImage;

  ValueChanged<MObject> onItemTap; // callback for tapping a folder
  ValueChanged<MObject> onItemDoubleTap; // callback for double tapping a folder
  ValueChanged<MObject> onItemLongPress; // callback for updating folder

  _WSoundState(
    this.ignoreVisibility,
    this.mSound,
    this.currentLevel,
    //this.isEditMode,
    this.onItemTap,
    this.onItemDoubleTap,
    this.onItemLongPress,
  );

  @override
  void initState() {
    super.initState();

    if (mSound.useAsset == 0) {
      File f = File('${Helper.appDirectory}/${mSound.localFileName}');
      localImage = Image.file(f);
    }

    // if (mSound.useAsset == 0) {
    //   if (mSound.strBase64.isNotEmpty) {
    //     localImage = Image.memory(Base64Decoder().convert(mSound.strBase64));
    //   }
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (mSound.useAsset == 0) {
    //   if (localImage != null) {
    //     precacheImage(localImage.image, context);
    //   }
    // }
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
    Widget cardSound = getCardSound(overlayColor, opacity, isEditMode);

    return GestureDetector(
      onTap: () => onSoundTap(context, mSound, currentLevel),
      onDoubleTap: () => onSoundDoubleTap(context, mSound, currentLevel),
      onLongPress: () {
        onSoundLongPress(context, mSound, currentLevel);
      },
      child: Container(
        height: Helper.tileHeight(context),
        width: Helper.tileHeight(context),
        //constraints: BoxConstraints.expand(),
        margin: const EdgeInsets.all(1.0),
        decoration: myOuterBoxDecoration(isEditMode), //
        child: Container(
          decoration: myInnerBoxDecoration(isEditMode), //
          child: Container(
            decoration: BoxDecoration(
              color: getSoundBackgroundColor(isEditMode),
            ),
            child: cardSound,
          ),
        ),
      ),
    );
    //   },
    // );
  }

  Widget getCardSound(Color overlayColor, double opacity, bool isEditMode) {
    bool isMSoundEmpty = false;
    if (mSound == null) isMSoundEmpty = true;
    if (mSound != null && mSound.fileName == null) isMSoundEmpty = true;

    return Container(
      decoration: opacity != 1.0 ? BoxDecoration(
        image: DecorationImage(
          alignment: Alignment(200, 200),
          image: AssetImage('assets/App/blocked.png'),
          fit: BoxFit.cover,
        ),
      ) : BoxDecoration(),
      foregroundDecoration: BoxDecoration(
        color: overlayColor,
        backgroundBlendMode: BlendMode.saturation,
      ),
      child: Opacity(
        opacity: opacity,
        child: isMSoundEmpty
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  (mSound.useAsset == 0 && localImage == null)
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
                          child: mSound.useAsset == 1
                              ? Image.asset(
                                        mSound.fileName,
                                      ) !=
                                      null
                                  ? Image.asset(
                                      mSound.fileName,
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
                        Center(
                          child: Opacity(
                            opacity: 0.6,
                            child: Image.asset('assets/images/new_sound.png'),
                          ),
                        ),
                        mSound.isAvailable == 1
                            ? Container()
                            : Center(
                                child: Icon(
                                  Icons.not_interested,
                                  size: Helper.tileHeight(context)-6,
                                  color: Colors.red,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: currentLevel == "10" ? Helper.imageFlexSize : 2,
                    child: Text(
                      mSound.textToShow,
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
                      mSound.minLevelToShow > 1 && isEditMode
                          ? Text(
                              mSound.minLevelToShow.toString(),
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

  double getOpacity(bool isEditMode) {
    if (mSound.isVisible == 1 || ignoreVisibility) {
      return 1.0;
    }

    if (isEditMode)
      return 0.2;
    else
      return 0.0;
  }

  Color getOverlayForegroundColor(bool isEditMode) {
    if (mSound.isVisible == 1 || ignoreVisibility) {
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

  Color getSoundBackgroundColor(bool isEditMode) {
    Color soundBackgroundColor = Colors.white;

    if (mSound.backgroundColor.length > 0) {
      if (mSound.backgroundColor.length > 6) {
        soundBackgroundColor =
            hexToColor('#${mSound.backgroundColor.substring(2)}');
      } else {
        soundBackgroundColor = hexToColor('#${mSound.backgroundColor}');
      }
    }

    if (mSound.isVisible == 0 && !isEditMode && !ignoreVisibility)
      soundBackgroundColor = Colors.transparent;

    return soundBackgroundColor;
  }

  onSoundTap(
      BuildContext context, MSound soundCard, String currentLevel) async {
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

          await flutterTts.speak(soundCard.textToSay);
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
      onItemTap(soundCard);
    }
  }

  onSoundDoubleTap(
      BuildContext context, MSound mSound, String currentLevel) async {
    //if (isEditMode) {
    if (onItemLongPress != null) {
      onItemDoubleTap(mSound);
    }
    //}
  }

  onSoundLongPress(
      BuildContext context, MSound mSound, String currentLevel) async {
    //if (isEditMode) {
    if (onItemLongPress != null) {
      onItemLongPress(mSound);
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
        width: (mSound.isVisible == 0 && !isEditMode && ignoreVisibility)
            ? 1
            : (mSound.isVisible == 0 && !isEditMode && ignoreVisibility)
                ? 1
                : mSound.isUnderstood == 1 ? 2 : 1,
        //1,
        color: (mSound.isVisible == 0 && !isEditMode && ignoreVisibility)
            ? Colors.transparent
            : (mSound.isVisible == 0 && !isEditMode && ignoreVisibility)
                ? Colors.transparent
                : mSound.isUnderstood == 1
                    ? Colors.greenAccent[700]
                    : Colors.white,
        //Colors.grey,
      ),
    );
  }
}
