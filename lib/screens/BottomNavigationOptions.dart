import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/screens/LearnScreen.dart';
import 'package:lucas/screens/Schedule.dart';
import 'package:lucas/screens/SettingScreen.dart';
import 'package:lucas/screens/Stories.dart';
import 'package:lucas/screens/Splash.dart';

//import 'package:property_change_notifier/property_change_notifier.dart';

import 'Quiz.dart';

class BottomNavigationOptions extends StatefulWidget {
  BottomNavigationOptions();

  @override
  _BottomNavigationOptionsState createState() =>
      _BottomNavigationOptionsState();
}

class _BottomNavigationOptionsState extends State<BottomNavigationOptions> {
  bool showQuiz = true;
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> translationItems = [
    'learn',
    'stories',
    'schedule',
    'settings title',
    'quiz',
    'settings password protected',
  ];
  Map<String, String> translations = Map<String, String>();

  //GlobalKey _globalKey = new GlobalKey();

  _BottomNavigationOptionsState() {
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
    int _canCreateQuiz = await LocalPreferences.getInt('canCreateQuiz', 0);
    Map<String, String> result = await L.getItems(translationItems);

    setState(() {
      translations = result;
      showQuiz = (_canCreateQuiz == 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lucasState = PropertyChangeProvider.of<LucasState>(context).value;
    showQuiz = (lucasState.getObject(StateProperties.canCreateQuiz) ?? 0) == 1;

    return PropertyChangeConsumer<LucasState>(
      properties: [
        StateProperties.canCreateQuiz,
      ],
      builder: (context, lucasState, property) {
        List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];
        items.add(BottomNavigationBarItem(
          icon: new Icon(
            Icons.school,
            color: Theme.of(context).primaryColor,
          ),
          label: translations['learn'],
          //title: Text(translations['learn']),
        ));
        if (Helper.showHideStoriesAndSchedule == 1) {
          items.add(BottomNavigationBarItem(
            icon: Icon(
              Icons.local_activity,
              color: Theme.of(context).primaryColor,
            ),
            label: translations['stories'],
            // title: Text(translations['stories']),
          ));
        }
        if (Helper.showHideStoriesAndSchedule == 1) {
          items.add(BottomNavigationBarItem(
            icon: Icon(
              Icons.schedule,
              color: Theme.of(context).primaryColor,
            ),
            label: translations['schedule'],
            // title: Text(translations['schedule']),
          ));
        }
        items.add(BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).primaryColor,
          ),
          label: translations['settings title'],
          // title: Text(translations['settings title']),
        ));
        if (showQuiz) {
          items.add(BottomNavigationBarItem(
            icon: new Icon(
              Icons.assessment,
              color: Theme.of(context).primaryColor,
            ),
            label: translations['quiz'],
            // title: Text(translations['quiz']),
          ));
        }

        return BottomNavigationBar(
          currentIndex: 0, // current tab

          showUnselectedLabels: true,
          unselectedItemColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedLabelStyle: TextStyle(fontSize: 12.0),
          selectedLabelStyle: TextStyle(fontSize: 13.0),

          onTap: onTabTapped,
          items: items,
        );
      },
    );
  }

  void onTabTapped(int index) async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    await lucasState.saveObject(StateProperties.isEditMode, false);

    // Compensate index offset if stories and schedule are hidden
    if (index > 0 && Helper.showHideStoriesAndSchedule == 0) {
      index = index + 2;
    }

    if (index == 0) {
      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      int gridColumns = lucasState.getGridColumns();
      MFolder currentFolder =
          lucasState.getObject(StateProperties.currentFolder);

      if (currentFolder != null) {
        List<MObject> learningObjects =
            await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
        lucasState.saveObject(StateProperties.learningObjects, learningObjects);
      }
    }

    setState(() {
      if (index == 0) {
        Navigator.of(context).pop();

        // save the new current activity
        LocalPreferences.setString(
            StateProperties.currentActivity, 'LearnScreen');

        //Navigator.of(context).rebuild();

        Route route = MaterialPageRoute(builder: (context) => LearnScreen());
        Navigator.push(context, route);
      }
      if (index == 1) {
        Navigator.of(context).pop();

        // save the new current activity
        LocalPreferences.setString(StateProperties.currentActivity, 'Stories');

        Route route = MaterialPageRoute(builder: (context) => Stories());
        Navigator.push(context, route);
      }
      if (index == 2) {
        Navigator.of(context).pop();

        // save the new current activity
        LocalPreferences.setString(StateProperties.currentActivity, 'Schedule');

        Route route = MaterialPageRoute(builder: (context) => Schedule());
        Navigator.push(context, route);
      }
      if (index == 3) {
        validateSettingsRestrictions();
      }
      if (index == 4) {
        Navigator.of(context).pop();

        // save the new current activity
        LocalPreferences.setString(
            StateProperties.currentActivity, 'LearnScreen');

        Route route = MaterialPageRoute(builder: (context) => LearnScreen());
        Navigator.push(context, route);
      }
      if (index == 4) {
        Navigator.of(context).pop();

        // save the new current activity
        LocalPreferences.setString(StateProperties.currentActivity, 'Quiz');

        Route route = MaterialPageRoute(builder: (context) => Quiz());
        Navigator.push(context, route);
      }
    });
  }

  validateSettingsRestrictions() async {
    if (Helper.settingsRestrictions == 0) {
      Navigator.of(context).pop();

      // save the new current activity
      await LocalPreferences.setString(
          StateProperties.currentActivity, 'SettingScreen');

      Route route = MaterialPageRoute(builder: (context) => SettingScreen());
      Navigator.push(context, route);
    } else {
      var rng1 = new Random();
      int firstDigit = rng1.nextInt(10);
      var rng2 = new Random();
      int secondDigit = rng2.nextInt(10);
      String operation = '$firstDigit + $secondDigit = ';
      int answer = firstDigit + secondDigit;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(translations['settings password protected']),
            content: Row(
              children: <Widget>[
                Text(operation),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (text) async {
                      if (text == answer.toString()) {
                        // save the new current activity
                        await LocalPreferences.setString(
                            StateProperties.currentActivity, 'SettingScreen');

                        Route route = MaterialPageRoute(
                            builder: (context) => SettingScreen());
                        Navigator.push(context, route);
                      }
                    },
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(5.0),
                        hintText: translations['text to show hint']),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: L.getUpperText('close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
