// @dart=2.9
import 'package:flutter/material.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class WOnboard extends StatefulWidget {
  List<String> images;
  List<String> titles;
  List<String> texts;
  String helperScreen = '';
  ValueChanged<dynamic>
      onBtnAccept; // callback triggered when ACCEPT buton is pressed

  WOnboard(this.images, this.titles, this.texts, this.helperScreen,
      this.onBtnAccept);

  @override
  _WOnboardState createState() {
    return _WOnboardState(this.images, this.titles, this.texts,
        this.helperScreen, this.onBtnAccept);
  }
}

class _WOnboardState extends State<WOnboard> {
  int _slideIndex = 0;

  //final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  List<String> translationItems = [
    'accept',
  ];
  Map<String, String> translations = Map<String, String>();

  List<String> images;
  List<String> titles;
  List<String> texts;
  String helperScreen = '';
  ValueChanged<void>
      onBtnAccept; // callback triggered when ACCEPT buton is pressed

  _WOnboardState(this.images, this.titles, this.texts, this.helperScreen,
      this.onBtnAccept) {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
  }

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      setState(() {});
    });
  }

  Future<void> initialize() async {
    Map<String, String> result = await L.getItems(translationItems);

    setState(() {
      translations = result;
    });
  }

  List<Color> colors = [Colors.orange];

  final IndexController controller = IndexController();

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<LucasState>(
        properties: [
          StateProperties.showHelperLevelSettings,
        ],
        builder: (context, lucasState, property) {
          final lucasState =
              PropertyChangeProvider.of<LucasState>(context, listen: false)
                  .value;
          String isVisible = lucasState.getObject(helperScreen) ?? '';

          if (isVisible == 'false') return Container();

          TransformerPageView transformerPageView = TransformerPageView(
              pageSnapping: true,
              onPageChanged: (index) {
                setState(() {
                  this._slideIndex = index;
                });
              },
              loop: false,
              controller: controller,
              transformer: PageTransformerBuilder(
                  builder: (Widget child, TransformInfo info) {
                return new Material(
                  color: Colors.white,
                  elevation: 8.0,
                  textStyle: new TextStyle(color: Colors.white),
                  borderRadius: new BorderRadius.circular(12.0),
                  child: new Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ParallaxContainer(
                            child: new Image.asset(
                              images[info.index],
                              fit: BoxFit.contain,
                              height: 350,
                            ),
                            position: info.position,
                            translationFactor: 400.0,
                          ),
                          ParallaxContainer(
                            child: new Text(
                              titles[info.index],
                              style: new TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            position: info.position,
                            opacityFactor: .8,
                            translationFactor: 400.0,
                          ),
                          ParallaxContainer(
                            child: new Text(
                              texts[info.index],
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18.0,
                              ),
                            ),
                            position: info.position,
                            translationFactor: 300.0,
                          ),
                          ParallaxContainer(
                            position: info.position,
                            translationFactor: 500.0,
                            child: Dots(
                              context: context,
                              controller: controller,
                              slideIndex: _slideIndex,
                              numberOfDots: images.length,
                            ),
                          ),
                          ParallaxContainer(
                            position: info.position,
                            translationFactor: 500.0,
                            child: ElevatedButton(
                                // shape: RoundedRectangleBorder(
                                //     borderRadius:
                                //         new BorderRadius.circular(30.0)),
                                onPressed: () async {
                                  setState(() {
                                    // final lucasState =
                                    //     PropertyChangeProvider.of<LucasState>(
                                    //             context,
                                    //             listen: false)
                                    //         .value;
                                    lucasState.saveObject(
                                        helperScreen, 'false');
                                    if (onBtnAccept != null) {
                                      onBtnAccept(true);
                                    }
                                  });
                                },
                                child: Text(translations['accept'].toUpperCase())),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
              itemCount: 4);

          // return Container(
          //     height: MediaQuery.of(context).size.height,
          //     child: transformerPageView);
          return Scaffold(
            backgroundColor: Colors.white,
            body: transformerPageView,
          );
        });
  }
}

class Dots extends StatelessWidget {
  BuildContext context;
  final IndexController controller;
  final int slideIndex;
  int numberOfDots;
  Dots({this.context, this.controller, this.slideIndex, this.numberOfDots});

  List<Widget> _generateDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; i++) {
      dots.add(i == slideIndex ? _activeSlide(i) : _inactiveSlide(i));
    }
    return dots;
  }

  Widget _activeSlide(int index) {
    return GestureDetector(
      onTap: () {
        print('Tapped');
      },
      child: new Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              //Colors.orangeAccent.withOpacity(.3),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inactiveSlide(int index) {
    return GestureDetector(
      onTap: () {
        controller.move(index);
      },
      child: new Container(
        child: Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(0.3), //Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _generateDots(),
    ));
  }
}
