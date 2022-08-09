// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/PushMessageType.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/Tuple.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MLinkedDevice.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MQuiz.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/screens/TextToSpeech.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transparent_image/transparent_image.dart';

class VoiceBox extends StatefulWidget {
  //final BuildContext context;

  VoiceBox({Key key}) : super(key: key);

  @override
  _VoiceBoxState createState() {
    return _VoiceBoxState();
  }
}

//enum TtsState { playing, stopped }

class _VoiceBoxState extends State<VoiceBox> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, String> translations = Map<String, String>();
  List<String> translationItems = [
    'silent quiz ongoing',
    'play quiz',
    'result is correct',
    'result is wrong',
  ];

  List<MObject> imageCards;
  int objectIndexToPlay = -1;
  int quizBoxIndexToPlay = -1;
  String currentLevel;
  bool pressed = true;

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _localUserEmail = '';
  List<MLinkedDevice> _linkedDevices = <MLinkedDevice>[];
  //String _localToken = '';

  //FlutterSound flutterSound;
  int canCreateQuiz = 0;
  bool isQuizMode = false;
  String quizType = '3';
  String quizId = '';
  String quizObjects = '';
  String quizSender = '';
  List<MObject> quizCards;

  _VoiceBoxState() {
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

    // flutterSound = new FlutterSound();
    // flutterSound.setSubscriptionDuration(0.01);
    // flutterSound.setDbPeakLevelUpdate(0.8);
    // flutterSound.setDbLevelEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await processOnMessage(message.data);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await processOnLaunch(message.data);
    });

    //await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);

    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   if (mounted) {
    //     setState(() {
    //       _localToken = token;
    //     });
    //   }
    //   print('Local token: $_localToken');
    // });
  }

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);

    canCreateQuiz = await LocalPreferences.getInt('canCreateQuiz', 0);
    isQuizMode = await LocalPreferences.getBool("isQuizMode", false);

    quizType = await LocalPreferences.getString("quizType", '3');
    quizId = await LocalPreferences.getString("quizId", '');
    quizObjects = await LocalPreferences.getString("quizObjects", '');
    quizSender = await LocalPreferences.getString("quizSender", '');

    if (quizObjects != '') quizCards = await buildQuizCards(quizObjects);

    Tuple t1 = Tuple("currentLevel", "1", "String");
    List<Tuple> tuples = [t1];

    Map prefs = await LocalPreferences.getInfo(tuples);
    currentLevel = prefs['currentLevel'];

    // String strUserEmail = await LocalPreferences.getString('userEmail', '');
    // String strUserName = await LocalPreferences.getString('userName', '');
    String strLocalUserEmail =
        await LocalPreferences.getString('userEmail', '');

    //Map<String, String> result = await L.getItems(translationItems);
    Map<String, String> result = await L.getItems(translationItems);

    if (mounted) {
      setState(() {
        _localUserEmail = strLocalUserEmail;
        translations = result;
      });
    }

    await getLinkedDevicesToOutputVoicebox();
  }

  Future<void> getLinkedDevicesToOutputVoicebox() async {
    List<MLinkedDevice> objects =
        await MLinkedDevice.getDevicesForVoiceboxOutput(false);
    if (objects == null) objects = <MLinkedDevice>[];

    if (mounted) {
      setState(() {
        _linkedDevices = objects;
      });
   }
  }

  Future<void> processOnMessage(Map<String, dynamic> message) async {
    // if (_localToken == null) return;
    // if (_localToken.isEmpty) return;

    String senderEmail = getValueInMessage(message, 'sender email');
    if (_localUserEmail != senderEmail) {
      String messageType = getValueInMessage(message, 'message type');
      if (messageType == PushMessageType.say) {
        //Map<String, dynamic> data = message['body'];
        // String emailSender =
        //     message['sender email'] ?? message['data']['sender email'];
        // String senderName =
        //     message['sender name'] ?? message['data']['sender name'];
        String strObjects = message['objects'] ?? message['data']['objects'];
        List<dynamic> objects = jsonDecode(strObjects);

        imageCards = <MObject>[];
        for (int i = 0; i < objects.length; i++) {
          Map<String, dynamic> object = objects[i];
          String objectType = object['object_type'];
          int objectId = object['object_id'];

          if (objectType == 'folder') {
            imageCards.add(await MFolder.getByID(objectId));
          }
          if (objectType == 'image') {
            imageCards.add(await MImage.getByID(objectId));
          }
          if (objectType == 'video') {
            imageCards.add(await MVideo.getByID(objectId));
          }
          if (objectType == 'sound') {
            imageCards.add(await MSound.getByID(objectId));
          }
        }
        setState(() {});

        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        lucasState.setImageCards(imageCards);

        objectIndexToPlay = -1;
        await playImageCards();
        // await saveLinkedDevice(message);
      }
      if (messageType == PushMessageType.quiz) {
        String quizType = getValueInMessage(message, 'quiz type');
        String quizId = getValueInMessage(message, 'quiz id');
        String strObjects = message['objects'] ?? message['data']['objects'];
        await processQuizMessage(senderEmail, quizType, quizId, strObjects);
      }
      if (messageType == PushMessageType.answerQuiz) {
        String answerStudentEmail = getValueInMessage(message, 'sender email');
        int answerTimestamp = DateTime.now().microsecondsSinceEpoch;
        String answerQuizType = getValueInMessage(message, 'quiz type');
        String answerQuestion =
            message['question'] ?? message['data']['question'];
        String answerAnswer = message['answer'] ?? message['data']['answer'];
        int answerIsCorrect = answerQuestion == answerAnswer ? 1 : 0;
        await processQuizAnswerMessage(answerStudentEmail, answerTimestamp,
            answerQuizType, answerQuestion, answerAnswer, answerIsCorrect);
      }
    }

    /* JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(message);
    //print(prettyprint);

    // setState(() {
    //   _messageText = "Message: $prettyprint";
    //   isLinking = false;
    // });
    print("onMessage: $prettyprint"); */
  }

  Future<List<MObject>> buildQuizCards(String qObjects) async {
    List<dynamic> quizObjects = jsonDecode(qObjects);

    List<MObject> qQuizCards = <MObject>[];
    for (int i = 0; i < quizObjects.length; i++) {
      Map<String, dynamic> object = quizObjects[i];
      String objectType = object['object_type'];
      int objectId = object['object_id'];

      if (objectType == 'folder') {
        MFolder entity = await MFolder.getByID(objectId);
        qQuizCards.add(await entity.clone());
      }
      if (objectType == 'image') {
        MImage entity = await MImage.getByID(objectId);
        qQuizCards.add(await entity.clone());
      }
      if (objectType == 'video') {
        MVideo entity = await MVideo.getByID(objectId);
        qQuizCards.add(await entity.clone());
      }
      if (objectType == 'sound') {
        MSound entity = await MSound.getByID(objectId);
        qQuizCards.add(await entity.clone());
      }
    }

    return qQuizCards;
  }

  Future<void> processQuizAnswerMessage(
      String answerStudentEmail,
      int answerTimestamp,
      String answerQuizType,
      String answerQuestion,
      String answerAnswer,
      int answerIsCorrect) async {
    if (answerQuizType == '4') {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: L.getText('please confirm'),
            //content: L.getText('confirm delete story'),
            actions: <Widget>[
              new TextButton(
                child: Text(translations['result is correct']),
                onPressed: () async {
                  answerIsCorrect = 1;

                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: Text(translations['result is wrong']),
                onPressed: () {
                  answerIsCorrect = 0;

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    if (answerIsCorrect == 1) {
      showQuizResult(Colors.blue, translations['result is correct']);
    } else {
      showQuizResult(Colors.red, translations['result is wrong']);
    }

    List<MObject> listOfObjectsInQuestion =
        await buildQuizCards(answerQuestion);

    List<String> textsToShow = <String>[];
    for (MObject mObject in listOfObjectsInQuestion) {
      textsToShow.add(mObject.textToShow);
    }

    String concepts = textsToShow.join(', ');
    int numberOfConcepts = textsToShow.length;

    MQuiz mQuiz = new MQuiz();
    mQuiz.id = await MQuiz.maxId();
    mQuiz.studentEmail = answerStudentEmail;
    mQuiz.timestamp = answerTimestamp;
    mQuiz.quizType = answerQuizType;
    mQuiz.question = answerQuestion;
    mQuiz.answer = answerAnswer;
    mQuiz.isCorrect = answerIsCorrect;
    mQuiz.concepts = concepts;
    mQuiz.numberOfConcepts = numberOfConcepts;

    if (mQuiz.numberOfConcepts > 0) {
      await MQuiz.createWithID(mQuiz);
    }
  }

  showQuizResult(Color color, String message) {
    //final scaffold = Scaffold.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
    // scaffold.showSnackBar(
    //   SnackBar(
    //     backgroundColor: color,
    //     content: Text(message),
    //   ),
    // );

    // if (!mounted) return;

    // final snackBar = SnackBar(
    //   content: Text(message),
    // );

    // //Scaffold.of(context).showSnackBar(snackBar);
    // if (_scaffoldKey.currentState != null) {
    //   _scaffoldKey.currentState.showSnackBar(snackBar);
    // }
  }

  Future<void> processQuizMessage(
      String senderEmail, String qType, String qId, String qObjects) async {
    await LocalPreferences.setBool("isQuizMode", true);

    List<MObject> qQuizCards = await buildQuizCards(qObjects);

    if (mounted) {
      setState(() {
        isQuizMode = true;
        quizType = qType;
        quizId = qId;
        quizSender = senderEmail;
        quizCards = qQuizCards;
      });
    }

    await LocalPreferences.setString("quizType", quizType);
    await LocalPreferences.setString("quizId", quizId);
    await LocalPreferences.setString("quizObjects", qObjects);
    await LocalPreferences.setString("quizSender", quizSender);

    //print('Quiz type: $quizType, Quiz ID: $quizId, Send by: $senderEmail');
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
  }

  String getValueInMessage(Map<String, dynamic> message, String property) {
    if (message['data'] != null) {
      return message['data'][property].toString();
    }

    return message[property].toString();
  }

  @override
  Widget build(BuildContext context) {
    if (translations == null) return Container();

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, properties: [
      StateProperties.voiceBoxItems,
      StateProperties.isEditMode,
      StateProperties.refreshVoiceBox,
    ]).value;

    //return
    // PropertyChangeConsumer<LucasState>(
    //   properties: [
    //     StateProperties.voiceBoxItems,
    //     StateProperties.isEditMode,
    //     StateProperties.refreshVoiceBox,
    //     //StateProperties.currentFolder
    //   ],
    //   builder: (context, lucasState, property) {
    if (currentLevel == null) return Container();

    imageCards = lucasState.getImageCards();

    final items = <Widget>[];

    if (imageCards != null) {
      for (var i = 0; i < imageCards.length; i++) {
        //items.add(buildThumbnail(context, imageCards[i]));

        // esto fue comentado byscando solucionar: •	Images in voice box must apprear exactly like in icons (with their description)
        //items.add(MVoiceboxThumbnail(imageCards[i], key: UniqueKey()));

        Widget widget = Container();

        if (imageCards[i] is MImage) {
          MImage mImage = imageCards[i];
          widget = getVoiceBoxCard(
              imageCards[i].highlighted,
              mImage.useAsset,
              mImage.fileName,
              mImage.localFileName,
              mImage.isAvailable,
              mImage.textToShow);
        }
        if (imageCards[i] is MFolder) {
          MFolder mFolder = imageCards[i];
          widget = getVoiceBoxCard(
              imageCards[i].highlighted,
              mFolder.useAsset,
              mFolder.fileName,
              mFolder.localFileName,
              mFolder.isAvailable,
              mFolder.textToShow);
        }
        if (imageCards[i] is MVideo) {
          MVideo mVideo = imageCards[i];
          widget = getVoiceBoxCard(
              imageCards[i].highlighted,
              mVideo.useAsset,
              mVideo.fileName,
              mVideo.localFileName,
              mVideo.isAvailable,
              mVideo.textToShow);
        }
        if (imageCards[i] is MSound) {
          MSound mSound = imageCards[i];
          widget = getVoiceBoxCard(
              imageCards[i].highlighted,
              mSound.useAsset,
              mSound.fileName,
              mSound.localFileName,
              mSound.isAvailable,
              mSound.textToShow);
        }

        items.add(widget);
      }
    }

    Widget voiceB = GestureDetector(
      onTap: () async {

          if (isQuizMode) {
            await LocalPreferences.setBool("isQuizMode", false);
            await sendQuizResults();
          }

          await playImageCards();

      },
      onDoubleTap: () {},
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        height: canCreateQuiz == 0
            ? Helper.voiceBoxHeight
            : Helper.smallVoiceBoxSizeForQuiz,
        child: Container(
          height: canCreateQuiz == 0
              ? Helper.voiceBoxHeight
              : Helper.smallVoiceBoxSizeForQuiz,
          //decoration: myOuterBoxDecoration(),
          padding: const EdgeInsets.all(3.0),
          //margin: const EdgeInsets.all(3.0),
          child: Container(
            color: Colors.white,
            //color: Theme.of(context).primaryColor,
            height: canCreateQuiz == 0
                ? Helper.voiceBoxHeight
                : Helper.smallVoiceBoxSizeForQuiz,
            child: ListView(
              scrollDirection: Axis.horizontal,
              //reverse: true,
              children: items,
            ),
            //     Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Expanded(
            //       child: ListView(
            //           scrollDirection: Axis.horizontal,
            //           //reverse: true,
            //           children: items,
            //         ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        isQuizMode ? showQuizOnScreen() : Container(),
        voiceB,
      ],
    );
    //   },
    // );
  }

  Widget showQuizOnScreen() {
    // if (quizType == '1') // quiz show image
    // {
    //   return populateQuizBox(canSoundImages: false);
    // }
    if (quizType == '2') // quiz sound image
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            // shape: RoundedRectangleBorder(
            //     borderRadius: new BorderRadius.circular(30.0)),
            //splashColor: Theme.of(context).accentColor,
            child: Text(translations['play quiz']),
            onPressed: () async {
              await playQuizCards();
            },
          ),
        ],
      );
    }
    if (quizType == '3') // quiz show sound and image
    {
      return populateQuizBox(canSoundImages: true);
    }
    if (quizType == '4') // quiz do not show anything
    {
      return Container(
        color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  translations['silent quiz ongoing'],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }
    // String quizType;
    // String quizId;
    // String quizObjects;
    return Container();
    //Text('senderEmail:$quizSender,quizType:$quizType, quizId:$quizId,quizObjects:$quizObjects');
  }

  Widget populateQuizBox({bool canSoundImages}) {
    if (quizCards == null) return Container();

    final items = <Widget>[];
    for (var i = 0; i < quizCards.length; i++) {
      Widget widget = Container();

      if (quizCards[i] is MImage) {
        MImage mImage = quizCards[i];
        widget = getVoiceBoxCard(
            quizCards[i].highlighted,
            mImage.useAsset,
            mImage.fileName,
            mImage.localFileName,
            mImage.isAvailable,
            mImage.textToShow);
      }
      if (quizCards[i] is MFolder) {
        MFolder mFolder = quizCards[i];
        widget = getVoiceBoxCard(
            quizCards[i].highlighted,
            mFolder.useAsset,
            mFolder.fileName,
            mFolder.localFileName,
            mFolder.isAvailable,
            mFolder.textToShow);
      }
      if (quizCards[i] is MVideo) {
        MVideo mVideo = quizCards[i];
        widget = getVoiceBoxCard(
            quizCards[i].highlighted,
            mVideo.useAsset,
            mVideo.fileName,
            mVideo.localFileName,
            mVideo.isAvailable,
            mVideo.textToShow);
      }
      if (quizCards[i] is MSound) {
        MSound mSound = quizCards[i];
        widget = getVoiceBoxCard(
            quizCards[i].highlighted,
            mSound.useAsset,
            mSound.fileName,
            mSound.localFileName,
            mSound.isAvailable,
            mSound.textToShow);
      }

      items.add(widget);
    }

    Widget quizBox = GestureDetector(
      onTap: () async {
        await playQuizCards();
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        height: Helper.smallVoiceBoxSizeForQuiz,
        child: Container(
          height: Helper.smallVoiceBoxSizeForQuiz,
          //decoration: myOuterBoxDecoration(),
          padding: const EdgeInsets.all(3.0),
          //margin: const EdgeInsets.all(3.0),
          child: Container(
            color: Colors.grey[350],
            height: Helper.smallVoiceBoxSizeForQuiz,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: items,
            ),
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        quizBox,
      ],
    );
  }

  Future<void> sendQuizResults() async {
    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    List<Map<String, dynamic>> objects = <Map<String, dynamic>>[];
    for (int j = 0; j < imageCards.length; j++) {
      String objectType = '';
      int objectId = imageCards[j].id;
      if (imageCards[j] is MImage) objectType = 'image';
      if (imageCards[j] is MVideo) objectType = 'video';
      if (imageCards[j] is MSound) objectType = 'sound';
      if (imageCards[j] is MFolder) objectType = 'folder';

      objects.add({
        'object_type': objectType,
        'object_id': objectId,
      });
    }

    List<Map<String, dynamic>> questionObjects = <Map<String, dynamic>>[];
    for (int j = 0; j < quizCards.length; j++) {
      String objectType = '';
      int objectId = quizCards[j].id;
      if (quizCards[j] is MImage) objectType = 'image';
      if (quizCards[j] is MVideo) objectType = 'video';
      if (quizCards[j] is MSound) objectType = 'sound';
      if (quizCards[j] is MFolder) objectType = 'folder';

      questionObjects.add({
        'object_type': objectType,
        'object_id': objectId,
      });
    }

    MLinkedDevice sendToDevice = await MLinkedDevice.getByEmail(quizSender);

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
          'message type': PushMessageType.answerQuiz,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'quiz id': quizId,
          'quiz type': quizType,
          'question': questionObjects,
          'answer': objects,
        },
        'to': sendToDevice.token,
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

    if (mounted) {
      setState(() {
        isQuizMode = false;
      });
    }

    await LocalPreferences.setString("quizType", '3');
    await LocalPreferences.setString("quizId", '');
    await LocalPreferences.setString("quizObjects", '');
    await LocalPreferences.setString("quizSender", '');

    return null;
  }

  Widget getVoiceBoxCard(bool highlighted, int useAsset, String assetFileName,
      String localFileName, int isAvailable, String textToShow) {
    // bool isMImageEmpty = false;
    // if (mImage == null) isMImageEmpty = true;
    // if (mImage != null && mImage.fileName == null) isMImageEmpty = true;

    Image localImage;
    if (useAsset == 0) {
      File f = File('${Helper.appDirectory}/$localFileName');
      localImage = Image.file(f);
    }

    return Container(
      color: highlighted ? Colors.green[200] : null,
      width: 2 * Helper.tileHeight(context),
      child: Column(
        children: <Widget>[
          (useAsset == 0 && localImage == null)
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
                  child: useAsset == 1
                      ? Image.asset(
                                assetFileName,
                              ) !=
                              null
                          ? Image.asset(
                              assetFileName,
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
                isAvailable == 1
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
              textToShow,
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

  @override
  void dispose() {
    // flutterSound.stopPlayer();
    // flutterSound.stopRecorder();
    super.dispose();
  }

  playImageCards() async {
    // initialize tts
    if(pressed) {
      pressed = false;
      FlutterTts flutterTts = await initializeTTS();
      if (flutterTts == null) {
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

        pressed = true;

        return;
      }

      FlutterSoundPlayer flutterSoundPlayer = await initializeAudioPlayer();

      flutterTts.setErrorHandler((msg) {
        return;
      });

      objectIndexToPlay = -1;

      flutterTts.setCompletionHandler(() {
        playNextObject(flutterTts, flutterSoundPlayer);
      });

      playNextObject(flutterTts, flutterSoundPlayer);
    }
  }

  playQuizCards() async {
    // initialize tts
    FlutterTts flutterTts = await initializeTTS();
    if (flutterTts == null) {
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
      return;
    }

    FlutterSoundPlayer flutterSoundPlayer = await initializeAudioPlayer();

    flutterTts.setCompletionHandler(() {
      //print("Complete $objectIndexToPlay");
      playQuizBoxNextObject(flutterTts, flutterSoundPlayer);
    });

    flutterTts.setErrorHandler((msg) {
      print("error");
      return;
    });

    quizBoxIndexToPlay = -1;
    await playQuizBoxNextObject(flutterTts, flutterSoundPlayer);
  }

  Future<FlutterTts> initializeTTS() async {
    String languageCountry =
        await LocalPreferences.getString("languageCountry", "");

    // initialize tts
    FlutterTts flutterTts = new FlutterTts();

    bool isLanguageAvailable =
        await flutterTts.isLanguageAvailable(languageCountry);

    if (!isLanguageAvailable) {
      /// TODO
      return null;
    }

    await flutterTts.setLanguage(languageCountry);

    // flutterTts.setStartHandler(() {
    //   setState(() {
    //     print("playing");
    //     ttsState = TtsState.playing;
    //   });
    // });

    // flutterTts.setCompletionHandler(() {
    //   print("Complete $objectIndexToPlay");
    //   playNextObject(flutterTts);
    // });

    // flutterTts.setErrorHandler((msg) {
    //   print("error");
    //   return;
    // });

    return flutterTts;
  }

  Future<FlutterSoundPlayer> initializeAudioPlayer() async {
    FlutterSoundPlayer flutterSoundPlayer = new FlutterSoundPlayer();
    // flutterSoundPlayer.setSubscriptionDuration(0.01);
    // flutterSoundPlayer.setDbPeakLevelUpdate(0.8);
    // flutterSoundPlayer.setDbLevelEnabled(true);

    return flutterSoundPlayer;
  }

  playNextObject(
      FlutterTts flutterTts, FlutterSoundPlayer flutterSoundPlayer) async {
    objectIndexToPlay++;

    // remove highlight on all objects
    for (int i = 0; i < imageCards.length; i++) {
      imageCards[i].highlighted = false;
    }

    if (objectIndexToPlay > imageCards.length - 1) {
      // imageCards = new List<MObject>();
      // final lucasState =
      //     PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      // lucasState.setImageCards(imageCards);

      await sendObjects();

      if (mounted) {
        setState(() {});
      }
      return;
    }

    if (objectIndexToPlay < 0) {
      await sendObjects();

      setState(() {});
      return;
    }

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    imageCards = lucasState.getImageCards();

    lucasState.setMustDeleteListOnImageAdd(true);

    bool objectIsImage = (imageCards[objectIndexToPlay] is MImage);
    bool objectIsVideo = (imageCards[objectIndexToPlay] is MVideo);
    bool objectIsSound = (imageCards[objectIndexToPlay] is MSound);

    // highlight object as they are played
    imageCards[objectIndexToPlay].highlighted = true;
    setState(() {});
    MObject mObject = imageCards[objectIndexToPlay];

    if (objectIsImage) {
      MImage mImage = mObject;
      await flutterTts.speak(mImage.textToSay);
    }

    if (objectIsSound) {
      MSound mSound = mObject;
      if (mSound.localSoundFileName.isEmpty)
        await flutterTts.speak(mSound.textToSay);
      else {
        await flutterSoundPlayer.startPlayer(
            fromURI: '${Helper.appDirectory}/${mSound.localSoundFileName}');
        flutterSoundPlayer.onProgress.listen((e) {
          if (e != null) {
            if (e.position == e.duration) {
              print(e);
              playNextObject(flutterTts, flutterSoundPlayer);
            }
          }
        });
      }
    }

    if (objectIsVideo) {
      MVideo mVideo = mObject;
      await flutterTts.speak(mVideo.textToSay);

      /* if (mVideo.localVideoPath.isEmpty)
            await flutterTts.speak(imageCards[i].textToSay);
          else {
            VideoPlayerController _controller;

            File fVideo = File(mVideo.localVideoPath);
            _controller = VideoPlayerController.file(fVideo);
            await _controller.initialize();
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          } */
    }

    if(objectIndexToPlay == imageCards.length - 1){
      pressed = true;
    }
  }

  playQuizBoxNextObject(
      FlutterTts flutterTts, FlutterSoundPlayer flutterSoundPlayer) async {
    quizBoxIndexToPlay++;

    // remove highlight on all objects
    for (int i = 0; i < quizCards.length; i++) {
      quizCards[i].highlighted = false;
    }

    if (quizBoxIndexToPlay > quizCards.length - 1) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    if (quizBoxIndexToPlay < 0) {
      setState(() {});
      return;
    }

    bool objectIsImage = (quizCards[quizBoxIndexToPlay] is MImage);
    bool objectIsVideo = (quizCards[quizBoxIndexToPlay] is MVideo);
    bool objectIsSound = (quizCards[quizBoxIndexToPlay] is MSound);

    // highlight object as they are played
    quizCards[quizBoxIndexToPlay].highlighted = true;
    setState(() {});

    MObject mObject = quizCards[quizBoxIndexToPlay];

    if (objectIsImage) {
      MImage mImage = mObject;
      await flutterTts.speak(mImage.textToSay);
    }

    if (objectIsSound) {
      MSound mSound = mObject;
      if (mSound.localSoundFileName.isEmpty)
        await flutterTts.speak(mSound.textToSay);
      else {
        await flutterSoundPlayer.startPlayer(
            fromURI: '${Helper.appDirectory}/${mSound.localSoundFileName}');
        flutterSoundPlayer.onProgress.listen((e) {
          if (e != null) {
            if (e.position == e.duration) {
              print(e);
              playNextObject(flutterTts, flutterSoundPlayer);
            }
          }
        });
      }
    }

    if (objectIsVideo) {
      MVideo mVideo = mObject;
      await flutterTts.speak(mVideo.textToSay);

      /* if (mVideo.localVideoPath.isEmpty)
            await flutterTts.speak(imageCards[i].textToSay);
          else {
            VideoPlayerController _controller;

            File fVideo = File(mVideo.localVideoPath);
            _controller = VideoPlayerController.file(fVideo);
            await _controller.initialize();
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          } */
    }
  }

  Future<void> sendObjects() async {
    if (imageCards.isEmpty) return;

    await FirebaseMessaging.instance.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);

    List<Map<String, dynamic>> objects = <Map<String, dynamic>>[];
    for (int j = 0; j < imageCards.length; j++) {
      String objectType = '';
      int objectId = imageCards[j].id;
      if (imageCards[j] is MImage) objectType = 'image';
      if (imageCards[j] is MVideo) objectType = 'video';
      if (imageCards[j] is MSound) objectType = 'sound';
      if (imageCards[j] is MFolder) objectType = 'folder';

      objects.add({
        'object_type': objectType,
        'object_id': objectId,
      });
    }

    for (int i = 0; i < _linkedDevices.length; i++) {
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
            'message type': PushMessageType.say,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'objects': objects,
          },
          'to': _linkedDevices[i].token,
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
    }
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
}
