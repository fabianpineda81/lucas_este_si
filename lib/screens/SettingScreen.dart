import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/Tuple.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/screens/ColorSettings.dart';
import 'package:lucas/screens/Folders.dart';
import 'package:lucas/screens/Languages.dart';
import 'package:lucas/screens/LevelsSettings.dart';
import 'package:lucas/screens/LinkedDevices.dart';
import 'package:lucas/screens/TextToSpeech.dart';
import 'package:lucas/screens/UserAccount.dart';
import 'package:package_info/package_info.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

import 'HelpVideos.dart';
import 'LearnScreen.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // _SettingScreenState() async {
  //   languageCountry = await LocalPreferences.getString("languageCountry", '');
  // }

  // String languageCountry = "";
  bool isLargeScreen = false;

  @override
  void initState() {
    // Clear the voice box when openning settings
    LucasState.imageCards.clear();

    super.initState();
  }

  // @override
  // void didUpdateWidget(Widget oldWidget) {

  //   SystemChrome.setPreferredOrientations([
  //     //DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //   ]);

  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return settingScreenWidget();
  }

  Widget leftWidget() {
    return Center(
        child: Image.asset(
      'assets/images/lucas_logo.jpg',
    ));
  }

  Widget settingScreenWidget() {
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: getLocalizedText("settings title"),
        actions: <Widget>[
          btnGotoLearningScreen(),
        ],
        automaticallyImplyLeading: false,
      ),
      body: !isLargeScreen
          ? getSettingsListView(context)
          : Row(children: <Widget>[
              Expanded(
                child: Container(color: Colors.white, child: leftWidget()),
              ),
              Expanded(
                child: getSettingsListView(context),
              ),
            ]),
      bottomNavigationBar: BottomNavigationOptions(),
    );
  }

  Widget btnGotoLearningScreen() {
    // final lucasState =
    //     PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    // int currentGridColumns = lucasState.getGridColumns();

    return IconButton(
      icon: Icon(
        Icons.school,
        color: Colors.white,
      ),
      onPressed: () async {
        Navigator.of(context).pop();

        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;
        int gridColumns = lucasState.getGridColumns();
        MFolder currentFolder =
            lucasState.getObject(StateProperties.currentFolder);

        List<MObject> learningObjects =
            await MRelation.getObjectsInFolder(gridColumns, currentFolder.id);
        lucasState.saveObject(StateProperties.learningObjects, learningObjects);

        // save the new current activity
        LocalPreferences.setString(
            StateProperties.currentActivity, 'LearnScreen');

        Route route = MaterialPageRoute(builder: (context) => LearnScreen());
        Navigator.push(context, route);
      },
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

  Widget getSettingsListView(BuildContext context) {
    ListView settingListView = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.video_library,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("help videos"),
          onTap: () async {
            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'HelpVideos');

            Route route = MaterialPageRoute(builder: (context) => HelpVideos());
            Navigator.push(context, route);
          },
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        ListTile(
          leading: Icon(
            Icons.verified_user,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("levels"),
          onTap: () async {
            Tuple t1 = Tuple("currentLevel", "1", "String");
            Tuple t2 = Tuple("languageCode", "en", "String");
            Tuple t3 = Tuple("firstReinforcer", "-1", "String");
            Tuple t4 = Tuple("secondReinforcer", "-1", "String");
            Tuple t5 = Tuple("thirdReinforcer", "-1", "String");
            List<Tuple> tuples = [t1, t2, t3, t4, t5];
            Map<dynamic, dynamic> map = await LocalPreferences.getInfo(tuples);

            final lucasState =
                PropertyChangeProvider.of<LucasState>(context, listen: false)
                    .value;
            await lucasState.setReinforcer(
                1, int.parse(map["firstReinforcer"]));
            await lucasState.setReinforcer(
                2, int.parse(map["secondReinforcer"]));
            await lucasState.setReinforcer(
                3, int.parse(map["thirdReinforcer"]));

            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'LevelsSettings');

            Route route =
                MaterialPageRoute(builder: (context) => LevelsSettings(map));
            Navigator.push(context, route);
          },
        ),
        // ListTile(
        //   leading: Icon(
        //     Icons.image,
        //     color: Theme.of(context).primaryColor,
        //   ),
        //   title: getLocalizedText("images"),
        //   onTap: () async {
        //     // save the new current activity
        //     await LocalPreferences.setString(
        //         StateProperties.currentActivity, 'ImageSettings');

        //     Route route = MaterialPageRoute(
        //         builder: (context) => ImageSettings(false, false, false));
        //     Navigator.push(context, route);
        //   },
        // ),
        ListTile(
          leading: Icon(
            Icons.folder,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("folders"),
          onTap: () async {
            final lucasState =
                PropertyChangeProvider.of<LucasState>(context, listen: false)
                    .value;

            MFolder folder;
            String currentLevel =
                await LocalPreferences.getString("currentLevel", "1");
            if (currentLevel == '5') {
              int defaultFolderId =
                  lucasState.getObject(StateProperties.defaultFolderId);
              if (defaultFolderId == -2) defaultFolderId = -1;
              folder = await MFolder.getByID(defaultFolderId);
            } else {
              folder = await MFolder.getByID(-1);
            }

            lucasState.saveObject(StateProperties.selectedFolder, folder);

            int gridColumns = lucasState.getGridColumns();

            List<MObject> objects = <MObject>[];
            if (folder != null)
              objects =
                  await MRelation.getObjectsInFolder(gridColumns, folder.id);
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

            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'Folders');

            Route route =
                MaterialPageRoute(builder: (context) => Folders(currentLevel));
            Navigator.push(context, route);
          },
        ),
        // ListTile(
        //   title: Text(L.item(context, "long press")),
        // ),
        // ListTile(
        //   title: Text(L.item(context, "folder bar")),
        // ),
        // ListTile(
        //   title: Text(L.item(context, "export pictures")),
        // ),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("colors"),
          onTap: () async {
            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'ColorSettings');

            Route route =
                MaterialPageRoute(builder: (context) => ColorSettings());
            Navigator.push(context, route);
          },
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        ListTile(
          leading: Icon(
            Icons.settings_voice,
            color: Theme.of(context).primaryColor,
          ),
          //trailing: getWarningIcon(),
          title: getLocalizedText("tts"),
          onTap: () async {
            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'TextToSpeech');

            Route route =
                MaterialPageRoute(builder: (context) => TextToSpeech());
            Navigator.push(context, route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.language,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("language"),
          onTap: () async {
            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'Languages');

            Route route = MaterialPageRoute(builder: (context) => Languages());
            Navigator.push(context, route);
          },
        ),
        // ListTile(
        //   leading: Icon(
        //     Icons.category,
        //     color: Theme.of(context).primaryColor,
        //   ),
        //   title: getLocalizedText("categories"),
        //   onTap: () {
        //     Route route = MaterialPageRoute(builder: (context) => Categories());
        //     Navigator.push(context, route);
        //   },
        // ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        ListTile(
          leading: Icon(
            Icons.important_devices,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("linked devices"),
          onTap: () async {
            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'LinkedDevices');

            Route route =
                MaterialPageRoute(builder: (context) => LinkedDevices());
            Navigator.push(context, route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("user profile"),
          onTap: () async {
            // save the new current activity
            await LocalPreferences.setString(
                StateProperties.currentActivity, 'UserAccount');

            Route route =
                MaterialPageRoute(builder: (context) => UserAccount());
            Navigator.push(context, route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColor,
          ),
          title: getLocalizedText("about this app"),
          onTap: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();

            String appName = packageInfo.appName;
            //String packageName = packageInfo.packageName;
            String version = packageInfo.version;
            String buildNumber = packageInfo.buildNumber;

            showAboutDialog(
              context: context,
              children: <Widget>[
                leftWidget(),
              ],
              applicationName: appName,
              applicationVersion: version + '. Build: ' + buildNumber,
              applicationLegalese:
                  'Developed for Lucas Education by \nJuan Ricardo Rivera \njuanricardorivera@openbusiness.co\n\n',
            );
          },
        ),
      ],
    );

    return settingListView;
  }

  Widget getWarningIcon() {
    return FutureBuilder(
      future: LocalPreferences.getString("languageCountry", ''),
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
              String languageCountry = snapshot.data;
              if (languageCountry.isEmpty)
                return Container(
                  width: 45,
                  height: 45,
                  child: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                );
              else
                return new Container(width: 0.0, height: 0.0);
            }
        }
        return Container(width: 0.0, height: 0.0);
      },
    );
  }
}
