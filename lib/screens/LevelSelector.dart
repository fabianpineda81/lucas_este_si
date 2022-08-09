import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

class LevelSelector extends StatefulWidget {
  final isLeftMenu;
  LevelSelector(this.isLeftMenu, {Key key}) : super(key: key);

  @override
  _LevelSelectorState createState() => _LevelSelectorState(this.isLeftMenu);
}

class _LevelSelectorState extends State<LevelSelector> {
  bool isLeftMenu;

  _LevelSelectorState(this.isLeftMenu);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        appBar: isLeftMenu
            ? null
            : AppBar(
                title: getLocalizedText("change level"),
              ),
        body: getFutureLevelsListView(context),
      ),
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

  Widget getFutureLevelsListView(BuildContext context) {
    return FutureBuilder(
      future: LocalPreferences.getString("currentLevel", "1"),
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
              return getLevelsListView(context, snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  Widget getLevelsListView(BuildContext context, String currentLevel) {
    ListView settingListView = ListView(
      children: <Widget>[
        getLanguageTile(currentLevel, '1'),
        Divider(),
        getLanguageTile(currentLevel, '2'),
        Divider(),
        getLanguageTile(currentLevel, '3'),
        Divider(),
        getLanguageTile(currentLevel, '4'),
        Divider(),
        getLanguageTile(currentLevel, '5'),
        Divider(),
        getLanguageTile(currentLevel, '6'),
        Divider(),
        getLanguageTile(currentLevel, '7'),
        Divider(),
        getLanguageTile(currentLevel, '8'),
        Divider(),
        getLanguageTile(currentLevel, '9'),
        Divider(),
        getLanguageTile(currentLevel, '10'),
        Divider(),
        getLanguageTile(currentLevel, '11'),
      ],
    );

    return settingListView;
  }

  Widget getLanguageTile(String currentLevel, String level) {
    return ListTile(
      title: getLocalizedText("level$level"),
      subtitle: L.getUpperText("level$level name"),
      onTap: () {
        onLanguageTap('$level');
      },
      selected: (currentLevel == '$level'),
    );
  }

  onLanguageTap(String strCurrentLevel) async {
    await LocalPreferences.setString("currentLevel", strCurrentLevel);

    int currentLevel = int.parse(strCurrentLevel);
    if (currentLevel > 4) {
      final lucasState =
          PropertyChangeProvider.of<LucasState>(context, listen: false).value;
      int defaultFolderId =
          await LocalPreferences.getInt('defaultFolderId', -2);

      if (currentLevel > 5) {
        defaultFolderId = -1;
        //await LocalPreferences.setInt('defaultFolderId', defaultFolderId);
      } else {
        if (defaultFolderId == -2) {
          defaultFolderId = -1;
          await LocalPreferences.setInt('defaultFolderId', defaultFolderId);
        }
      }

      MFolder currentFolder = await MFolder.getByID(defaultFolderId);
      lucasState.saveObject(StateProperties.currentFolder, currentFolder);

      int gridColumns = lucasState.getGridColumns();

      List<MObject> learningObjects =
          await MRelation.getLearningObjectsInFolder(
              currentLevel, defaultFolderId, gridColumns);
      lucasState.saveObject(StateProperties.learningObjects, learningObjects);
      lucasState.saveObject(StateProperties.isEditMode, false);
    }

    Navigator.of(context).pop(int.parse(strCurrentLevel));
    //Navigator.of(context).pop();
    //Navigator.of(context).pop();
  }

  Future<bool> handleBackButton() async {
    String strCurrentLevel =
        await LocalPreferences.getString("currentLevel", "1");

    Navigator.of(context).pop(int.parse(strCurrentLevel));

    return false;
  }
}
