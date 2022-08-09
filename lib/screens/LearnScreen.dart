import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/PushMessageType.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/Tuple.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MLinkedDevice.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/screens/Folders.dart';
import 'package:lucas/widgets/ObjectGrid.dart';
import 'package:lucas/widgets/VoiceBox.dart';
import 'package:lucas/widgets/WFolder.dart';
import 'package:lucas/widgets/WImage.dart';
import 'package:lucas/widgets/WSound.dart';
import 'package:lucas/widgets/WVideo.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:uuid/uuid.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lucas/screens/ImageSettings.dart';

import 'ColorSettings.dart';
import 'EditObject.dart';
import 'HelpVideos.dart';
import 'ImageSettings.dart';
import 'Languages.dart';
import 'LevelsSettings.dart';
import 'LinkedDevices.dart';
import 'Quiz.dart';
import 'Schedule.dart';
import 'SettingScreen.dart';
import 'Stories.dart';
import 'TextToSpeech.dart';
import 'UserAccount.dart';
import 'package:lucas/screens/TextToSpeech.dart';

class LearnScreen extends StatefulWidget {
  final String title;

  LearnScreen({Key key, this.title}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //List<MObject> gridObjects;
  Map<String, String> translations = Map<String, String>();
  List<String> translationItems = [
    'edit',
    'linked devices',
    'no linked devices',
    'quiz type',
    'quiz show image',
    'quiz sound image',
    'quiz show sound and image',
    'quiz do not show anything',
    'send quiz',
    'send to device',
  ];

  _LearnScreenState() {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
  }

  //Widget _learningView; // Save the form
  Widget gridWidget;
  MFolder mHomeFolder;

  int canCreateQuiz = 0;
  List<MLinkedDevice> linkedDevices = <MLinkedDevice>[];
  int selectedLinkedDevice = -1;
  int selectedQuizType = 3;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //String _localUserEmail = '';

  //String currentLevel = '1';
  // final List<Widget> _children = [];
  //bool _first = true;
  //final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      if (mounted) {
        setState(() {});
      }
    });

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     await processOnMessage(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     await processOnLaunch(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     await processOnResume(message);
    //   },
    // );

    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   //print("Settings registered: $settings");
    // });
    switchToCurrentActivity().then((result) {});
  }

  /* Future<void> processOnMessage(Map<String, dynamic> message) async {
    // if (_localToken == null) return;
    // if (_localToken.isEmpty) return;

    String senderEmail = getValueInMessage(message, 'sender email');
    if (_localUserEmail != senderEmail) {
      String messageType = getValueInMessage(message, 'message type');
      if (messageType == PushMessageType.quiz) {
        String quizType = getValueInMessage(message, 'quiz type');
        String quizId = getValueInMessage(message, 'quiz id');
        String strObjects = message['objects'] ?? message['data']['objects'];
        List<dynamic> objects = jsonDecode(strObjects);

        List<MObject> quizConcepts = List<MObject>();
        for (int i = 0; i < objects.length; i++) {
          Map<String, dynamic> object = objects[i];
          String objectType = object['object_type'];
          int objectId = object['object_id'];

          if (objectType == 'folder') {
            quizConcepts.add(await MFolder.getByID(objectId));
          }
          if (objectType == 'image') {
            quizConcepts.add(await MImage.getByID(objectId));
          }
          if (objectType == 'video') {
            quizConcepts.add(await MVideo.getByID(objectId));
          }
          if (objectType == 'sound') {
            quizConcepts.add(await MSound.getByID(objectId));
          }
        }
        ////////////// setState(() {});

        ////////////// final lucasState =
        //////////////     PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        ////////////// lucasState.setImageCards(imageCards);

        ////////////// objectIndexToPlay = -1;
        ////////////// await playImageCards();
        ///
        print('Quz type: $quizType, Quiz ID: $quizId, Send by: $senderEmail');
      }
    }

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(message);
    print("onMessage: $prettyprint");

    //print(prettyprint);

    // setState(() {
    //   _messageText = "Message: $prettyprint";
    //   isLinking = false;
    // });
  }

  String getValueInMessage(Map<String, dynamic> message, String property) {
    if (message['data'] != null) {
      return message['data'][property].toString();
    }

    return message[property].toString();
  }

  Future<void> processOnLaunch(Map<String, dynamic> message) async {
    if (mounted) {
      setState(() {
        //_messageText = "Push Messaging message: $message";
      });
    }
    print("onLaunch: $message");
  }

  Future<void> processOnResume(Map<String, dynamic> message) async {
    if (mounted) {
      setState(() {
        //_messageText = "Push Messaging message: $message";
      });
    }
    print("onResume: $message");
  } */

  Future<void> switchToCurrentActivity() async {
    String currentActivity = await LocalPreferences.getString(
        StateProperties.currentActivity, 'LearnScreen');

    if (currentActivity == 'LearnScreen') {
      return;
    }
    if (currentActivity == 'HelpVideos') {
      Navigator.of(context).pop();
      Route route = MaterialPageRoute(builder: (context) => HelpVideos());
      Navigator.push(context, route);
    }
    if (currentActivity == 'edit object') {
      //Navigator.of(context).pop();

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      MObject mObject = lucasState.getObject(StateProperties.objectToEdit);
      if (mObject == null) return;

      Navigator.of(context).pop();
      Route route =
          MaterialPageRoute(builder: (context) => EditObject(mObject, null));
      Navigator.push(context, route);
    }
    if (currentActivity == 'LevelsSettings') {
      Tuple t1 = Tuple("currentLevel", "1", "String");
      Tuple t2 = Tuple("languageCode", "en", "String");
      Tuple t3 = Tuple("firstReinforcer", "-1", "String");
      Tuple t4 = Tuple("secondReinforcer", "-1", "String");
      Tuple t5 = Tuple("thirdReinforcer", "-1", "String");
      List<Tuple> tuples = [t1, t2, t3, t4, t5];
      Map<dynamic, dynamic> map = await LocalPreferences.getInfo(tuples);

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;

      await lucasState.setReinforcer(1, int.parse(map["firstReinforcer"]));
      await lucasState.setReinforcer(2, int.parse(map["secondReinforcer"]));
      await lucasState.setReinforcer(3, int.parse(map["thirdReinforcer"]));
      if (context == null) return;

      Navigator.of(context).pop();
      Route route =
          MaterialPageRoute(builder: (context) => LevelsSettings(map));
      Navigator.push(context, route);
    }

    if (currentActivity == 'ImageSettings') {
      Navigator.of(context).pop();
      if (context == null) return;

      final lucasState = PropertyChangeProvider.of<LucasState>(context).value;
      bool selectFirstReinforcer =
          await lucasState.getObject(StateProperties.selectFirstReinforcer) ??
              false;
      bool selectSecondReinforcer =
          await lucasState.getObject(StateProperties.selectSecondReinforcer) ??
              false;
      bool selectThirdReinforcer =
          await lucasState.getObject(StateProperties.selectThirdReinforcer) ??
              false;

      Route route = MaterialPageRoute(
        builder: (context) => ImageSettings(selectFirstReinforcer,
            selectSecondReinforcer, selectThirdReinforcer, false),
      );
      Navigator.push(context, route);
    }
    if (currentActivity == 'Folders') {
      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;

      MFolder folder;
      String currentLevel =
          await LocalPreferences.getString("currentLevel", "1");
      if (currentLevel == '5') {
        int defaultFolderId =
            lucasState.getObject(StateProperties.defaultFolderId);
        //if (defaultFolderId == -2) defaultFolderId = -1;
        folder = await MFolder.getByID(defaultFolderId);
      } else {
        folder = await MFolder.getByID(-1);
      }

      lucasState.saveObject(StateProperties.selectedFolder, folder);

      int gridColumns = lucasState.getGridColumns();

      List<MObject> objects = <MObject>[];
      if (folder != null)
        objects = await MRelation.getObjectsInFolder(gridColumns, folder.id);
      await lucasState.saveObject(StateProperties.gridObjects, objects);

      //MFolder currentFolder = await MFolder.getByID(currentFolderId);
      MFolder parentFolder;
      if (folder == null) //currentFolder == null)
        parentFolder = null;
      else
        parentFolder = await MFolder.getByID(folder.parentFolderId);
      //await MFolder.getByID(currentFolder.parentFolderId);
      lucasState.saveObject(StateProperties.currentFolder, folder);
      lucasState.saveObject(StateProperties.parentFolder, parentFolder);
      lucasState.saveObject(StateProperties.isEditMode, true);
      if (context == null) return;

      Route route =
          MaterialPageRoute(builder: (context) => Folders(currentLevel));
      Navigator.push(context, route);
    }
    if (currentActivity == 'ColorSettings') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => ColorSettings());
      Navigator.push(context, route);
    }
    if (currentActivity == 'TextToSpeech') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => TextToSpeech());
      Navigator.push(context, route);
    }
    if (currentActivity == 'Languages') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => Languages());
      Navigator.push(context, route);
    }
    if (currentActivity == 'LinkedDevices') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => LinkedDevices());
      Navigator.push(context, route);
    }
    if (currentActivity == 'UserAccount') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => UserAccount());
      Navigator.push(context, route);
    }

    if (currentActivity == 'Stories') {
      Navigator.of(context).pop();
      Route route = MaterialPageRoute(builder: (context) => Stories());
      Navigator.push(context, route);
    }

    if (currentActivity == 'Schedule') {
      Navigator.of(context).pop();
      Route route = MaterialPageRoute(builder: (context) => Schedule());
      Navigator.push(context, route);
    }
    if (currentActivity == 'SettingScreen') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => SettingScreen());
      Navigator.push(context, route);
    }
    if (currentActivity == 'Quiz') {
      Navigator.of(context).pop();

      Route route = MaterialPageRoute(builder: (context) => Quiz());
      Navigator.push(context, route);
    }
  }

  Future<void> initialize() async {
    // String strLocalUserEmail =
    //     await LocalPreferences.getString('userEmail', '');

    canCreateQuiz = await LocalPreferences.getInt('canCreateQuiz', 0);
    await getLinkedDevices();
    if (linkedDevices.length > 0) selectedLinkedDevice = linkedDevices.first.id;
    selectedQuizType = 3;

    Map<String, String> result = await L.getItems(translationItems);

    if (mounted) {
      setState(() {
        translations = result;
      });
    }

    mHomeFolder = await MFolder.getByID(-1);

    if (mounted) {
      if (context != null) {
        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;

        List<MObject> objects =
            lucasState.getObject(StateProperties.learningObjects);

        int gridColumns = lucasState.getGridColumns();

        if (objects == null || objects.length == 0) {
          String currentLevel =
              await LocalPreferences.getString("currentLevel", "1");
          List<MObject> learningObjects =
              await MRelation.getLearningObjectsInFolder(
                  int.parse(currentLevel), -1, gridColumns);
          lucasState.saveObject(
              StateProperties.learningObjects, learningObjects);
        }
      }
    }

    // if (mounted) {
    //   setState(() {
    //     //translations = result;
    //     _localUserEmail = strLocalUserEmail;
    //   });
    // }
  }

  Future<void> getLinkedDevices() async {
    List<MLinkedDevice> objects = await MLinkedDevice.getAll(false);

    if (mounted) {
      setState(() {
        linkedDevices = objects;
      });
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    // if (_learningView == null) {
    //   _learningView = getFutureMainView(context);
    // }

    return PropertyChangeConsumer<LucasState>(
      properties: [
        //StateProperties.learningObjects,
        StateProperties.currentFolder,
        StateProperties.refreshLearnScreen,
      ],
      builder: (context, lucasState, property) {
        bool savingEditedObject =
            lucasState.getObject(StateProperties.savingEditedObject) ?? false;
        if (savingEditedObject) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: (translations == null || translations.isEmpty)
                  ? Container()
                  : Text(translations['edit']),
              backgroundColor: Theme.of(context).primaryColor,
              actions: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.email,
                  ),
                  onPressed: () {
                    setState(() {
                      //_showInfoIcon = !_showInfoIcon;
                    });
                  },
                )
              ],
            ),
            body: Container(
              height: Helper.LinearProgressIndicatorHeight,
              child: LinearProgressIndicator(
                value: null,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
                backgroundColor: Colors.white,
              ),
            ),
          );
        }
        return Scaffold(
          key: _scaffoldKey,
          body: SafeArea(child: getFutureMainView(context)),
          bottomNavigationBar: BottomNavigationOptions(),
        );
      },
    );
  }

  Widget getFutureMainView(BuildContext context) {
    Tuple t1 = Tuple("currentLevel", "1", "String");
    Tuple t2 = Tuple("firstReinforcer", "", "String");
    Tuple t3 = Tuple("secondReinforcer", "", "String");
    Tuple t4 = Tuple("thirdReinforcer", "", "String");

    List<Tuple> tuples = [t1, t2, t3, t4];

    return FutureBuilder(
      future: LocalPreferences.getInfo(tuples),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return
                  // isLoadingWords
                  //     ? Container(
                  // height: Helper.LinearProgressIndicatorHeight,
                  //         child: LinearProgressIndicator(
                  //           value: null,
                  //           valueColor: new AlwaysStoppedAnimation<Color>(
                  //               Theme.of(context).primaryColor),
                  //           backgroundColor: Colors.white,
                  //         ),
                  //       )
                  //     :
                  getMainView(context, snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  Widget getMainView(BuildContext context, Map prefs) {
    String currentLevel = prefs['currentLevel'];
    String firstReinforcer = prefs['firstReinforcer'];
    String secondReinforcer = prefs['secondReinforcer'];
    String thirdReinforcer = prefs['thirdReinforcer'];

    // firstReinforcer = '36';
    // secondReinforcer = '26';
    // thirdReinforcer = '27';

    if (currentLevel == '1')
      return getLevel1View(context, currentLevel, firstReinforcer);
    if (currentLevel == '2')
      return getLevel2View(
          context, currentLevel, firstReinforcer, secondReinforcer);
    if (currentLevel == '3')
      return getLevel3View(context, currentLevel, firstReinforcer,
          secondReinforcer, thirdReinforcer);
    if (currentLevel == '4')
      return getLevel4View(context, currentLevel, firstReinforcer,
          secondReinforcer, thirdReinforcer);

    // if no objects are visible, show a message indicating this situation
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    List<String> levelsToCheck = ['5', '6', '7', '8', '9', '10', '11'];
    if (levelsToCheck.contains(currentLevel)) {
      List<MObject> objects =
          lucasState.getObject(StateProperties.learningObjects) ?? <MObject>[];
      if (objects.where((f) => f.isVisible == 1).toList().isEmpty) {
        return Column(children: <Widget>[
          buildVoiceBox(context),
          Expanded(
              child: getNothingIsVisibleNotification(
                  context, int.parse(currentLevel))),
          buildFolderBar(),
        ]);
      }
    }

    int defaultFolderId =
        lucasState.getObject(StateProperties.defaultFolderId) ?? -2;
    if (currentLevel == '5') {
      return getLevel5View(context, currentLevel, defaultFolderId);
    }
    if (currentLevel == '6')
      return getLevel6View(context, currentLevel, defaultFolderId);
    if (currentLevel == '7')
      return getLevel7View(context, currentLevel, defaultFolderId);
    if (currentLevel == '8')
      return getLevel8View(context, currentLevel, defaultFolderId);
    if (currentLevel == '9')
      return getLevel9View(context, currentLevel, defaultFolderId);
    if (currentLevel == '10')
      return getLevel10View(context, currentLevel, defaultFolderId);
    if (currentLevel == '11')
      return getLevel11View(context, currentLevel, defaultFolderId);

    return L.getLocalizedJoinedText('level not found', '\n($currentLevel)');
  }

  Widget buildQuizSection() {
    if (canCreateQuiz == 0) return Container();

    List<DropdownMenuItem> items = <DropdownMenuItem>[];
    if (linkedDevices.length == 0) selectedLinkedDevice = -1;

    for (int i = 0; i < linkedDevices.length; i++) {
      items.add(
        DropdownMenuItem(
          child: Text(linkedDevices[i].name),
          value: linkedDevices[i].id,
        ),
      );
    }

    if (linkedDevices.length == 0) {
      return ListTile(
        title: Text(
          translations['no linked devices'],
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }

    List<DropdownMenuItem> itemsQuizType = <DropdownMenuItem>[];
    itemsQuizType.add(
      DropdownMenuItem(
        child: Text(translations['quiz show sound and image']),
        value: 3,
      ),
    );
    // itemsQuizType.add(
    //   DropdownMenuItem(
    //     child: Text(translations['quiz show image']),
    //     value: 1,
    //   ),
    // );
    itemsQuizType.add(
      DropdownMenuItem(
        child: Text(translations['quiz sound image']),
        value: 2,
      ),
    );
    itemsQuizType.add(
      DropdownMenuItem(
        child: Text(translations['quiz do not show anything']),
        value: 4,
      ),
    );

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                translations['send to device'],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                width: 70,
                padding: EdgeInsets.only(left: 5.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    value: selectedLinkedDevice,
                    //isDense: true,
                    onChanged: (newValue) async {
                      if (mounted) {
                        setState(() {
                          selectedLinkedDevice = newValue;
                        });
                      }
                    },
                    items: items,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  translations['quiz type'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                      isExpanded: true,
                      value: selectedQuizType,
                      //isDense: true,
                      onChanged: (newValue) async {
                        if (mounted) {
                          setState(() {
                            selectedQuizType = newValue;
                          });
                        }
                      },
                      items: itemsQuizType,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                // shape: RoundedRectangleBorder(
                //     borderRadius: new BorderRadius.circular(30.0)),
                child: Text(translations['send quiz'].toUpperCase()),
                onPressed: () async {
                  await sendQuiz();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> sendQuiz() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    List<MObject> conceptsInVoiceBox = lucasState.getImageCards();

    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    List<Map<String, dynamic>> objects = <Map<String, dynamic>>[];
    for (int j = 0; j < conceptsInVoiceBox.length; j++) {
      String objectType = '';
      int objectId = conceptsInVoiceBox[j].id;
      if (conceptsInVoiceBox[j] is MImage) objectType = 'image';
      if (conceptsInVoiceBox[j] is MVideo) objectType = 'video';
      if (conceptsInVoiceBox[j] is MSound) objectType = 'sound';
      if (conceptsInVoiceBox[j] is MFolder) objectType = 'folder';
      if (conceptsInVoiceBox[j] is MEmpty) objectType = 'empty';

      objects.add({
        'object_type': objectType,
        'object_id': objectId,
      });
    }

    MLinkedDevice mLinkedDevice =
        await MLinkedDevice.getByID(selectedLinkedDevice);
    Uuid quizUUID = new Uuid();
    String quizId = quizUUID.v1().replaceAll('-', '');

    String localUserEmail = await LocalPreferences.getString('userEmail', '');
    String localUserName = await LocalPreferences.getString('userName', '');

    String body = jsonEncode(
      <String, dynamic>{
        // 'notification': <String, dynamic>{
        //   'body': UniqueKey().toString(),
        //   'title': UniqueKey().toString(),
        // },
        'priority': 'high',
        'data': <String, dynamic>{
          'sender email': localUserEmail,
          'sender name': localUserName,
          'timestamp': DateTime.now().toIso8601String(),
          'message type': PushMessageType.quiz,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'quiz id': quizId,
          'quiz type': selectedQuizType,
          'objects': objects,
        },
        'to': mLinkedDevice.token,
      },
    );

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Helper.serverToken}',
      },
      body: body,
    );

    showOperationSuccessfull();
  }

  showOperationSuccessfull() {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: L.getLocalizedText('operation completed successfully'),
    );

    //Scaffold.of(context).showSnackBar(snackBar);
    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget getLevel1View(
      BuildContext context, String currentLevel, String firstReinforcer) {
    bool ignoreVisibility = true;

    if (firstReinforcer.isEmpty) {
      return firstReinforcerMissingView(context, firstReinforcer);
    }

    // MImage imageCard1;
    // MImage.getByID(int.parse(firstReinforcer)).then((mImage) {
    //   imageCard1 = mImage;
    // });

    //MImage imageCard1 = await MImage.getByID(int.parse(firstReinforcer));
    List<int> ids = <int>[];
    ids.add(int.parse(firstReinforcer));

    return FutureBuilder(
      future: MImage.getSeveralByID(ids),
      builder:
          (BuildContext context, AsyncSnapshot<Map<int, MImage>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                        Container(
                          child: buildImageCardNoSize(
                            ignoreVisibility,
                            context,
                            snapshot.data[int.parse(firstReinforcer)],
                            currentLevel,
                          ),
                        )
                      ])),
                ],
              );
            }
        }
        return Text("");
      },
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[
    //     Expanded(
    //       child: buildImageCardNoSize(context, imageCard1, currentLevel),
    //     ),
    //   ],
    // );
  }

  Widget getLevel2View(BuildContext context, String currentLevel,
      String firstReinforcer, String secondReinforcer) {
    bool ignoreVisibility = true;

    if (firstReinforcer.isEmpty) {
      return firstReinforcerMissingView(context, firstReinforcer);
    }
    if (secondReinforcer.isEmpty) {
      return secondReinforcerMissingView(context, secondReinforcer);
    }

    // MImage imageCard1 = MImage.getImage(int.parse(firstReinforcer));
    // MImage imageCard2 = MImage.getImage(int.parse(secondReinforcer));
    // MImage imageCard1;
    // MImage.getByID(int.parse(firstReinforcer)).then((mImage) {
    //   imageCard1 = mImage;
    // });

    // MImage imageCard2;
    // MImage.getByID(int.parse(secondReinforcer)).then((mImage) {
    //   imageCard2 = mImage;
    // });

    // MImage imageCard1 = await MImage.getByID(int.parse(firstReinforcer));
    // MImage imageCard2 = await MImage.getByID(int.parse(secondReinforcer));
    List<int> ids = <int>[];
    ids.add(int.parse(firstReinforcer));
    ids.add(int.parse(secondReinforcer));

    return FutureBuilder(
      future: MImage.getSeveralByID(ids),
      builder:
          (BuildContext context, AsyncSnapshot<Map<int, MImage>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          Container(
                            child: buildImageCardNoSize(
                              ignoreVisibility,
                              context,
                              snapshot.data[int.parse(firstReinforcer)],
                              currentLevel,
                            ),
                          )
                        ])),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                          Container(
                            child: buildImageCardNoSize(
                                ignoreVisibility,
                                context,
                                snapshot.data[int.parse(secondReinforcer)],
                                currentLevel),
                          )
                        ])),
                  ]);
            }
        }
        return Text("");
      },
    );
  }

  Widget getLevel3View(BuildContext context, String currentLevel,
      String firstReinforcer, String secondReinforcer, String thirdReinforcer) {
    bool ignoreVisibility = true;

    if (firstReinforcer.isEmpty) {
      return firstReinforcerMissingView(context, firstReinforcer);
    }
    if (secondReinforcer.isEmpty) {
      return secondReinforcerMissingView(context, secondReinforcer);
    }
    if (thirdReinforcer.isEmpty) {
      return thirdReinforcerMissingView(context, thirdReinforcer);
    }

    // MImage imageCard1 = MImage.getImage(int.parse(firstReinforcer));
    // MImage imageCard2 = MImage.getImage(int.parse(secondReinforcer));
    // MImage imageCard3 = MImage.getImage(int.parse(thirdReinforcer));

    // MImage imageCard1;
    // MImage.getByID(int.parse(firstReinforcer)).then((mImage) {
    //   imageCard1 = mImage;
    // });

    // MImage imageCard2;
    // MImage.getByID(int.parse(secondReinforcer)).then((mImage) {
    //   imageCard2 = mImage;
    // });

    // MImage imageCard3;
    // MImage.getByID(int.parse(thirdReinforcer)).then((mImage) {
    //   imageCard3 = mImage;
    // });

    // MImage imageCard1 = await MImage.getByID(int.parse(firstReinforcer));
    // MImage imageCard2 = await MImage.getByID(int.parse(secondReinforcer));
    // MImage imageCard3 = await MImage.getByID(int.parse(thirdReinforcer));
    List<int> ids = <int>[];
    ids.add(int.parse(firstReinforcer));
    ids.add(int.parse(secondReinforcer));
    ids.add(int.parse(thirdReinforcer));

    return FutureBuilder(
      future: MImage.getSeveralByID(ids),
      builder:
          (BuildContext context, AsyncSnapshot<Map<int, MImage>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: buildImageCardNoSize(
                                        ignoreVisibility,
                                        context,
                                        snapshot
                                            .data[int.parse(firstReinforcer)],
                                        currentLevel)),
                              ]),
                        )
                      ])),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                        Container(
                            child: buildImageCardNoSize(
                                ignoreVisibility,
                                context,
                                snapshot.data[int.parse(secondReinforcer)],
                                currentLevel))
                      ])),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: buildImageCardNoSize(
                                  ignoreVisibility,
                                  context,
                                  snapshot.data[int.parse(thirdReinforcer)],
                                  currentLevel))
                        ]),
                  ),
                ],
              );
            }
        }
        return Text("");
      },
    );
  }

  Widget getLevel4View(BuildContext context, String currentLevel,
      String firstReinforcer, String secondReinforcer, String thirdReinforcer) {
    bool ignoreVisibility = true;

    if (firstReinforcer.isEmpty) {
      return firstReinforcerMissingView(context, firstReinforcer);
    }
    if (secondReinforcer.isEmpty) {
      return secondReinforcerMissingView(context, secondReinforcer);
    }
    if (thirdReinforcer.isEmpty) {
      return thirdReinforcerMissingView(context, thirdReinforcer);
    }

    // MImage imageCard1 = MImage.getImage(int.parse(firstReinforcer));
    // MImage imageCard2 = MImage.getImage(int.parse(secondReinforcer));
    // MImage imageCard3 = MImage.getImage(int.parse(thirdReinforcer));

    // MImage imageCard1 = await MImage.getByID(int.parse(firstReinforcer));
    // MImage imageCard2 = await MImage.getByID(int.parse(secondReinforcer));
    // MImage imageCard3 = await MImage.getByID(int.parse(thirdReinforcer));
    List<int> ids = <int>[];
    ids.add(int.parse(firstReinforcer));
    ids.add(int.parse(secondReinforcer));
    ids.add(int.parse(thirdReinforcer));

    // MImage imageCard1;
    // MImage.getByID(int.parse(firstReinforcer)).then((mImage) {
    //   imageCard1 = mImage;
    // });

    // MImage imageCard2;
    // MImage.getByID(int.parse(secondReinforcer)).then((mImage) {
    //   imageCard2 = mImage;
    // });

    // MImage imageCard3;
    // MImage.getByID(int.parse(thirdReinforcer)).then((mImage) {
    //   imageCard3 = mImage;
    // });

    return FutureBuilder(
      future: MImage.getSeveralByID(ids),
      builder:
          (BuildContext context, AsyncSnapshot<Map<int, MImage>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Column(
                children: <Widget>[
                  buildVoiceBox(context),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              Expanded(
                                child: buildImageCardNoSize(
                                    ignoreVisibility,
                                    context,
                                    snapshot.data[int.parse(firstReinforcer)],
                                    currentLevel),
                              )
                            ])),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              Expanded(
                                child: buildImageCardNoSize(
                                    ignoreVisibility,
                                    context,
                                    snapshot.data[int.parse(secondReinforcer)],
                                    currentLevel),
                              )
                            ])),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              Expanded(
                                child: buildImageCardNoSize(
                                    ignoreVisibility,
                                    context,
                                    snapshot.data[int.parse(thirdReinforcer)],
                                    currentLevel),
                              )
                            ])),
                      ],
                    ),
                  )
                ],
              );
            }
        }
        return Text("");
      },
    );
  }

  Widget getLevel5View(
      BuildContext context, String currentLevel, int parentFolderId) {
    if (parentFolderId == -2) {
      return defaultFolderNotSelected(context);
    }

    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Expanded(
          child: ObjectGrid(currentLevel, _onItemTap, _onItemDoubleTap,
              _onItemLongPress, null),
        ),
        //buildFolderBar(),
      ],
    );
  }

  Widget getLevel6View(
      BuildContext context, String currentLevel, int parentFolderId) {
    if (gridWidget == null) {
      gridWidget = ObjectGrid(
        currentLevel,
        _onItemTap,
        _onItemDoubleTap,
        _onItemLongPress,
        null,
        key: UniqueKey(),
      );
    }

    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Expanded(
          child: gridWidget,
        ),
        buildFolderBar(),
      ],
    );
  }

  Widget getLevel7View(
      BuildContext context, String currentLevel, int parentFolderId) {
    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Expanded(
          child: ObjectGrid(
            currentLevel,
            _onItemTap,
            _onItemDoubleTap,
            _onItemLongPress,
            null,
          ),
        ),
        buildFolderBar(),
      ],
    );
  }

  Widget getLevel8View(
      BuildContext context, String currentLevel, int parentFolderId) {
    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Expanded(
          child: ObjectGrid(
            currentLevel,
            _onItemTap,
            _onItemDoubleTap,
            _onItemLongPress,
            null,
          ),
        ),
        buildFolderBar(),
      ],
    );
  }

  Widget getLevel9View(
      BuildContext context, String currentLevel, int parentFolderId) {
    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Expanded(
          child: ObjectGrid(
            currentLevel,
            _onItemTap,
            _onItemDoubleTap,
            _onItemLongPress,
            null,
          ),
        ),
        buildFolderBar(),
      ],
    );
  }

  Widget getLevel10View(
      BuildContext context, String currentLevel, int parentFolderId) {
    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Expanded(
          child: ObjectGrid(
            currentLevel,
            _onItemTap,
            _onItemDoubleTap,
            _onItemLongPress,
            null,
          ),
        ),
        buildFolderBar(),
      ],
    );
  }

  Widget getLevel11View(
      BuildContext context, String currentLevel, int parentFolderId) {
    return Column(
      children: <Widget>[
        buildVoiceBox(context),
        buildQuizSection(),
        Card(
          color: Colors.redAccent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: ListTile(
                  title: L.getText("level not enabled"),
                  subtitle: L.getText("not enough data"),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ObjectGrid(
            currentLevel,
            _onItemTap,
            _onItemDoubleTap,
            _onItemLongPress,
            null,
          ),
        ),
        buildFolderBar(),
      ],
    );
  }

  Widget buildFolderBar({bool isObjectSelected = true}) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    MFolder currentFolder = lucasState.getObject(StateProperties.currentFolder);
    if (currentFolder == null) {
      return Container(); //defaultFolderNotSelected(context);
    }

    if (currentFolder != null && currentFolder.id == -1) return Container();

    Widget folderName = currentFolder == null
        ? Container()
        : Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(currentFolder.textToShow,
                  style: TextStyle(color: Colors.black, fontSize: 30.0)),
            ),
          );

    Widget folderBar = Card(
      color: Colors.white, // Theme.of(context).primaryColor,
      //
      child: Container(
        padding: EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6.0),
              child: currentFolder.id == -1
                  ? Container()
                  : GestureDetector(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.home,
                            size: 32.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => {_onItemTap(mHomeFolder)},
                    ),
            ),
            // current folder name
            folderName,
            // go to parent folder
            (currentFolder == null || currentFolder.id == -1)
                ? Container()
                : Container(
                    padding: EdgeInsets.all(6.0),
                    child: GestureDetector(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.undo,
                            size: 32.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => {gotoParentFolder()},
                    ),
                  ),
          ],
        ),
      ),
    );

    return folderBar;
  }

  gotoParentFolder() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    MFolder currentFolder = lucasState.getObject(StateProperties.currentFolder);

    MFolder pFolder = await MFolder.getByID(currentFolder.parentFolderId);
    _onItemTap(pFolder);
  }

  Widget buildImageCardNoSize(bool ignoreVisibility, BuildContext context,
      MImage imageCard, String currentLevel) {
    if (imageCard == null) {
      if (currentLevel == "1") return firstReinforcerMissingView(context, '');
      if (currentLevel == "2") return secondReinforcerMissingView(context, '');
      if (currentLevel == "3") return thirdReinforcerMissingView(context, '');
    }
    WImage wImage = WImage(ignoreVisibility, imageCard, currentLevel,
        _onItemTap, _onItemDoubleTap, _onItemLongPress);
    //wImage.setMImage(imageCard);
    return wImage;
  }

  Widget buildVoiceBox(BuildContext context) {
    return
        // PropertyChangeProvider(
        //   value: LucasState(),
        //   child:
        //   PropertyChangeProvider(
        // value: LucasState(),
        // child:
        VoiceBox(); //,
    //);
    //   ,
    // );
  }

  Widget firstReinforcerMissingView(BuildContext context, String reinforcer) {
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
      return Colors.white;
    }

    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Card(
            color: reinforcer.isEmpty ? Colors.redAccent : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: ListTile(
                    title: L.getText("missing reinforcer"),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        L.getText("level1 How do we achieve this"),
                      ],
                    ),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateColor.resolveWith(getBackgroundColor),
                      ),

                      // todo
                      // shape: RoundedRectangleBorder(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(20.0))),

                      child: L.getUpperText("select reinforcer"),

                      //color: Colors.white,
                      onPressed: () async {
                        Route route = MaterialPageRoute(
                            builder: (context) =>
                                ImageSettings(true, false, false, false));
                        Navigator.push(context, route);
                      },
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

  Widget secondReinforcerMissingView(BuildContext context, String reinforcer) {
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
      return Colors.white;
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Card(
          color: reinforcer.isEmpty ? Colors.redAccent : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: ListTile(
                  title: L.getText("missing reinforcer"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      L.getText("level2 How do we achieve this"),
                    ],
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith(getBackgroundColor),
                    ),

                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    //color: Colors.white,
                    child: L.getUpperText("select second reinforcer"),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) =>
                              ImageSettings(false, true, false, false));
                      Navigator.push(context, route);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget thirdReinforcerMissingView(BuildContext context, String reinforcer) {
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
      return Colors.white;
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Card(
          color: reinforcer.isEmpty ? Colors.redAccent : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: ListTile(
                  title: L.getText("missing reinforcer"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      L.getText("level3 How do we achieve this"),
                    ],
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith(getBackgroundColor),
                    ),

                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    //color: Colors.white,
                    child: L.getUpperText("select third reinforcer"),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) =>
                              ImageSettings(false, false, true, false));
                      Navigator.push(context, route);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget defaultFolderNotSelected(BuildContext context) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    int defaultFolder =
        lucasState.getObject(StateProperties.defaultFolderId) ?? -2;

    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Card(
            color: defaultFolder == -2 ? Colors.redAccent : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: ListTile(
                    title: L.getText("no default folder"),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        L.getText("please select a default folder"),
                      ],
                    ),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: L.getUpperText("select folder"),

                      //color: Colors.white,
                      onPressed: () async {
                        final lucasState =
                            PropertyChangeProvider.of<LucasState>(context,
                                    listen: false)
                                .value;
                        int currentFolderId = lucasState
                                .getObject(StateProperties.currentFolderId) ??
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
                          parentFolder = await MFolder.getByID(
                              currentFolder.parentFolderId);
                        lucasState.saveObject(
                            StateProperties.currentFolder, currentFolder);
                        lucasState.saveObject(
                            StateProperties.parentFolder, parentFolder);
                        lucasState.saveObject(StateProperties.isEditMode, true);

                        String currentLevel = await LocalPreferences.getString(
                            "currentLevel", "1");

                        Route route = MaterialPageRoute(
                            builder: (context) => Folders(currentLevel));
                        Navigator.push(context, route);
                      },
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

  Widget getNothingIsVisibleNotification(
      BuildContext context, int currentLevel) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: ListTile(
                    title: L.getText("nothing unlocked"),
                    subtitle: currentLevel != 5
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              L.getText("please unlock"),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              L.getText("nothing unlocked instructions"),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  _onItemTap(MObject mObject) async {
    ///////_unselectAllObjects();

    if (mObject is MFolder) {
      MFolder mfolder = mObject;

      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      //LucasState.canNotify = false;

      lucasState.saveObject(StateProperties.selectedFolder, mfolder);
      lucasState.saveObject(StateProperties.currentFolderId, mfolder.id);

      int gridColumns = lucasState.getGridColumns();

      await LocalPreferences.setInt('currentLearningFolderId', mfolder.id);

      String strCurrentLevel =
          await LocalPreferences.getString("currentLevel", "1");
      int currentLevel = int.parse(strCurrentLevel);

      List<MObject> learningObjects =
          await MRelation.getLearningObjectsInFolder(
              currentLevel, mfolder.id, gridColumns);
      lucasState.saveObject(StateProperties.learningObjects, learningObjects);

      MFolder currentFolder = await MFolder.getByID(mfolder.id);
      MFolder parentFolder;
      currentFolder.isVisible = mObject.isVisible;
      currentFolder.relationId = mObject.relationId;

      if (currentFolder == null)
        parentFolder = null;
      else
        parentFolder = await MFolder.getByID(currentFolder.parentFolderId);
      lucasState.saveObject(StateProperties.currentFolder, currentFolder);
      lucasState.saveObject(StateProperties.parentFolder, parentFolder);

      //LucasState.canNotify = true;
      //lucasState.notifyAll();

      // refresh screen
      if (mounted) setState(() {});

      // setState(() {
      //   currentFolderId = mfolder.id;
      // });

      //_unselectAllObjects();
    } else {
      if (mObject is MEmpty) {
        // do nothing (do not add the empty object to the voice box)
      }
      if (mObject is MImage) {
        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        lucasState.addImageCard(mObject);
      }
      if (mObject is MVideo) {
        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        lucasState.addVideoCard(mObject);
      }
      if (mObject is MSound) {
        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        lucasState.addSoundCard(mObject);
      }
    }

    // refresh screen
    //if (mounted) setState(() {});
  }

  _onItemDoubleTap(MObject mObject) async {}

  _onItemLongPress(MObject mObject) async {
    if (!Helper.allowLongPressInLearningScreen) return;

    _showDialog(mObject);
  }

  void _showDialog(MObject mObject) async {
    if (mObject is MEmpty) {
      return;
    }

    String strCurrentLevel =
        await LocalPreferences.getString("currentLevel", "1");

    Widget objectWidget;
    if (mObject is MFolder) {
      objectWidget = WFolder(
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      //fileName = mObject.fileName;
    }
    if (mObject is MImage) {
      MImage mImage = mObject;
      objectWidget = WImage(
        true,
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      if (mImage.useAsset == 0) {
        objectWidget =
            Container(padding: EdgeInsets.all(3.0), child: objectWidget);
      }
    }
    if (mObject is MVideo) {
      MVideo mVideo = mObject;
      objectWidget = WVideo(
        true,
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      if (mVideo.useAsset == 0) {
        objectWidget =
            Container(padding: EdgeInsets.all(3.0), child: objectWidget);
      }
    }
    if (mObject is MSound) {
      MSound mSound = mObject;
      objectWidget = WSound(
        true,
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      if (mSound.useAsset == 0) {
        objectWidget =
            Container(padding: EdgeInsets.all(3.0), child: objectWidget);
      }
    }

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          //title: new Text(mObject.textToShow),
          backgroundColor:
              Color(_getColorFromHex(mObject.backgroundColor ?? 'ffffff')),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(
              //height: MediaQuery.of(context).size.height / 2,
              //child: Card(
              //child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Expanded(
                child: //objectWidget,
                    mObject.useAsset == 0
                        ? Image.file(
                            File(
                                '${Helper.appDirectory}/${mObject.localFileName}'),
                            width: MediaQuery.of(context).size.width * 3,
                            height: MediaQuery.of(context).size.height,
                          )
                        : Image.asset(
                            mObject.fileName ?? '',
                            width: MediaQuery.of(context).size.width * 3,
                            height: MediaQuery.of(context).size.height,
                          ),
              ),
              Expanded(
                child: Text(
                  mObject.textToShow ?? '',
                  //_strNotAssigned,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),
              )
              //],
              //),
              //),
              //),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
