import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MLinkedDevice.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MScheduleDay.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MStory.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/models/StoryObject.dart';
import 'package:lucas/models/Translation.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

import 'LearnScreen.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splash> {
  bool isLoading = true;
  String strLoadingStatus = '';
  String rebuildDatabaseStatus = '';
  static bool firstTime = true;
  VideoPlayerController _controller;
  // Duration _position;
  // Duration _duration;
  // bool _isEnd = false;
  bool privacyPolicyAccepted = false;

  @override
  void initState() {
    super.initState();

    LocalPreferences.getBool("privacyPolicyAccepted", false).then((result) {
      setState(() {
        privacyPolicyAccepted = result;
      });

      _controller = VideoPlayerController.asset('assets/videos/intro.mp4')
        ..addListener(() {
          if (_controller.value.duration
                      ?.compareTo(_controller.value.position) ==
                  0 ||
              _controller.value.duration
                      ?.compareTo(_controller.value.position) ==
                  -1) {
            start().then((result) {
              if (!privacyPolicyAccepted) return;

              Route route = MaterialPageRoute(
                builder: (context) => LearnScreen(),
              );
              Navigator.push(context, route);
            });
          }
        })
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            _controller.play(); //.then((a) {
            //   start().then((result) {
            //     Route route = MaterialPageRoute(
            //       builder: (context) =>
            //           // PropertyChangeProvider(
            //           //   value: LucasState(),
            //           //   child:
            //           LearnScreen(),
            //       //),
            //     );
            //     Navigator.push(context, route);
            //   });
            // });
          });
        });
    });

    // start().then((result) {
    //   Route route = MaterialPageRoute(
    //     builder: (context) =>
    //         // PropertyChangeProvider(
    //         //   value: LucasState(),
    //         //   child:
    //         LearnScreen(),
    //     //),
    //   );
    //   Navigator.push(context, route);
    // });
  }

  Future<void> start() async {
    setState(() {
      isLoading = true;
    });

    if (!privacyPolicyAccepted) return;

    int _voiceBoxSize = await LocalPreferences.getInt('voiceBoxSize', 1);
    if (_voiceBoxSize == 0) {
      Helper.voiceBoxHeight = 70.0;
    } else {
      Helper.voiceBoxHeight = 140.0;
    }
    Helper.settingsRestrictions =
        await LocalPreferences.getInt('settings restrictions', 0);
    Helper.showHideStoriesAndSchedule =
        await LocalPreferences.getInt('showHideStoriesAndSchedule', 1);

    Helper.imageFlexSize = await LocalPreferences.getInt('imageFlexSize', 6);
    Helper.level10TextSize =
        await LocalPreferences.getDouble('level10TextSize', 6);

    Helper.folderShouldTalk =
        await LocalPreferences.getBool('folderShouldTalk', false);

    //await Future.delayed(Duration(seconds: 5), null);
    Helper.allowLongPressInLearningScreen =
        await LocalPreferences.getBool('allowLongPressInLearningScreen', true);
    Helper.outputVoiceboxToAnotherDevice =
        await LocalPreferences.getBool('outputVoiceboxToAnotherDevice', false);
    Helper.deviceToOutputVoicebox =
        await LocalPreferences.getInt('deviceToOutputVoicebox', 0);

    Directory directory = await getApplicationDocumentsDirectory();
    Helper.appDirectory = directory.path + '/${Helper.lucasFolder}';
    await Directory('${Helper.appDirectory}').create();

    // load tables if this is the first time
    bool mustInitializeDB =
        await LocalPreferences.getBool("mustInitializeDB", true);
    if (mustInitializeDB) {
      await rebuildDatabase();
    }

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int _canCreateQuiz = await LocalPreferences.getInt('canCreateQuiz', 0);
    lucasState.saveObject(StateProperties.canCreateQuiz, _canCreateQuiz);

    String strCurrentLevel =
        await LocalPreferences.getString('currentLevel', '1');
    int currentLevel = int.parse(strCurrentLevel);

    if (currentLevel > 5) {
      int defaultFolderId = -1;
      MFolder currentFolder = await MFolder.getByID(defaultFolderId);
      lucasState.saveObject(StateProperties.currentFolder, currentFolder);

      int gridColumns = lucasState.getGridColumns();

      List<MObject> learningObjects =
          await MRelation.getLearningObjectsInFolder(
              currentLevel, defaultFolderId, gridColumns);
      lucasState.saveObject(StateProperties.learningObjects, learningObjects);
      lucasState.saveObject(StateProperties.isEditMode, false);
    } else {
      int defaultFolderId =
          await LocalPreferences.getInt('defaultFolderId', -2);
      MFolder currentFolder = await MFolder.getByID(defaultFolderId);
      lucasState.saveObject(StateProperties.currentFolder, currentFolder);

      int gridColumns = lucasState.getGridColumns();

      List<MObject> learningObjects =
          await MRelation.getLearningObjectsInFolder(
              currentLevel, defaultFolderId, gridColumns);
      lucasState.saveObject(StateProperties.learningObjects, learningObjects);
      lucasState.saveObject(StateProperties.isEditMode, false);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // PropertyChangeProvider.of<LucasState>(context,
    //     properties: [StateProperties.voiceBoxConcepts]);

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    if (firstTime) {
      LocalPreferences.getInt("gridColumns", 6).then((c) {
        lucasState.setGridColumns(c);
      });

      LocalPreferences.getInt("gridRows", 6).then((r) {
        lucasState.setGridRows(r);
      });

      Helper.debugMode = false;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('debugMode', false);
      });

      Helper.allowLongPressInLearningScreen = true;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('allowLongPressInLearningScreen', true);
      });

      Helper.outputVoiceboxToAnotherDevice = true;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('outputVoiceboxToAnotherDevice', false);
      });

      Helper.deviceToOutputVoicebox = 0;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setInt('deviceToOutputVoicebox', 0);
      });

      Helper.folderShouldTalk = false;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('folderShouldTalk', false);
      });

      LocalPreferences.getInt("defaultFolderId", -2).then((r) {
        lucasState.saveObject(StateProperties.defaultFolderId, r);
      });

      LocalPreferences.getString("folderBreadcrumb", '').then((r) {
        lucasState.saveObject(StateProperties.folderBreadcrumb, r);
      });

      MFolder currentFolder =
          lucasState.getObject(StateProperties.currentFolder);
      if (currentFolder == null) {
        MFolder.getByID(-1).then((f) {
          currentFolder = f;
          lucasState.saveObject(StateProperties.currentFolder, currentFolder);
        });
      }

      firstTime = false;
    }

    // return _controller.value.initialized
    //                     ? AspectRatio(
    //                         aspectRatio: _controller.value.aspectRatio,
    //                         child: VideoPlayer(_controller),
    //                       )
    //                     : Container();
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            start().then((result) {
              if (!privacyPolicyAccepted) return;

              Route route = MaterialPageRoute(
                builder: (context) =>
                    // PropertyChangeProvider(
                    //   value: LucasState(),
                    //   child:
                    LearnScreen(),
                //),
              );
              Navigator.push(context, route);
            });
          },
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Center(
                    child: (_controller == null)
                        ? Container()
                        : _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: GestureDetector(
                                    onTap: () {
                                      Route route = MaterialPageRoute(
                                        builder: (context) => LearnScreen(),
                                      );
                                      Navigator.push(context, route);
                                    },
                                    child: VideoPlayer(_controller)),
                              )
                            : Container(),
                  ),
                  // child: Center(
                  //   child: Container(
                  //     child: Image.asset("assets/images/lucas_logo.jpg"),
                  //     //color: Theme.of(context).primaryColor,
                  //   ),
                  // ),
                ),
                acceptPrivacyPolicy(),
                isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // new Center(
                          //   child: new SizedBox(
                          //     height: 25.0,
                          //     width: 25.0,
                          //     child: new CircularProgressIndicator(
                          //       value: null,
                          //       strokeWidth: 3.0,
                          //     ),
                          //   ),
                          // ),
                          new Container(
                            margin: const EdgeInsets.all(5.0),
                            child: new Center(
                              child: new Text(
                                strLoadingStatus,
                                style: new TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget acceptPrivacyPolicy() {
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
      return Colors.black26;
    }

    if (privacyPolicyAccepted) return Container();

    return Card(
      color: Colors.white60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: L.getText("privacy policy"),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(""),
                L.getText("must accept privacy policy"),
                InkWell(
                    child: L.getUpperText('view privacy policy'),
                    onTap: () => launch(
                        'https://www.websitepolicies.com/policies/view/F34ovR1O')),
              ],
            ),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith(getBackgroundColor),
                ),
                child: L.getUpperText("accept privacy policy"),
                onPressed: () {
                  LocalPreferences.setBool('privacyPolicyAccepted', true)
                      .then((r) {
                    setState(() {
                      privacyPolicyAccepted = true;
                    });

                    start().then((result) {
                      if (!privacyPolicyAccepted) return;

                      Route route = MaterialPageRoute(
                        builder: (context) =>
                            // PropertyChangeProvider(
                            //   value: LucasState(),
                            //   child:
                            LearnScreen(),
                        //),
                      );
                      Navigator.push(context, route);
                    });
                  });
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith(getBackgroundColor),
                ),
                child: L.getUpperText("close"),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> rebuildDatabase() async {
    String strMsg = "";

    strMsg = await L.item('loading images');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await MImage.loadFromAssets();

    strMsg = await L.item('loading folders');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await MFolder.loadFromAssets();

    strMsg = await L.item('loading relations');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await MRelation.loadFromAssets();

    strMsg = await L.item('loading videos');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await MVideo.loadFromAssets();

    strMsg = await L.item('loading sounds');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await MSound.loadFromAssets();

    strMsg = await L.item('loading empty spaces');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await MEmpty.loadFromAssets();

    strMsg = await L.item('loading translations');
    setState(() {
      strLoadingStatus = strMsg;
    });
    await Translation.loadFromAssets();

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MEmpty.TableName,
    //       'images', language.languageCode);
    // }

    await MLinkedDevice.createTableIFNotExists();
    await MStory.createTableIFNotExists();
    await MStoryObject.createTableIFNotExists();
    await MScheduleDay.createTableIFNotExists();

    await MImage.updateBackgroundColor();
    await MFolder.updateBackgroundColor();
    await MSound.updateBackgroundColor();
    await MVideo.updateBackgroundColor();

    await LocalPreferences.setBool("mustInitializeDB", false);
  }
}
