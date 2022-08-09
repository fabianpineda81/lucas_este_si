import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/themes/ThemeNotifier.dart';
import 'package:lucas/themes/themes.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSettings extends StatefulWidget {
  ColorSettings({Key key}) : super(key: key);

  @override
  _ColorSettingsState createState() => _ColorSettingsState();
}

class _ColorSettingsState extends State<ColorSettings> {
  bool isSwitched = false;

  _ColorSettingsState() {
    SharedPreferences.getInstance().then((prefs) {
      isSwitched = prefs.getBool('darkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
          child: Scaffold(
        appBar: AppBar(
          title: getLocalizedTextNeutralColor("colors"),
        ),
        body: getFutureLanguageListView(context),
        bottomNavigationBar: BottomNavigationOptions(),
          ),
    );
  }

  Widget getLocalizedTextNeutralColor(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
              return Text(snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  Widget getLocalizedText(String item, Color color) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
              return Text(
                snapshot.data,
                style: TextStyle(color: color),
              );
            }
        }
        return Text("");
      },
    );
  }

  Widget getFutureLanguageListView(BuildContext context) {
    return FutureBuilder(
      future: LocalPreferences.getString("currentColor", "blue"),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
              return getColorsListView(context, snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  void onThemeChanged(
      bool darkMode, String currentColor, ThemeNotifier themeNotifier) async {
    if (darkMode) {
      if (currentColor == 'amber') {
        themeNotifier.setTheme(darkAmberTheme);
      }
      if (currentColor == 'blue') {
        themeNotifier.setTheme(darkBlueTheme);
      }
      if (currentColor == 'cyan') {
        themeNotifier.setTheme(darkCyanTheme);
      }
      if (currentColor == 'deepOrange') {
        themeNotifier.setTheme(darkDeepOrangeTheme);
      }
      if (currentColor == 'deepPurple') {
        themeNotifier.setTheme(darkDeepPurpleTheme);
      }
      if (currentColor == 'green') {
        themeNotifier.setTheme(darkGreenTheme);
      }
      if (currentColor == 'indigo') {
        themeNotifier.setTheme(darkIndigoTheme);
      }
      if (currentColor == 'lightBlue') {
        themeNotifier.setTheme(darkLightBlueTheme);
      }
      if (currentColor == 'lightGreen') {
        themeNotifier.setTheme(darkLightGreenTheme);
      }
      if (currentColor == 'lime') {
        themeNotifier.setTheme(darkLimeTheme);
      }
      if (currentColor == 'orange') {
        themeNotifier.setTheme(darkOrangeTheme);
      }
      if (currentColor == 'pink') {
        themeNotifier.setTheme(darkPinkTheme);
      }
      if (currentColor == 'purple') {
        themeNotifier.setTheme(darkPurpleTheme);
      }
      if (currentColor == 'red') {
        themeNotifier.setTheme(darkRedTheme);
      }
      if (currentColor == 'teal') {
        themeNotifier.setTheme(darkTealTheme);
      }
      if (currentColor == 'yellow') {
        themeNotifier.setTheme(darkYellowTheme);
      }
    } else {
      if (currentColor == 'amber') {
        themeNotifier.setTheme(lightAmberTheme);
      }
      if (currentColor == 'blue') {
        themeNotifier.setTheme(lightBlueTheme);
      }
      if (currentColor == 'cyan') {
        themeNotifier.setTheme(lightCyanTheme);
      }
      if (currentColor == 'deepOrange') {
        themeNotifier.setTheme(lightDeepOrangeTheme);
      }
      if (currentColor == 'deepPurple') {
        themeNotifier.setTheme(lightDeepPurpleTheme);
      }
      if (currentColor == 'green') {
        themeNotifier.setTheme(lightGreenTheme);
      }
      if (currentColor == 'indigo') {
        themeNotifier.setTheme(lightIndigoTheme);
      }
      if (currentColor == 'lightBlue') {
        themeNotifier.setTheme(lightLightBlueTheme);
      }
      if (currentColor == 'lightGreen') {
        themeNotifier.setTheme(lightLightGreenTheme);
      }
      if (currentColor == 'lime') {
        themeNotifier.setTheme(lightLimeTheme);
      }
      if (currentColor == 'orange') {
        themeNotifier.setTheme(lightOrangeTheme);
      }
      if (currentColor == 'pink') {
        themeNotifier.setTheme(lightPinkTheme);
      }
      if (currentColor == 'purple') {
        themeNotifier.setTheme(lightPurpleTheme);
      }
      if (currentColor == 'red') {
        themeNotifier.setTheme(lightRedTheme);
      }
      if (currentColor == 'teal') {
        themeNotifier.setTheme(lightTealTheme);
      }
      if (currentColor == 'yellow') {
        themeNotifier.setTheme(lightYellowTheme);
      }
    }

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("currentColor", currentColor);
      prefs.setBool("darkMode", darkMode);
    });

    //Navigator.of(context).pop();
  }

  toggleDarkMode(bool value) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    
    if (mounted) {
    setState(() {
      isSwitched = value;
      SharedPreferences.getInstance().then((prefs) {
        var currentColor = prefs.getString('currentColor') ?? 'blue';
        onThemeChanged(isSwitched, currentColor, themeNotifier);
      });
    });
    }
  }

  Widget getColorsListView(BuildContext context, String currentColor) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    ListView settingListView = ListView(
      children: <Widget>[
        ListTile(
          title: Row(
            children: <Widget>[
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  toggleDarkMode(value);
                },
                // activeTrackColor: Colors.lightGreenAccent,
                // activeColor: Colors.green,
              ),
              GestureDetector(
                child: getLocalizedTextNeutralColor("dark mode"),
                onTap: () => {
                  setState(() {
                    isSwitched = !isSwitched;
                    toggleDarkMode(isSwitched);
                  })
                },
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.amber,
          ),
          trailing: currentColor == 'amber'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("amber", Colors.amber),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'amber', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.blue,
          ),
          trailing: currentColor == 'blue'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("blue", Colors.blue),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'blue', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.cyan,
          ),
          trailing: currentColor == 'cyan'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("cyan", Colors.cyan),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'cyan', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.deepOrange,
          ),
          trailing: currentColor == 'deepOrange'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("deepOrange", Colors.deepOrange),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'deepOrange', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.deepPurple,
          ),
          trailing: currentColor == 'deepPurple'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("deepPurple", Colors.deepPurple),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'deepPurple', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.green,
          ),
          trailing: currentColor == 'green'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("green", Colors.green),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'green', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.indigo,
          ),
          trailing: currentColor == 'indigo'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("indigo", Colors.indigo),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'indigo', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.lightBlue,
          ),
          trailing: currentColor == 'lightBlue'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("lightBlue", Colors.lightBlue),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'lightBlue', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.lightGreen,
          ),
          trailing: currentColor == 'lightGreen'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("lightGreen", Colors.lightGreen),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'lightGreen', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.lime,
          ),
          trailing: currentColor == 'lime'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("lime", Colors.lime),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'lime', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.orange,
          ),
          trailing: currentColor == 'orange'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("orange", Colors.orange),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'orange', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.pink,
          ),
          trailing: currentColor == 'pink'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("pink", Colors.pink),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'pink', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.purple,
          ),
          trailing: currentColor == 'purple'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("purple", Colors.purple),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'purple', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.red,
          ),
          trailing: currentColor == 'red'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("red", Colors.red),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'red', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.teal,
          ),
          trailing: currentColor == 'teal'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("teal", Colors.teal),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'teal', themeNotifier);
            });
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Colors.yellow,
          ),
          trailing: currentColor == 'yellow'
              ? Icon(Icons.check)
              : Container(width: 0.0, height: 0.0),
          title: getLocalizedText("yellow", Colors.yellow),
          onTap: () {
            SharedPreferences.getInstance().then((prefs) {
              var darkMode = prefs.getBool('darkMode') ?? true;
              onThemeChanged(darkMode, 'yellow', themeNotifier);
            });
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
