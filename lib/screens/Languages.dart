import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MCategory.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

class Languages extends StatefulWidget {
  Languages({Key key}) : super(key: key);

  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
          appBar: AppBar(
            title: getLocalizedText("language"),
          ),
          body: getFutureLanguageListView(context)),
    );
  }

  Widget getLocalizedText(String item) {
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

  Widget getLocalizedTextIn(String languageCode, String item) {
    return FutureBuilder(
      future: L.itemInL(languageCode, item),
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

  Widget getFutureLanguageListView(BuildContext context) {
    return FutureBuilder(
      future: LocalPreferences.getString("languageCode", "en"),
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
              return getLanguageListView(context, snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  Widget getLanguageListView(BuildContext context, String languageCode) {
    ListView settingListView = ListView(
      children: <Widget>[
        getLanguageListTile(context, languageCode, 'en', 'English'),
        Divider(),
        getLanguageListTile(context, languageCode, 'zh', 'Chinese'),
        Divider(),
        getLanguageListTile(context, languageCode, 'hi', 'Hindi'),
        Divider(),
        getLanguageListTile(context, languageCode, 'es', 'Spanish'),
        Divider(),
        getLanguageListTile(context, languageCode, 'ar', 'Arabic'),
        Divider(),
        getLanguageListTile(context, languageCode, 'ms', 'Malay'),
        Divider(),
        getLanguageListTile(context, languageCode, 'ru', 'Russian'),
        Divider(),
        getLanguageListTile(context, languageCode, 'bn', 'Bengali'),
        Divider(),
        getLanguageListTile(context, languageCode, 'pt', 'Portuguese'),
        Divider(),
        getLanguageListTile(context, languageCode, 'fr', 'French'),
        Divider(),
        getLanguageListTile(context, languageCode, 'de', 'German'),
      ],
    );

    return settingListView;
  }

  Widget getLanguageListTile(BuildContext context, String selectedLanguageCode,
      String languageCode, String languageName) {
    return ListTile(
      leading: Icon(
        Icons.language,
      ),
      selected: selectedLanguageCode == languageCode,
      title: getLocalizedTextIn(languageCode, languageName),
      subtitle: getLocalizedText(languageName),
      onTap: () async {
        MCategory.clearMemoryTables();
        MEmpty.clearMemoryTables();
        MImage.clearMemoryTables();
        MFolder.clearMemoryTables();
        MVideo.clearMemoryTables();
        MSound.clearMemoryTables();
        MRelation.clearMemoryTables();

        await LocalPreferences.setString("languageCode", languageCode);
        //lucasState.reloadWords();
        //lucasState.reloadFolderNames();

        await updateLearningObjects();

        Navigator.of(context).pop();

        if (selectedLanguageCode != languageCode) {
          await LocalPreferences.setString("languageCountry", '');
          L.selectFirstAvailableVoice();

          // if (!couldSelectVoice) {
          //   Route route =
          //       MaterialPageRoute(builder: (context) => TextToSpeech());
          //   Navigator.push(context, route);
          // }
        }
      },
    );
  }

  updateLearningObjects() async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int defaultFolderId = lucasState.getObject(StateProperties.defaultFolderId);

    String strCurrentLevel =
        await LocalPreferences.getString("currentLevel", "1");
    int currentLevel = int.parse(strCurrentLevel);
    
    int gridColumns = lucasState.getGridColumns();

    List<MObject> learningObjects = await MRelation.getLearningObjectsInFolder(
        currentLevel, defaultFolderId, gridColumns);
    lucasState.saveObject(StateProperties.learningObjects, learningObjects);
  }

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }
}
