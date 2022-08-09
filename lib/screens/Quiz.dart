import 'dart:convert';
import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MLinkedDevice.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MQuiz.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:transparent_image/transparent_image.dart';

import 'BottomNavigationOptions.dart';

class Quiz extends StatefulWidget {
  Quiz({Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Map<String, String> translations = Map<String, String>();
  List<String> translationItems = [
    'quizzes',
    'students',
    'find results',
    'number of concepts',
    'one concept',
    'two concepts',
    'three or more',
    'text to find',
    'text to find instructions',
  ];
  List<MLinkedDevice> linkedDevices = <MLinkedDevice>[];
  int selectedLinkedDevice = -1;
  int numberOfConceptsToLook = 1;
  String textToFind = '';
  List<QuizResultHelper> quizResults;

  _QuizState() {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
  }

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      //setState(() {});
    });
  }

  Future<void> initialize() async {
    Map<String, String> result = await L.getItems(translationItems);

    await getLinkedDevices();
    if (linkedDevices.length > 0) selectedLinkedDevice = linkedDevices.first.id;

    if (mounted) {
      setState(() {
        translations = result;
      });
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(translations['quizzes']),
      ),
      body: Column(
        children: <Widget>[
          getSearchFilters(),
          Expanded(child: showResults()),
        ],
      ),
      bottomNavigationBar: BottomNavigationOptions(),
    );
  }

  Widget getSearchFilters() {
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

    List<DropdownMenuItem> itemsConcepts = <DropdownMenuItem>[];

    itemsConcepts.add(
      DropdownMenuItem(
        child: Text(translations['one concept']),
        value: 1,
      ),
    );
    itemsConcepts.add(
      DropdownMenuItem(child: Text(translations['two concepts']), value: 2),
    );
    itemsConcepts.add(
      DropdownMenuItem(
        child: Text(translations['three or more']),
        value: 3,
      ),
    );

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            translations['students'],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
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
          Text(
            translations['number of concepts'],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                isExpanded: true,
                value: numberOfConceptsToLook,
                //isDense: true,
                onChanged: (newValue) async {
                  if (mounted) {
                    setState(() {
                      numberOfConceptsToLook = newValue;
                    });
                  }
                },
                items: itemsConcepts,
              ),
            ),
          ),
          Text(
            translations['text to find'],
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            translations['text to find instructions'],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: TextFormField(
              initialValue: '',
              onChanged: (text) async {
                textToFind = text;
              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.all(5.0),
              ),
            ),
          ),
          ElevatedButton(
            // shape: RoundedRectangleBorder(
            //     borderRadius: new BorderRadius.circular(30.0)),
            //splashColor: Theme.of(context).accentColor,
            child: Text(translations['find results']),
            onPressed: () async {
              //await MQuiz.dropTableIfExists();
              await findResults();
            },
          ),
        ],
      ),
    );
  }

  Future<void> findResults() async {
    MLinkedDevice mLinkedDevice =
        await MLinkedDevice.getByID(selectedLinkedDevice);
    List<dynamic> uniqueConcepts = await MQuiz.search(
        mLinkedDevice.email, numberOfConceptsToLook, textToFind);

    List<String> concepts = <String>[];
    for (var str in uniqueConcepts) {
      concepts.add(str.values.first);
    }

    List<QuizResultHelper> _quizResults = <QuizResultHelper>[];
    for (String concept in concepts) {
      List<MQuiz> quizzes = await MQuiz.searchExact(
          mLinkedDevice.email, numberOfConceptsToLook, concept);
      List<MObject> listOfObjectsInQuestion =
          await buildQuizCards(quizzes.first.question);

      List<int> isCorrectList = <int>[];
      for (MQuiz quiz in quizzes) {
        isCorrectList.add(quiz.isCorrect);
      }

      QuizResultHelper quizResult = QuizResultHelper();
      quizResult.concept = concept;
      quizResult.objects = listOfObjectsInQuestion;
      quizResult.quizzes = quizzes;
      quizResult.isCorrectList = isCorrectList;
      quizResult.mQuiz = quizzes.first;

      _quizResults.add(quizResult);
    }

    if (mounted) {
      setState(() {
        quizResults = _quizResults;
      });
    }
    return;
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

  Widget showResults() {
    if (quizResults == null) return Container();

    return ListView.builder(
        itemCount: quizResults.length,
        itemBuilder: (context, index) {
          return quizListItemBuilder(context, index);
        });
  }

  Widget quizListItemBuilder(BuildContext context, int index) {
    QuizResultHelper quiz = quizResults[index];

    List<SubscriberSeries> data = <SubscriberSeries>[];
    for (MQuiz mQuiz in quiz.quizzes) {
      data.add(SubscriberSeries(
        year: mQuiz.timestamp.toString(),
        subscribers: 1,
        barColor: mQuiz.isCorrect == 1
            ? charts.ColorUtil.fromDartColor(Colors.green)
            : charts.ColorUtil.fromDartColor(Colors.red),
      ));
    }

    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.year,
          measureFn: (SubscriberSeries series, _) => series.subscribers,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Text(quiz.concept),
          showQuestion(quiz.objects),
          Container(
              height: 100,
              child: charts.BarChart(
                series,
                animate: true,
                defaultRenderer: new charts.BarRendererConfig(
                  cornerStrategy: const charts.ConstCornerStrategy(30),
                ),

                /// Assign a custom style for the measure axis.
                ///
                /// The NoneRenderSpec can still draw an axis line with
                /// showAxisLine=true.
                primaryMeasureAxis: new charts.NumericAxisSpec(
                    renderSpec: new charts.NoneRenderSpec()),

                /// This is an OrdinalAxisSpec to match up with BarChart's default
                /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
                /// other charts).
                domainAxis: new charts.OrdinalAxisSpec(
                    // Make sure that we draw the domain axis line.
                    showAxisLine: true,
                    // But don't draw anything else.
                    renderSpec: new charts.NoneRenderSpec()),
              ))
        ],
      ),
    ));
  }

  Widget showQuestion(List<MObject> objects) {
    if (objects == null) return Container();

    final items = <Widget>[];
    for (var i = 0; i < objects.length; i++) {
      Widget widget = Container();

      if (objects[i] is MImage) {
        MImage mImage = objects[i];
        widget = getVoiceBoxCard(
            objects[i].highlighted,
            mImage.useAsset,
            mImage.fileName,
            mImage.localFileName,
            mImage.isAvailable,
            mImage.textToShow);
      }
      if (objects[i] is MFolder) {
        MFolder mFolder = objects[i];
        widget = getVoiceBoxCard(
            objects[i].highlighted,
            mFolder.useAsset,
            mFolder.fileName,
            mFolder.localFileName,
            mFolder.isAvailable,
            mFolder.textToShow);
      }
      if (objects[i] is MVideo) {
        MVideo mVideo = objects[i];
        widget = getVoiceBoxCard(
            objects[i].highlighted,
            mVideo.useAsset,
            mVideo.fileName,
            mVideo.localFileName,
            mVideo.isAvailable,
            mVideo.textToShow);
      }
      if (objects[i] is MSound) {
        MSound mSound = objects[i];
        widget = getVoiceBoxCard(
            objects[i].highlighted,
            mSound.useAsset,
            mSound.fileName,
            mSound.localFileName,
            mSound.isAvailable,
            mSound.textToShow);
      }

      items.add(widget);
    }

    Widget quizBox = Container(
      decoration: BoxDecoration(
        //color: Colors.grey[400],
        border: Border.all(
          width: 1,
          color: Colors.grey[400],
        ),
      ),
      height: Helper.smallVoiceBoxSizeForQuiz,
      child: Container(
        height: Helper.smallVoiceBoxSizeForQuiz,
        //decoration: myOuterBoxDecoration(),
        padding: const EdgeInsets.all(3.0),
        //margin: const EdgeInsets.all(3.0),
        child: Container(
          color: Colors.white,
          height: Helper.smallVoiceBoxSizeForQuiz,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items,
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

  Widget getVoiceBoxCard(bool highlighted, int useAsset, String assetFileName,
      String localFileName, int isAvailable, String textToShow) {
    Image localImage;
    if (useAsset == 0) {
      File f = File('${Helper.appDirectory}/$localFileName');
      localImage = Image.file(f);
    }

    return Container(
      color: highlighted ? Colors.green : null,
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
            flex: Helper.imageFlexSize,
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
            flex: 1,
            child: Text(
              textToShow,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 9.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuizResultHelper {
  MQuiz mQuiz;
  String concept;
  List<MObject> objects;
  List<MQuiz> quizzes;
  List<int> isCorrectList;
}

class SubscriberSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries(
      {@required this.year,
      @required this.subscribers,
      @required this.barColor});
}
