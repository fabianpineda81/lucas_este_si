import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/Tuple.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';

import 'VoiceSelector.dart';

class TextToSpeech extends StatefulWidget {
  TextToSpeech({Key key}) : super(key: key);

  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  double _sliderValue = 1;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    LocalPreferences.getDouble("ttsSpeed", 0.5).then((value) {
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: L.getLocalizedText("tts"),
        ),
        body: getFutureWordsListView(context),
        bottomNavigationBar: BottomNavigationOptions(),
      ),
    );
  }

  // Widget getLocalizedText(String item) {
  //   return FutureBuilder(
  //     future: L.item(item),
  //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.none:
  //           return new Text('');
  //         case ConnectionState.waiting:
  //           return new Center(child: new CircularProgressIndicator());
  //         case ConnectionState.active:
  //           return new Text('');
  //         case ConnectionState.done:
  //           if (snapshot.hasError) {
  //             return new Text(
  //               '${snapshot.error}',
  //               style: TextStyle(color: Colors.red),
  //             );
  //           } else {
  //             return Text(snapshot.data);
  //           }
  //       }
  //       return Text("");
  //     },
  //   );
  // }

  Future<Map> getInfo() async {
    Map<String, String> result = Map<String, String>();

    String languageCountry =
        await LocalPreferences.getString("languageCountry", "");
    result["languageCountry"] = languageCountry;

    String noVoiceSelected = await L.item("no voice selected");
    result["no voice selected"] = noVoiceSelected;

    return result;
  }

  Widget getLocalizedCurrentVoice() {
    return FutureBuilder(
      future: getInfo(),
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
              String languageCountry = snapshot.data["languageCountry"];
              String selectedLanguageCountry =
                  snapshot.data["no voice selected"];

              Map<String, String> languageCountryCodes =
                  L.getLanguageCountryCode();
              if (languageCountry.isNotEmpty) {
                selectedLanguageCountry = languageCountryCodes[languageCountry];
              }

              return Text(selectedLanguageCountry);
            }
        }
        return Text("");
      },
    );
  }

  Widget getFutureWordsListView(BuildContext context) {
    Tuple t1 = Tuple("currentLevel", "1", "String");
    //Tuple t2 = Tuple("userName", "", "String");
    //Tuple t3 = Tuple("ttsSpeed", "0.7", "double");
    List<Tuple> tuples = [t1];

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
              return getWordsListView(context, snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  Widget getWordsListView(BuildContext context, Map prefs) {
    //String userName = prefs["userName"];

    ListView settingListView = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.settings_voice,
          ),
          title: L.getLocalizedText("select voice"),
          subtitle: getLocalizedCurrentVoice(),
          onTap: () async {
            String languageCountry =
                await LocalPreferences.getString("languageCountry", "");

            Route route = MaterialPageRoute(
                builder: (context) =>
                    VoiceSelector(languageCountry: languageCountry));
            Navigator.push(context, route);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.accessible_forward,
          ),
          title: L.getLocalizedText("voice speed"),
          subtitle: Slider(
            //activeColor: Colors.indigoAccent,
            min: 0.1,
            max: 1.1,
            onChanged: (newSpeed) async {
              await LocalPreferences.setDouble("ttsSpeed", newSpeed);
              setState(() => _sliderValue = newSpeed);
            },
            value: _sliderValue,
          ),
          // onTap: () async {
          //   String languageCountry =
          //       await LocalPreferences.getString("languageCountry", "");

          //   Route route = MaterialPageRoute(
          //       builder: (context) =>
          //           VoiceSelector(languageCountry: languageCountry));
          //   Navigator.push(context, route);
          // },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.record_voice_over,
          ),
          title: L.getLocalizedText("test voice"),
          subtitle: L.getLocalizedText("test text"),
          onTap: () async {
            FlutterTts flutterTts = new FlutterTts();
            String languageCountry =
                await LocalPreferences.getString("languageCountry", "");

            bool isLanguageAvailable =
                await flutterTts.isLanguageAvailable(languageCountry);
            if (isLanguageAvailable) {
              await flutterTts.setLanguage(languageCountry);
              String t = await L.item("test text");

              double ttsSpeed =
                  await LocalPreferences.getDouble("ttsSpeed", 0.5);
              await flutterTts.setSpeechRate(ttsSpeed);

              await flutterTts.speak(t);
            } else {
              String selectVoice = await L.item("select voice");

              if (mounted) {
                final snackBar = SnackBar(
                  content: L.getLocalizedText('no voice selected'),
                  action: SnackBarAction(
                    label: selectVoice,
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (context) =>
                              VoiceSelector(languageCountry: languageCountry));
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
          },
        ),
      ],
    );

    return settingListView;
  }

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }
}
