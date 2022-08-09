import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/screens/Folders.dart';
import 'package:lucas/widgets/WOnboard.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transparent_image/transparent_image.dart';

import 'ImageSettings.dart';
import 'LevelSelector.dart';

class LevelsSettings extends StatefulWidget {
  final Map<dynamic, dynamic> map;

  LevelsSettings(this.map, {Key key, this.languageCode}) : super(key: key);

  final String languageCode;

  @override
  _LevelsSettingsState createState() => _LevelsSettingsState(this.map);
}

class _LevelsSettingsState extends State<LevelsSettings> {
  int currentLevel = 1;
  String languageCode = '';
  int firstReinforcer = -1;
  int secondReinforcer = -1;
  int thirdReinforcer = -1;
  MImage firstReinforcerImage;
  MImage secondReinforcerImage;
  MImage thirdReinforcerImage;
  int defaultFolder = -2;
  String folderBreadcrumb = '';
  int _imageSize = 1;
  int _textSize = 1;

  bool canShowHelpScreens = false;
  bool isLargeScreen = false;

  final Map<dynamic, dynamic> map;
  Map<String, String> helpScreenTranslations = Map<String, String>();

  _LevelsSettingsState(this.map) {
    this.currentLevel = int.parse(map["currentLevel"]);
    this.languageCode = map["languageCode"];
    // this.firstReinforcer = int.parse(map["firstReinforcer"]);
    // this.secondReinforcer = int.parse(map["secondReinforcer"]);
    // this.thirdReinforcer = int.parse(map["thirdReinforcer"]);

    // this.firstReinforcerImage = map["firstReinforcerImage"];
    // this.secondReinforcerImage = map["secondReinforcerImage"];
    // this.thirdReinforcerImage = map["thirdReinforcerImage"];
  }

  @override
  void initState() {
    LocalPreferences.getInt('imageFlexSize', 6).then((result) {
      setState(() {
        if (result == 6) _imageSize = 0;
        if (result == 4) _imageSize = 1;
        if (result == 2) _imageSize = 2;
      });
    });

    loadHelpScreensTranslationTexts().then((result) {
      setState(() {
        canShowHelpScreens = true;
      });
    });

    super.initState();
  }

  Future<void> loadHelpScreensTranslationTexts() async {
    List<String> helpScreenTranslationsItems = [
      'showHelper_LevelSettings_title1',
      'showHelper_LevelSettings_title2',
      'showHelper_LevelSettings_title3',
      'showHelper_LevelSettings_title4',
      'showHelper_LevelSettings_text1',
      'showHelper_LevelSettings_text2',
      'showHelper_LevelSettings_text3',
      'showHelper_LevelSettings_text4',
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

  // Widget showHelperScreens() => Container(
  //       child: SliderLayoutView(),
  //     );

  Widget showHelperScreens() {
    if (!canShowHelpScreens) return Container();

    List<String> images = [
      "assets/onboarding/learning-1.png",
      "assets/onboarding/learning-2.png",
      "assets/onboarding/learning-3.png",
      "assets/onboarding/learning-4.png",
    ];

    List<String> titles = [
      helpScreenTranslations['showHelper_LevelSettings_title1'],
      helpScreenTranslations['showHelper_LevelSettings_title2'],
      helpScreenTranslations['showHelper_LevelSettings_title3'],
      helpScreenTranslations['showHelper_LevelSettings_title4'],

      // "First:",
      // "Fill information",
      // "Change level",
      // "Learning screen"
    ];

    List<String> texts = [
      helpScreenTranslations['showHelper_LevelSettings_text1'],
      helpScreenTranslations['showHelper_LevelSettings_text2'],
      helpScreenTranslations['showHelper_LevelSettings_text3'],
      helpScreenTranslations['showHelper_LevelSettings_text4'],
      // "Please read all the info we have provided for you",
      // "Some levels require information from your side. They are clearly highlighted",
      // "If you need to change levels, please do so by pressing this icon",
      // "Once ready, go back to the Learn screen"
    ];

    return WOnboard(images, titles, texts,
        StateProperties.showHelperLevelSettings, onOnBoardBtnAccept);
  }

  onOnBoardBtnAccept(dynamic a) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return levelSettingWidget();
  }

  Widget leftWidget() {
    return Center(
      child: LevelSelector(true),
    );
  }

  Widget levelSettingWidget() {
    return PropertyChangeConsumer<LucasState>(
        properties: [
          StateProperties.folderBreadcrumb,
          StateProperties.showHelperLevelSettings,
        ],
        builder: (context, lucasState, property) {
          if (MediaQuery.of(context).size.width > 600) {
            isLargeScreen = true;
          } else {
            isLargeScreen = false;
          }

          if (helpScreenTranslations == null || helpScreenTranslations.isEmpty)
            return Container();

          if ((lucasState.getObject(StateProperties.showHelperLevelSettings) ??
                  '') !=
              "false") {
            return showHelperScreens();
          }

// final lucasState =
          //     PropertyChangeProvider.of<LucasState>(context, listen: false).value;
          firstReinforcer = lucasState.getReinforcer(1);
          secondReinforcer = lucasState.getReinforcer(2);
          thirdReinforcer = lucasState.getReinforcer(3);
          firstReinforcerImage = lucasState.getReinforcerImage(1);
          secondReinforcerImage = lucasState.getReinforcerImage(2);
          thirdReinforcerImage = lucasState.getReinforcerImage(3);
          defaultFolder =
              lucasState.getObject(StateProperties.defaultFolderId) ?? -2;

          return WillPopScope(
            onWillPop: handleBackButton,
            child: Scaffold(
              appBar: AppBar(
                title: L.getAppBarLocalizedText("levels"),
                actions: <Widget>[
                  TextButton(
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      openLevelSelector();
                    },
                  ),
                  TextButton(
                    child: Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        final lucasState =
                            PropertyChangeProvider.of<LucasState>(context,
                                    listen: true)
                                .value;
                        lucasState.saveObject(
                            StateProperties.showHelperLevelSettings, '');
                      });
                    },
                  )
                ],
              ),
              // body: !isLargeScreen
              //     ? Container(child: getFutureLevelListView(context))
              //     : Row(children: <Widget>[
              //         Expanded(
              //           child:
              //               Container(color: Colors.white, child: leftWidget()),
              //         ),
              //         Expanded(
              //           child: getFutureLevelListView(context),
              //         ),
              //       ]),

              body: Container(child: getFutureLevelListView(context)),
              bottomNavigationBar: BottomNavigationOptions(),
            ),
          );
        });
  }

  Widget getFutureLevelListView(BuildContext context) {
    if (currentLevel == 1) return getLevel1ListView(context, map);
    if (currentLevel == 2) return getLevel2ListView(context, map);
    if (currentLevel == 3) return getLevel3ListView(context, map);
    if (currentLevel == 4) return getLevel4ListView(context, map);
    if (currentLevel == 5) return getLevel5ListView(context, map);
    if (currentLevel == 6) return getLevel6ListView(context, map);
    if (currentLevel == 7) return getLevel7ListView(context, map);
    if (currentLevel == 8) return getLevel8ListView(context, map);
    if (currentLevel == 9) return getLevel9ListView(context, map);
    if (currentLevel == 10) return getLevel10ListView(context, map);
    if (currentLevel == 11) return getLevel11ListView(context, map);

    return Text("Level $currentLevel not implemented");
  }

  openLevelSelector() async {
    Route route = MaterialPageRoute(builder: (context) => LevelSelector(false));
    final returnedCurrentLevel = await Navigator.push(context, route);

    if (mounted) {
      setState(() {
        currentLevel = returnedCurrentLevel;
      });
    }
  }

  Widget imageBuilder() {
    if (currentLevel == 1 && firstReinforcerImage != null) {
      Image localImage;
      if (firstReinforcerImage.useAsset == 0) {
        File f = File(
            '${Helper.appDirectory}/${firstReinforcerImage.localFileName}');
        localImage = Image.file(f);
      }
      return firstReinforcerImage.useAsset == 1
          ? Image.asset(
                    firstReinforcerImage.fileName,
                  ) !=
                  null
              ? Image.asset(
                  firstReinforcerImage.fileName,
                  //height: 50.0,
                )
              : Image.asset(Helper.imageNotFound)
          : localImage == null
              ? Container()
              : FadeInImage(
                  fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  //placeholder: kTransparentImage,
                  image: localImage.image,
                );
      // return Image.asset(
      //           firstReinforcerImage.fileName,
      //           height: 45.0,
      //           width: 45.0,
      //         ) !=
      //         null
      //     ? Image.asset(
      //         firstReinforcerImage.fileName,
      //         height: 45.0,
      //         width: 45.0,
      //       )
      //     : Image.asset(Helper.imageNotFound);
    }
    if (currentLevel == 2 && secondReinforcerImage != null) {
      Image localImage;
      if (secondReinforcerImage.useAsset == 0) {
        File f = File(
            '${Helper.appDirectory}/${secondReinforcerImage.localFileName}');
        localImage = Image.file(f);
      }
      return secondReinforcerImage.useAsset == 1
          ? Image.asset(
                    secondReinforcerImage.fileName,
                  ) !=
                  null
              ? Image.asset(
                  secondReinforcerImage.fileName,
                  //height: 50.0,
                )
              : Image.asset(Helper.imageNotFound)
          : localImage == null
              ? Container()
              : FadeInImage(
                  fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  //placeholder: kTransparentImage,
                  image: localImage.image,
                );
      // return Image.asset(
      //           secondReinforcerImage.fileName,
      //           height: 45.0,
      //           width: 45.0,
      //         ) !=
      //         null
      //     ? Image.asset(
      //         secondReinforcerImage.fileName,
      //         height: 45.0,
      //         width: 45.0,
      //       )
      //     : Image.asset(Helper.imageNotFound);
    }
    if (currentLevel == 3 && thirdReinforcerImage != null) {
      Image localImage;
      if (thirdReinforcerImage.useAsset == 0) {
        File f = File(
            '${Helper.appDirectory}/${thirdReinforcerImage.localFileName}');
        localImage = Image.file(f);
      }
      return thirdReinforcerImage.useAsset == 1
          ? Image.asset(
                    thirdReinforcerImage.fileName,
                  ) !=
                  null
              ? Image.asset(
                  thirdReinforcerImage.fileName,
                  //height: 50.0,
                )
              : Image.asset(Helper.imageNotFound)
          : localImage == null
              ? Container()
              : FadeInImage(
                  fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  //placeholder: kTransparentImage,
                  image: localImage.image,
                );
      // return Image.asset(
      //           thirdReinforcerImage.fileName,
      //           height: 45.0,
      //           width: 45.0,
      //         ) !=
      //         null
      //     ? Image.asset(
      //         thirdReinforcerImage.fileName,
      //         height: 45.0,
      //         width: 45.0,
      //       )
      //     : Image.asset(Helper.imageNotFound);
    }

    return Image.asset(
      "assets/images/ui_empty.png",
      height: 45.0,
      width: 45.0,
    );
  }

  Widget getLevel1ListView(BuildContext context, Map items) {
    //String firstReinforcer = items['firstReinforcer'];

    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level1"),
                    Text(" "),
                    L.getUpperText("level1 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        selectFirstReinforcer(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level1 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level1 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level1 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level1 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 2"),
                subtitle: L.getText("level1 How do you know ready for level 2"),
              ),
            ],
          ),
        ),
        selectFirstReinforcer(),
      ],
    );

    return settingListView;
  }

  Widget selectFirstReinforcer() {
    return Card(
      color: firstReinforcer == -1 ? Colors.redAccent : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: firstReinforcer == -1
                ? L.getText("missing reinforcer")
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            subtitle: firstReinforcer == -1
                ? L.getText("please select a reinforcer")
                : L.getText("selected reinforcer"),
            trailing: firstReinforcer == -1
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : imageBuilder(),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: L.getUpperText("select reinforcer"),
                onPressed: () async {
                  // save the new current activity
                  await LocalPreferences.setString(
                      StateProperties.currentActivity, 'ImageSettings');

                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          ImageSettings(true, false, false, false));
                  await Navigator.push(context, route);
                  String strReinforcer =
                      await LocalPreferences.getString('firstReinforcer', "-1");
                  if (mounted) {
                    setState(() {
                      firstReinforcer = int.parse(strReinforcer);
                    });
                  }
                },
              ),
              TextButton(
                child: L.getUpperText("reset"),
                onPressed: () async {
                  await LocalPreferences.setString('firstReinforcer', '-1');
                  final lucasState = PropertyChangeProvider.of<LucasState>(
                          context,
                          listen: false)
                      .value;

                  await lucasState.setReinforcer(1, -1);
                  setState(() {
                    firstReinforcer = -1;
                    firstReinforcerImage = null;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLevel2ListView(BuildContext context, Map items) {
    //String secondReinforcer = items['secondReinforcer'];

    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    L.getText("level2"),
                    Text(" "),
                    L.getUpperText("level2 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        selectSecondReinforcer(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level2 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level2 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level2 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level2 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 3"),
                subtitle: L.getText("level2 How do you know ready for level 3"),
              ),
            ],
          ),
        ),
        selectSecondReinforcer(),
      ],
    );

    return settingListView;
  }

  Widget selectSecondReinforcer() {
    return Card(
      color: secondReinforcer == -1 ? Colors.redAccent : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: secondReinforcer == -1
                ? L.getText("missing reinforcer")
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            subtitle: secondReinforcer == -1
                ? L.getText("please select a reinforcer")
                : L.getText("selected reinforcer"),
            trailing: secondReinforcer == -1
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : imageBuilder(),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: L.getUpperText("select second reinforcer"),
                onPressed: () async {
                  // save the new current activity
                  await LocalPreferences.setString(
                      StateProperties.currentActivity, 'ImageSettings');

                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          ImageSettings(false, true, false, false));
                  await Navigator.push(context, route);
                  String strReinforcer = await LocalPreferences.getString(
                      'secondReinforcer', "-1");
                  if (mounted) {
                    setState(() {
                      secondReinforcer = int.parse(strReinforcer);
                    });
                  }
                },
              ),
              TextButton(
                child: L.getUpperText("reset"),
                onPressed: () async {
                  await LocalPreferences.setString('secondReinforcer', '-1');
                  final lucasState = PropertyChangeProvider.of<LucasState>(
                          context,
                          listen: false)
                      .value;

                  await lucasState.setReinforcer(2, -1);
                  setState(() {
                    secondReinforcer = -1;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLevel3ListView(BuildContext context, Map items) {
    //String thirdReinforcer = items['thirdReinforcer'];

    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level3"),
                    Text(" "),
                    L.getUpperText("level3 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        selectThirdReinforcer(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level3 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level3 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level3 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level3 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 4"),
                subtitle: L.getText("level3 How do you know ready for level 4"),
              ),
            ],
          ),
        ),
        selectThirdReinforcer(),
      ],
    );

    return settingListView;
  }

  Widget selectThirdReinforcer() {
    return Card(
      color: thirdReinforcer == -1 ? Colors.redAccent : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: thirdReinforcer == -1
                ? L.getText("missing reinforcer")
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            subtitle: thirdReinforcer == -1
                ? L.getText("please select a reinforcer")
                : L.getText("selected reinforcer"),
            trailing: thirdReinforcer == -1
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : imageBuilder(),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: L.getUpperText("select third reinforcer"),
                onPressed: () async {
                  // save the new current activity
                  await LocalPreferences.setString(
                      StateProperties.currentActivity, 'ImageSettings');

                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          ImageSettings(false, false, true, false));
                  await Navigator.push(context, route);
                  String strReinforcer =
                      await LocalPreferences.getString('thirdReinforcer', "-1");
                  if (mounted) {
                    setState(() {
                      thirdReinforcer = int.parse(strReinforcer);
                    });
                  }
                },
              ),
              TextButton(
                child: L.getUpperText("reset"),
                onPressed: () async {
                  await LocalPreferences.setString('thirdReinforcer', '-1');
                  final lucasState = PropertyChangeProvider.of<LucasState>(
                          context,
                          listen: false)
                      .value;

                  await lucasState.setReinforcer(3, -1);
                  setState(() {
                    thirdReinforcer = -1;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLevel4ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level4"),
                    Text(" "),
                    L.getUpperText("level4 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        noActionRequired(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level4 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level4 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level4 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level4 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 5"),
                subtitle: L.getText("level4 How do you know ready for level 5"),
              ),
            ],
          ),
        ),
      ],
    );

    return settingListView;
  }

  Widget noActionRequired() {
    return Card(
      color: firstReinforcer == -1 ? Colors.redAccent : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: L.getText("no action required title"),
              subtitle: L.getText("no action required info")),
        ],
      ),
    );
  }

  Widget getLevel5ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level5"),
                    Text(" "),
                    L.getUpperText("level5 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        selectDefaultFolder(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level5 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level5 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level5 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level5 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("level 5 folders"),
                subtitle: L.getText("level 5 folder info"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 6"),
                subtitle: L.getText("level5 How do you know ready for level 6"),
              ),
            ],
          ),
        ),
        selectDefaultFolder(),
      ],
    );

    return settingListView;
  }

  Widget selectDefaultFolder() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    folderBreadcrumb =
        lucasState.getObject(StateProperties.folderBreadcrumb) ?? '';

    return Card(
      color: folderBreadcrumb.isEmpty ? Colors.redAccent : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: defaultFolder == -2
                ? L.getText("no default folder")
                : Row(
                    children: <Widget>[
                      defaultFolder == -2
                          ? L.getText("please select a default folder")
                          : Wrap(direction: Axis.vertical, children: <Widget>[
                              L.getText("current default folder"),
                              getDefaultFolderBreadcrumb()
                            ]),
                    ],
                  ),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: L.getUpperText("select folder"),
                onPressed: () async {
                  final lucasState = PropertyChangeProvider.of<LucasState>(
                          context,
                          listen: false)
                      .value;
                  int currentFolderId =
                      lucasState.getObject(StateProperties.defaultFolderId) ??
                          -1;

                  int gridColumns = lucasState.getGridColumns();

                  List<MObject> gridObjects =
                      await MRelation.getObjectsInFolder(
                          gridColumns, currentFolderId);
                  await lucasState.saveObject(
                      StateProperties.gridObjects, gridObjects);

                  MFolder currentFolder =
                      await MFolder.getByID(currentFolderId);
                  MFolder parentFolder;
                  if (currentFolder == null)
                    parentFolder = null;
                  else
                    parentFolder =
                        await MFolder.getByID(currentFolder.parentFolderId);
                  lucasState.saveObject(
                      StateProperties.currentFolder, currentFolder);
                  lucasState.saveObject(
                      StateProperties.parentFolder, parentFolder);
                  lucasState.saveObject(StateProperties.isEditMode, true);

                  String currentLevel =
                      await LocalPreferences.getString("currentLevel", "1");

                  Route route = MaterialPageRoute(
                      builder: (context) => Folders(currentLevel));
                  Navigator.push(context, route);

                  // String strDefaultFolder = await LocalPreferences.getString(
                  //     'defaultFolder', "");
                  // if (mounted) {
                  //   setState(() {
                  //     defaultFolder = int.parse(strDefaultFolder??-2);
                  //   });
                  // }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLevel6ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level6"),
                    Text(" "),
                    L.getUpperText("level6 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        noActionRequired(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level6 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level6 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level6 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level6 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 7"),
                subtitle: L.getText("level6 How do you know ready for level 7"),
              ),
            ],
          ),
        ),
      ],
    );

    return settingListView;
  }

  Widget getLevel7ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level7"),
                    Text(" "),
                    L.getUpperText("level7 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        noActionRequired(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level7 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level7 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level7 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level7 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 8"),
                subtitle: L.getText("level7 How do you know ready for level 8"),
              ),
            ],
          ),
        ),
      ],
    );

    return settingListView;
  }

  Widget getLevel8ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level8"),
                    Text(" "),
                    L.getUpperText("level8 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        noActionRequired(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level8 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level8 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level8 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level8 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 9"),
                subtitle: L.getText("level8 How do you know ready for level 9"),
              ),
            ],
          ),
        ),
      ],
    );

    return settingListView;
  }

  Widget getLevel9ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level9"),
                    Text(" "),
                    L.getUpperText("level9 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        noActionRequired(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level9 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level9 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level9 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level9 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 10"),
                subtitle:
                    L.getText("level9 How do you know ready for level 10"),
              ),
            ],
          ),
        ),
      ],
    );

    return settingListView;
  }

  Widget getLevel10ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level10"),
                    Text(" "),
                    L.getUpperText("level10 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Card(
          child: ListTile(
            title: L.getText("image size"),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _imageSize,
                  onChanged: _handleImageSizeChange,
                ),
                L.getText("large"),
                new Radio(
                  value: 1,
                  groupValue: _imageSize,
                  onChanged: _handleImageSizeChange,
                ),
                L.getText("medium"),
                new Radio(
                  value: 2,
                  groupValue: _imageSize,
                  onChanged: _handleImageSizeChange,
                ),
                L.getText("small"),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: L.getText("text size"),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _textSize,
                  onChanged: _handleTextSizeChange,
                ),
                L.getText("small"),
                new Radio(
                  value: 1,
                  groupValue: _textSize,
                  onChanged: _handleTextSizeChange,
                ),
                L.getText("medium"),
                new Radio(
                  value: 2,
                  groupValue: _textSize,
                  onChanged: _handleTextSizeChange,
                ),
                L.getText("large"),
              ],
            ),
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level10 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level10 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level10 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level10 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do you know ready for level 11"),
                subtitle:
                    L.getText("level10 How do you know ready for level 11"),
              ),
            ],
          ),
        ),
      ],
    );

    return settingListView;
  }

  void _handleImageSizeChange(int value) {
    if (value == 0) {
      Helper.imageFlexSize = 6;
    }
    if (value == 1) {
      Helper.imageFlexSize = 4;
    }
    if (value == 2) {
      Helper.imageFlexSize = 2;
    }

    setState(() {
      _imageSize = value;

      LocalPreferences.setInt('imageFlexSize', Helper.imageFlexSize);
    });
  }

  void _handleTextSizeChange(int value) {
    if (value == 0) {
      Helper.level10TextSize = 16;
    }
    if (value == 1) {
      Helper.level10TextSize = 20;
    }
    if (value == 2) {
      Helper.level10TextSize = 24;
    }

    setState(() {
      _textSize = value;
      LocalPreferences.setDouble('level10TextSize', Helper.level10TextSize);
    });
  }

  Widget getLevel11ListView(BuildContext context, Map items) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("selected level"),
                subtitle: Row(
                  children: <Widget>[
                    L.getText("level11"),
                    Text(" "),
                    L.getUpperText("level11 name"),
                  ],
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: L.getUpperText("change level"),
                    onPressed: () {
                      openLevelSelector();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        noActionRequired(),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.album),
                title: L.getText("summary"),
                subtitle: L.getText("level11 summary"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("Who does this level cater for"),
                subtitle: L.getText("level11 Who does this level cater for"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we achieve this?"),
                subtitle: L.getText("level11 How do we achieve this"),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: L.getText("How do we get the user to touch the screen?"),
                subtitle: L.getText(
                    "level11 How do we get the user to touch the screen"),
              ),
            ],
          ),
        ),
        // Card(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       ListTile(
        //         title: L.getText("How do you know ready for level 10"),
        //         subtitle: L.getText("level9 How do you know ready for level 10"),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );

    return settingListView;
  }

  Widget getDefaultFolderBreadcrumb() {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    folderBreadcrumb =
        lucasState.getObject(StateProperties.folderBreadcrumb) ?? '';

    return Text(
      folderBreadcrumb,
      style: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      overflow: TextOverflow.ellipsis,
    );
    // return FutureBuilder(
    //   future: MFolder.getBreadcrumb(folderId),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //         return new Text('');
    //       case ConnectionState.waiting:
    //         return new Center(child: new CircularProgressIndicator());
    //       case ConnectionState.active:
    //         return new Text('');
    //       case ConnectionState.done:
    //         if (snapshot.hasError) {
    //           return new Text(
    //             '${snapshot.error}',
    //             style: TextStyle(color: Colors.red),
    //           );
    //         } else {
    //           return snapshot.data;
    //         }
    //     }
    //     return Text("");
    //   },
    // );
  }

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }
}
