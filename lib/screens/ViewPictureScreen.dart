import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/Translation.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transparent_image/transparent_image.dart';

import 'EditObject.dart';
import 'LearnScreen.dart';
import 'TextToSpeech.dart';

class ViewPictureResult {
  //String stringBase64;
}

class ViewPictureScreen extends StatefulWidget {
  final bool selectFirstReinforcer;
  final bool selectSecondReinforcer;
  final bool selectThirdReinforcer;
  final bool isSelectingObject;
  final bool findInAssetLibrary;

  final MImage imageCard;

  ViewPictureScreen(
      this.imageCard,
      this.selectFirstReinforcer,
      this.selectSecondReinforcer,
      this.selectThirdReinforcer,
      this.findInAssetLibrary,
      this.isSelectingObject);

  @override
  _ViewPictureScreenState createState() => _ViewPictureScreenState(
      this.imageCard,
      this.selectFirstReinforcer,
      this.selectSecondReinforcer,
      this.selectThirdReinforcer,
      this.findInAssetLibrary,
      this.isSelectingObject);
}

class _ViewPictureScreenState extends State<ViewPictureScreen> {
  bool selectFirstReinforcer = false;
  bool selectSecondReinforcer = false;
  bool selectThirdReinforcer = false;
  bool findInAssetLibrary = false;
  final bool isSelectingObject;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //bool _isSaving = false;
  GlobalKey _globalKey = new GlobalKey();
  final MImage imageCard;

  _ViewPictureScreenState(
      this.imageCard,
      this.selectFirstReinforcer,
      this.selectSecondReinforcer,
      this.selectThirdReinforcer,
      this.findInAssetLibrary,
      this.isSelectingObject);

  // @override
  // void initState() {
  //   super.initState();

  //   initialize().then((result) {
  //     setState(() {});
  //   });
  // }

  // Future<void> initialize() async {
  //   //await getObjects('');

  //   final lucasState = PropertyChangeProvider.of<LucasState>(context).value;
  //   findInAssetLibrary = await lucasState.getObject(StateProperties.findInAssetLibrary) ?? false;
  // }

  @override
  Widget build(BuildContext context) {
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

    Color getTextColor(Set<MaterialState> states) {
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
      return Colors.white;
    }

    //final items = <BottomNavigationBarItem>[];

    bool selectingReinforcer = selectFirstReinforcer ||
        selectSecondReinforcer ||
        selectThirdReinforcer;

    // if (selectingReinforcer) {
    //   items.add(
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.check,
    //         color: Theme.of(context).primaryColor,
    //       ),
    //       title: L.getLocalizedText('select reinforcer'),
    //     ),
    //   );
    // }

    // items.add(
    //   BottomNavigationBarItem(
    //     icon: new Icon(
    //       Icons.record_voice_over,
    //       color: Theme.of(context).primaryColor,
    //     ),
    //     title: L.getLocalizedText("say"),
    //   ),
    // );

    // if (!selectingReinforcer) {
    //   items.add(
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.email,
    //         color: Theme.of(context).primaryColor,
    //       ),
    //       title: L.getLocalizedText("send by email"),
    //     ),
    //   );
    // }

    Image localImage;
    if (imageCard.useAsset == 0) {
      File f = File('${Helper.appDirectory}/${imageCard.localFileName}');
      localImage = Image.file(f);
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          //backgroundColor: Colors.grey[350],
          appBar: AppBar(
            title: Text(imageCard.textToShow),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              Helper.debugMode
                  ? TextButton(
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await showConceptInfo(imageCard);
                      },
                    )
                  : Container(),
              // IconButton(
              //   icon: new Icon(
              //     Icons.refresh,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {},
              // ),
              // selectingReinforcer
              //     ? IconButton(
              //         icon: new Icon(
              //           Icons.check_circle_outline,
              //         ),
              //         onPressed: () {
              //           confirmReinforcer(context, imageCard);
              //         },
              //       )
              //     : Container(width: 0.0, height: 0.0),
              // !selectingReinforcer
              //     ? IconButton(
              //         icon: new Icon(
              //           Icons.email,
              //         ),
              //         onPressed: () {
              //           setState(() {
              //             //_showInfoIcon = !_showInfoIcon;
              //           });
              //         },
              //       )
              //     : Container(width: 0.0, height: 0.0),
              // IconButton(
              //   icon: new Icon(
              //     Icons.record_voice_over,
              //   ),
              //   onPressed: () {
              //     sayImage();
              //     // setState(() {
              //     //   //_showInfoIcon = !_showInfoIcon;
              //     // });
              //   },
              // ),
            ],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(children: <Widget>[
                  Expanded(
                    child: Container(
                      //height: height-kToolbarHeight-9-50,
                      margin: const EdgeInsets.all(3.0),
                      decoration: myOuterBoxDecoration(), //
                      child: Container(
                        decoration: myInnerBoxDecoration(), //
                        child: RepaintBoundary(
                          key: _globalKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: imageCard.category == null
                                  ? Colors.white
                                  : Helper.colorFromHex(
                                      imageCard.category.backgroundColor),
                            ),
                            child: Hero(
                                tag: "image_" + imageCard.id.toString(),
                                child: GestureDetector(
                                  child: imageCard.useAsset == 1
                                      ? Image.asset(
                                                imageCard.fileName,
                                              ) !=
                                              null
                                          ? Image.asset(
                                              imageCard.fileName,
                                              //height: 50.0,
                                            )
                                          : Image.asset(Helper.imageNotFound)
                                      : localImage == null
                                          ? Container()
                                          : FadeInImage(
                                              fadeInDuration: Duration(
                                                  milliseconds:
                                                      Helper.fadeInDuration),
                                              placeholder: MemoryImage(
                                                  kTransparentImage),
                                              //placeholder: kTransparentImage,
                                              image: localImage.image,
                                            ),
                                  // Image.asset(
                                  //           imageCard.fileName,
                                  //           //fit: BoxFit.cover,
                                  //         ) !=
                                  //         null
                                  //     ? Image.asset(
                                  //         imageCard.fileName,
                                  //         //fit: BoxFit.cover,
                                  //       )
                                  //     : Image.asset(Helper.imageNotFound),
                                  onTap: () => {sayImage()},
                                )),
                            // FutureBuilder(
                            //   future:
                            //       Helper.buildImageFromAsset(imageCard.fileName),
                            //   builder: (BuildContext context,
                            //       AsyncSnapshot<Image> snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.done)
                            //       return snapshot.data;
                            //     else
                            //       return Image.asset(Helper.imageNotFound);
                            //   },
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          !isSelectingObject
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    //color: Colors.white,
                                    // shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.all(
                                    //         Radius.circular(20.0))),

                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              getBackgroundColor),
                                      foregroundColor:
                                          MaterialStateColor.resolveWith(
                                              getTextColor),
                                    ),
                                    child:
                                        L.getUpperText("select this concept"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(imageCard);
                                    },
                                  ),
                                ),
                          selectingReinforcer
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              getBackgroundColor),
                                      foregroundColor:
                                          MaterialStateColor.resolveWith(
                                              getTextColor),
                                    ),
                                    child: (selectFirstReinforcer
                                        ? L.getUpperText("select reinforcer")
                                        : (selectSecondReinforcer
                                            ? L.getUpperText(
                                                "select second reinforcer")
                                            : L.getUpperText(
                                                "select third reinforcer"))),
                                    onPressed: () {
                                      confirmReinforcer(context, imageCard);
                                    },
                                  ),
                                )
                              : Container(width: 0.0, height: 0.0),
                          findInAssetLibrary
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              getBackgroundColor),
                                      foregroundColor:
                                          MaterialStateColor.resolveWith(
                                              getTextColor),
                                    ),
                                    child: Text('SELECT'),
                                    onPressed: () {
                                      confirmReinforcer(context, imageCard);
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              getBackgroundColor),
                                      foregroundColor:
                                          MaterialStateColor.resolveWith(
                                              getTextColor),
                                    ),
                                    child: L.getUpperText('edit'),
                                    onPressed: () {
                                      MObject mObject = imageCard;

                                      final lucasState =
                                          PropertyChangeProvider.of<LucasState>(
                                                  context,
                                                  listen: false)
                                              .value;
                                      lucasState.saveObject(
                                          StateProperties.objectToEdit,
                                          mObject);
                                      lucasState.saveObject(
                                          StateProperties.currentActivity,
                                          'edit object');

                                      Route route = MaterialPageRoute(
                                          builder: (context) =>
                                              EditObject(mObject, null));
                                      Navigator.push(context, route);
                                    },
                                  ),
                                ),
                        ]),
                  ),
                ]),
              ),
              // bottomNavigationBar: BottomNavigationBar(
              //   currentIndex: 0, // current tab

              //   showUnselectedLabels: true,
              //   unselectedItemColor: Theme.of(context).primaryColor,
              //   selectedItemColor: Theme.of(context).primaryColor,
              //   unselectedLabelStyle: TextStyle(fontSize: 13.0),
              //   selectedLabelStyle: TextStyle(fontSize: 13.0),

              //   onTap: onTabTapped, // new
              //   items: items,
              //   //[
              //     // BottomNavigationBarItem(
              //     //   icon: new Icon(
              //     //     Icons.record_voice_over,
              //     //     color: Theme.of(context).primaryColor,
              //     //   ),
              //     //   title: L.getLocalizedText("say"),
              //     // ),
              //     // (selectFirstReinforcer ||
              //     //         selectSecondReinforcer ||
              //     //         selectThirdReinforcer)
              //     // BottomNavigationBarItem(
              //     //   icon: Icon(
              //     //     Icons.email,
              //     //     color: Theme.of(context).primaryColor,
              //     //   ),
              //     //   title: L.getLocalizedText("send by email"),
              //     // ),
              //     // BottomNavigationBarItem(
              //     //   icon: Icon(
              //     //     Icons.schedule,
              //     //     color: Theme.of(context).primaryColor,
              //     //   ),
              //     //   title: L.getLocalizedText("schedule"),
              //     // ),
              //     // BottomNavigationBarItem(
              //     //   icon: Icon(
              //     //     Icons.settings,
              //     //     color: Theme.of(context).primaryColor,
              //     //   ),
              //     //   title: L.getLocalizedText("settings title"),
              //     // ),
              //   //],
              // ),
            ],
          ),
        ));
  }

  confirmReinforcer(BuildContext context, MImage imageCard) async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: true).value;

    if (!findInAssetLibrary) {
      if (selectFirstReinforcer) {
        await LocalPreferences.setString(
            'firstReinforcer', imageCard.id.toString());
        await lucasState.setReinforcer(1, int.parse(imageCard.id.toString()));
      }
      if (selectSecondReinforcer) {
        await LocalPreferences.setString(
            'secondReinforcer', imageCard.id.toString());
        await lucasState.setReinforcer(2, int.parse(imageCard.id.toString()));
      }
      if (selectThirdReinforcer) {
        await LocalPreferences.setString(
            'thirdReinforcer', imageCard.id.toString());
        await lucasState.setReinforcer(3, int.parse(imageCard.id.toString()));
      }

      await lucasState.setReinforcer(
          StateProperties.refreshLearnScreen, 'true');

      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      // save the new current activity
      LocalPreferences.setString(
          StateProperties.currentActivity, 'LearnScreen');

      Route route = MaterialPageRoute(builder: (context) => LearnScreen());
      Navigator.push(context, route);
    } else {
      //await lucasState.saveObjectWithoutNotifyingListeners(StateProperties.assetFileName, imageCard.fileName);
      Navigator.of(context).pop();
      Navigator.of(context).pop(imageCard.fileName);
    }
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

      await flutterTts.speak(imageCard.textToShow);
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
    //}

    // // send by email
    // if (index == 1) {
    //   // Route route = MaterialPageRoute(builder: (context) => SettingScreen());
    //   // Navigator.push(context, route);
    // }
  }

  Future<bool> _onBackPressed() async {
    // if (quarterTurns == 0) {
    //   ViewPictureResult viewPictureResult = ViewPictureResult();
    //   viewPictureResult.operation = OperationType.no_change;
    //   viewPictureResult.stringBase64 = null;

    //   // Pop ViewPicture Screen
    //   Navigator.of(context).pop(viewPictureResult);
    // } else {
    //   await _capturePng();
    //   ViewPictureResult viewPictureResult = ViewPictureResult();
    //   viewPictureResult.operation = OperationType.edited;
    //   viewPictureResult.stringBase64 = _stringBase64;

    //   setState(() {
    //     _isSaving = false;
    //   });
    //   // Pop ViewPicture Screen
    //   Navigator.of(context).pop(viewPictureResult);
    // }

    return true;
  }

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

  showConceptInfo(MImage imageCard) async {
    String languageCode =
        await LocalPreferences.getString('languageCode', 'en');
    Translation translation =
        await Translation.getLocalized('images', imageCard.id, languageCode);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text('Concept information'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Concept ID: ${imageCard.id}'),
                  Text('Concept Translation: ${imageCard.textToShow}'),
                  Text('Concept filename: ${imageCard.fileName}'),
                  Text('Concept category id: ${imageCard.categoryId}'),
                  Text('Category name: ${imageCard.category.textToShow}'),
                  Text(
                      'Category background color: ${imageCard.category.backgroundColor}'),
                  Text('Category min column: ${imageCard.category.minColumn}'),
                  Text('Category max column: ${imageCard.category.maxColumn}'),
                  Text('Translation ID: ${translation.id}'),
                  Text('Translation text: ${translation.textToShow}'),
                  Text('Translation say: ${translation.textToSay}'),
                  Text('Translation item ID: ${translation.itemId}'),
                  Text('Translation language: ${translation.language}'),
                  Text('Translation tableName: ${translation.tableName}'),
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
        });
  }
}
