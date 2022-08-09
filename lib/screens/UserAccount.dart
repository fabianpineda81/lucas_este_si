import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MLinkedDevice.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MQuiz.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSchedule.dart';
import 'package:lucas/models/MScheduleDay.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MStory.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/models/StoryObject.dart';
import 'package:lucas/models/Translation.dart';
import 'package:lucas/module_backup_reestore/helper_backup.dart';
import 'package:lucas/module_backup_reestore/helper_web_service.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:wakelock/wakelock.dart';

class UserAccount extends StatefulWidget {
  UserAccount({Key key}) : super(key: key);

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  List<String> translationItems = [
    'user email',
    'user email instructions',
    'user email hint',
    'change user email',
    'confirm change user email',
    'user name',
    'user name hint',
    'change user name',
    'confirm change user name',
    'linked devices',
    'output voicebox to device',
    'settings password protected',
    'settings password protected no',
    'settings password protected yes',
    'settings restrictions instructions',
    'user information',
    'show hide stories and schedule',
    'show',
    'hide',
    'warning',
    'email or name required for backup',
    'email or name required for restore',
    'close',
    'operation completed successfully',
    'restore device',
    'user email to restore',
    'start restore',
    'replace folder',
    'add to folder',
    'choose folder to restore',
    'images',
    'folders',
    'linked devices',
    'quiz',
    'relation',
    'schedule',
    'schedule day',
    'sound',
    'stories',
    'video',
    'story object',
    'translation',
    'select a folder',
    'what to do with folder',
  ];

  bool debugMode = Helper.debugMode;
  bool allowLongPressInLearningScreen = Helper.allowLongPressInLearningScreen;
  bool outputVoiceboxToAnotherDevice = Helper.outputVoiceboxToAnotherDevice;
  bool folderShouldTalk = Helper.folderShouldTalk;

  String strLongPressInstructions = '';
  String strFolderShouldTalkInstructions = '';
  String strVoiceBoxSize = '';
  String strSmall = '';
  String strBig = '';
  String strUserProfile = '';
  String strDebugMode = '';
  String strAllowLongPressInLearningScreen = '';
  String strFolderShouldTalk = '';
  String strGridSize = '';
  String strGridSizeInstructions = '';
  String strToggleVisibilityForAll = '';
  String strBackup = '';
  String strStart = '';
  String strShowHelpScreens = '';
  String strUnlock = '';
  String strLock = '';

  String strQuizzes = '';
  String strQuizzesInstructions = '';
  String strCanCreateQuizzes = '';
  String strCannotCreateQuizzes = '';

  String _strColumns = '';
  //String _strRows = '';
  double _columns = 6;
  //double _rows = 6;

  int _voiceBoxSize = 1;
  int _canCreateQuiz = 1;
  int _settingsRestrictions = 0;
  int _showHideStoriesAndSchedule = 1;

  bool isLoading = false;
  bool isBackingup = false;
  bool isRestoring = false;
  Function  actualizarEstado;


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, String> translations = Map<String, String>();

  String userEmail = '';
  String userName = '';
  String userEmailNameToRestore = '';
  bool canEditEmail = false;
  bool canEditUserName = false;
  String status = '';
  dynamic folderList;
  int selectedFolderToRestore = -1;
  int selectedLocalFolder = -1;

  List<MLinkedDevice> linkedDevices = <MLinkedDevice>[];
  List<MFolder> localFolders;

  _UserAccountState() {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }

    debugMode = Helper.debugMode;
    folderShouldTalk = Helper.folderShouldTalk;
  }

  @override
  void initState() {
    actualizarEstado= (String sms){
      setState(() {
        status= sms ;
      });
    };
    L.item('Columns').then((str) {
      setState(() {
        _strColumns = str;
      });
    });

    // L.item('Rows').then((str) {
    //   setState(() {
    //     _strRows = str;
    //   });
    // });


    L.item('long press instructions').then((str) {
      setState(() {
        strLongPressInstructions = str;
      });
    });

    L.item('user profile').then((str) {
      setState(() {
        strUserProfile = str;
      });
    });

    L.item('debug mode').then((str) {
      setState(() {
        strDebugMode = str;
      });
    });

    L.item('allowLongPressInLearningScreen').then((str) {
      setState(() {
        strAllowLongPressInLearningScreen = str;
      });
    });

    L.item('folder should talk').then((str) {
      setState(() {
        strFolderShouldTalk = str;
      });
    });

    L.item('folder should talk instructions').then((str) {
      setState(() {
        strFolderShouldTalkInstructions = str;
      });
    });

    L.item('voiceBoxSize').then((str) {
      setState(() {
        strVoiceBoxSize = str;
      });
    });

    L.item('toggle visibility for all').then((str) {
      setState(() {
        strToggleVisibilityForAll = str;
      });
    });

    L.item('backup device').then((str) {
      setState(() {
        strBackup = str;
      });
    });

    L.item('start').then((str) {
      setState(() {
        strStart = str;
      });
    });

    L.item('Show Help Screens').then((str) {
      setState(() {
        strShowHelpScreens = str;
      });
    });

    L.item('unlock').then((str) {
      setState(() {
        strUnlock = str;
      });
    });

    L.item('lock').then((str) {
      setState(() {
        strLock = str;
      });
    });

    L.item('small').then((str) {
      setState(() {
        strSmall = str;
      });
    });

    L.item('big').then((str) {
      setState(() {
        strBig = str;
      });
    });

    L.item('Grid size').then((str) {
      setState(() {
        strGridSize = str;
      });
    });

    L.item('grid size instructions').then((str) {
      setState(() {
        strGridSizeInstructions = str;
      });
    });

    LocalPreferences.getInt('voiceBoxSize', 1).then((result) {
      setState(() {
        _voiceBoxSize = result;
      });
    });

    LocalPreferences.getInt('settings restrictions', 0).then((result) {
      setState(() {
        _settingsRestrictions = result;
      });
    });

    LocalPreferences.getInt('showHideStoriesAndSchedule', 0).then((result) {
      setState(() {
        _showHideStoriesAndSchedule = result;
      });
    });

    LocalPreferences.getInt('canCreateQuiz', 0).then((result) {
      setState(() {
        _canCreateQuiz = result;
      });
    });

    L.item('quizzes').then((result) {
      setState(() {
        strQuizzes = result;
      });
    });

    L.item('quizzes instructions').then((result) {
      setState(() {
        strQuizzesInstructions = result;
      });
    });

    L.item('can create quiz').then((result) {
      setState(() {
        strCanCreateQuizzes = result;
      });
    });

    L.item('can not create quiz').then((result) {
      setState(() {
        strCannotCreateQuizzes = result;
      });
    });

    initialize().then((result) {
      setState(() {});
    });

    super.initState();

    Wakelock.enable();
  }

  Future<void> initialize() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');

    Map<String, String> result = await L.getItems(translationItems);

    setState(() {
      translations = result;
      userEmail = strUserEmail;
      userName = strUserName;
      canEditEmail = userEmail.isEmpty;
      canEditUserName = userName.isEmpty;
    });

    linkedDevices = await MLinkedDevice.getAllNonBlocked(false);
    localFolders = await MFolder.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<LucasState>(
      properties: [
        StateProperties.gridDimensions,
      ],
      builder: (context, lucasState, property) {
        // final lucasState =
        //     PropertyChangeProvider.of<LucasState>(context, listen: false).value;

        debugMode = Helper.debugMode;
        _columns = lucasState.getGridColumns().toDouble();
        //_rows = lucasState.getGridRows().toDouble();

        return WillPopScope(
          onWillPop: handleBackButton,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(strUserProfile),
            ),
            body: getUserSettingsListView(context),
            bottomNavigationBar: BottomNavigationOptions(),
          ),
        );
      },
    );
  }

  Future<void> refreshFolder(MFolder folder) async {
    if (folder == null) return;
    if (context == null) return;

    // Update gridObjects using the objects parentFolder (parameter folder)
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    int gridColumns = lucasState.getGridColumns();

    List<MObject> objects =
    await MRelation.getObjectsInFolder(gridColumns, folder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    int currentLearningFolderId =
    await LocalPreferences.getInt('currentLearningFolderId', -2);

    if (currentLearningFolderId == -2) {
      currentLearningFolderId =
      await LocalPreferences.getInt('defaultFolderId', -2);
    }

    await updateLearningObjects(currentLearningFolderId);
  }

  updateLearningObjects(int defaultFolderId) async {
    if (context == null) return;

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    String strCurrentLevel =
    await LocalPreferences.getString("currentLevel", "1");
    int currentLevel = int.parse(strCurrentLevel);

    int gridColumns = lucasState.getGridColumns();

    List<MObject> learningObjects = await MRelation.getLearningObjectsInFolder(
        currentLevel, defaultFolderId, gridColumns);
    lucasState.saveObject(StateProperties.learningObjects, learningObjects);
  }

  Widget workingProgressIndicator() {
    if (!isLoading) return Container();

    return Container(
      height: Helper.LinearProgressIndicatorHeight,
      child: LinearProgressIndicator(
        value: null,
        valueColor:
        new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
      ),
    );
  }

  toggleDebugMode(bool value) {
    if (mounted) {
      setState(() {
        debugMode = value;
        Helper.debugMode = debugMode;
      });
    }
  }

  toggleAllowLongPressInLearningScreen(bool value) {
    Helper.allowLongPressInLearningScreen = value;

    if (mounted) {
      setState(() {
        allowLongPressInLearningScreen = value;
      });
    }

    LocalPreferences.setBool('allowLongPressInLearningScreen', value);
  }

  toggleOutputVoiceboxToAnotherDevice(bool value) {
    Helper.outputVoiceboxToAnotherDevice = value;

    if (mounted) {
      setState(() {
        outputVoiceboxToAnotherDevice = value;
      });
    }

    LocalPreferences.setBool('outputVoiceboxToAnotherDevice', value);
  }

  toggleFolderShouldTalk(bool value) async {
    Helper.folderShouldTalk = value;
    await LocalPreferences.setBool('folderShouldTalk', Helper.folderShouldTalk);

    if (mounted) {
      setState(() {
        folderShouldTalk = value;
      });
    }

    LocalPreferences.setBool('folderShouldTalk', value);
  }

  Widget getUserSettingsListView(BuildContext context) {
    // debog mode
    ListView settingListView = ListView(
      children: <Widget>[
        // show progress if needed
        workingProgressIndicator(),

        // user name & email
        getUserInformationCard(),

        // AllowLongPressInLearningScreen
        getAllowLongPressSetting(),

        // AllowLongPressInLearningScreen
        getFolderShouldTalkSettings(),

        // Grid selector
        //gridSizeSelector(),

        // Size of voicebox
        getVoiceBoxSizeSettings(),
        // configure if quizzes can be created on this devices
        getQuizzesSettings(),

        // output voicbox to another device
        //getOutputVoiceboxToCard()

        // Size of voicebox
        getSettingsPasswordProtected(),

        // toggle visibility for all images, sounds and videos
        getToggleVisibility(),

        // backup
        getBackupCard(),

        // backup
        getRestoreCard(),
      ],
    );

    return settingListView;
  }

  Widget getUserInformationCard() {
    if (translations == null || translations.isEmpty) return Container();

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              translations['user information'],
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  translations['user name'],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                child: canEditUserName
                    ? TextFormField(
                  initialValue: userName,
                  onChanged: (text) async {
                    userName = text;
                    await LocalPreferences.setString(
                        'userName', userName);
                  },
                  //style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: translations['user name hint']),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(userName),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        //showEditUserNameConfirmation();

                        setState(() {
                          canEditUserName = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                child: Text(
                  translations['user email'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                child: Text(
                  translations['user email instructions'],
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                child: canEditEmail
                    ? TextFormField(
                  initialValue: userEmail,
                  onChanged: (text) async {
                    userEmail = text;
                    await LocalPreferences.setString(
                        'userEmail', userEmail);
                  },
                  //style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(5.0),
                      hintText: translations['user email hint']),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(userEmail),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showEditEmailConfirmation();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showEditEmailConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations['change user email']),
          content: Text(translations['confirm change user email']),
          actions: <Widget>[
            new TextButton(
              child: L.getUpperText('accept'),
              onPressed: () async {
                setState(() {
                  canEditEmail = true;
                });

                Navigator.of(context).pop();
              },
            ),
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

  Widget getAllowLongPressSetting() {
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Switch(
              value: allowLongPressInLearningScreen,
              onChanged: (value) {
                toggleAllowLongPressInLearningScreen(value);
              },
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      allowLongPressInLearningScreen =
                      !allowLongPressInLearningScreen;
                      toggleAllowLongPressInLearningScreen(
                          allowLongPressInLearningScreen);
                    })
                  },
                  child: Text(strAllowLongPressInLearningScreen)),
            ),
          ],
        ),
        subtitle: Text(strLongPressInstructions),
      ),
    );
  }

  Widget getFolderShouldTalkSettings() {
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Switch(
              value: folderShouldTalk,
              onChanged: (value) async {
                await toggleFolderShouldTalk(value);
              },
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () => {
                    setState(() async {
                      folderShouldTalk = !folderShouldTalk;
                      await toggleFolderShouldTalk(folderShouldTalk);
                    })
                  },
                  child: Text(strFolderShouldTalk)),
            ),
          ],
        ),
        subtitle: Text(strFolderShouldTalkInstructions),
      ),
    );
  }

  Widget getVoiceBoxSizeSettings() {
    return Card(
      child: ListTile(
        title: Text(strVoiceBoxSize),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: _voiceBoxSize,
              onChanged: _handleVoiceBoxSizeChange,
            ),
            Expanded(
              child: Text(strSmall),
            ),
            Radio(
              value: 1,
              groupValue: _voiceBoxSize,
              onChanged: _handleVoiceBoxSizeChange,
            ),
            Expanded(
              child: Text(strBig),
            ),
          ],
        ),
      ),
    );
  }

  Widget getToggleVisibility() {
    return Card(
      child: ListTile(
        title: Text(strToggleVisibilityForAll),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                await MImage.unlockAll();
                await MVideo.unlockAll();
                await MSound.unlockAll();
                await MFolder.unlockAll();

                final lucasState = PropertyChangeProvider.of<LucasState>(
                    context,
                    listen: false)
                    .value;
                MFolder currentFolder =
                lucasState.getObject(StateProperties.currentFolder);
                if (currentFolder != null && currentFolder.id == -1)
                  currentFolder.isVisible = 1;
                await refreshFolder(currentFolder);

                setState(() {
                  isLoading = false;
                });

                showOperationSuccessfull();
              },
              child: Text(strUnlock),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  await MImage.lockAll();
                  await MVideo.lockAll();
                  await MSound.lockAll();
                  await MFolder.lockAll();

                  final lucasState = PropertyChangeProvider.of<LucasState>(
                      context,
                      listen: false)
                      .value;
                  MFolder currentFolder =
                  lucasState.getObject(StateProperties.currentFolder);
                  if (currentFolder != null && currentFolder.id == -1)
                    currentFolder.isVisible = 1;
                  await refreshFolder(currentFolder);

                  setState(() {
                    isLoading = false;
                  });

                  showOperationSuccessfull();
                },
                child: Text(strLock),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getBackupCard() {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(strBackup),
            isBackingup
                ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: Helper.LinearProgressIndicatorHeight,
                child: LinearProgressIndicator(
                  value: null,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  backgroundColor: Colors.white,
                ),
              ),
            )
                : Container(),
            //isBackingup ? Text('Please wait...') : Container(),
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$status'),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: MaterialButton(

                color: Theme.of(context).primaryColor,
                onPressed:isBackingup  ?null:  () async {
                  await backupDevice();
                },
                child: Text(strStart),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRestoreCard() {
    List<DropdownMenuItem<int>> items = <DropdownMenuItem<int>>[];
    if (folderList != null) {
      for (var v in folderList) {
        items.add(
          DropdownMenuItem(
            child: Text(
              v["textToShow"],
              // style: TextStyle(
              //   fontWeight: FontWeight.bold,
              // ),
            ),
            value: int.parse(v["folderIdInDevice"].toString()),
          ),
        );

      }
    }

    if(items.isNotEmpty&& selectedFolderToRestore==-1){
      selectedFolderToRestore=items.first.value;
    }



    List<DropdownMenuItem<int>> localItems = <DropdownMenuItem<int>>[];
    if (localFolders != null) {
      //localFolders.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
      for (var v in localFolders) {
        localItems.add(
          DropdownMenuItem(
            child: Text(
              v.textToShow,
              style: TextStyle(
                //color: Theme.of(context).primaryColor,
                //fontWeight: FontWeight.bold,
              ),
            ),
            value: v.id,
          ),
        );
      }
    }

    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(translations['restore device']),
            isRestoring
                ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: Helper.LinearProgressIndicatorHeight,
                child: LinearProgressIndicator(
                  value: null,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  backgroundColor: Colors.white,
                ),
              ),
            )
                : Container(),
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                translations['user email to restore'],
              ),
            ),
            TextFormField(
              initialValue: userEmailNameToRestore,
              onChanged: (text) async {
                userEmailNameToRestore = text;
              },
            ),
            Text('$status'),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed:isRestoring? null: () async {
                  await restoreDevice();
                },
                child: Text(translations['choose folder to restore']),
              ),
            ),
            folderList == null
                ? Container()
                : Text(translations['select a folder']),
            folderList == null
                ? Container()
                : Container(
              padding: EdgeInsets.only(left: 5.0),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedFolderToRestore,
                    isDense: true,
                    onChanged: (newValue) async {
                      if (mounted) {
                        setState(() {
                          selectedFolderToRestore = newValue;
                        });
                      }
                    },
                    items: items,
                  ),
                ),
              ),
            ),
            folderList == null
                ? Container()
                : Text(translations['what to do with folder']),
            folderList == null
                ? Container()
                : Container(
              padding: EdgeInsets.only(left: 5.0),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedLocalFolder,
                    isDense: true,
                    onChanged: (newValue) async {
                      if (mounted) {
                        setState(() {
                          selectedLocalFolder = newValue;
                        });
                      }
                    },
                    items: localItems,
                  ),
                ),
              ),
            ),
            folderList == null
                ? Container()
                : Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed:isRestoring?null : () async {
                      setState(() {
                        isRestoring= true ;
                      });
                      try{
                        await  HelperBackUp.reestore(userEmailNameToRestore, selectedFolderToRestore, selectedLocalFolder,actualizarEstado);
                      }catch(e){
                        setState(() {
                          status= "Error in reestore";
                        });
                      }

                      setState(() {
                        isRestoring= false ;
                      });
                      //  await replaceFolder(userEmailNameToRestore, selectedFolderToRestore, selectedLocalFolder);
                    },
                    child: Text(translations['replace folder']),
                  ),
                  // Spacer(),
                  // MaterialButton(
                  //   color: Theme.of(context).primaryColor,
                  //   onPressed: () async {
                  //     await addToFolder(userEmailNameToRestore,
                  //         selectedFolderToRestore, selectedLocalFolder);
                  //   },
                  //   child: Text(translations['add to folder']),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showWebResponseError(String strClass, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(strClass),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: L.getUpperText('accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getQuizzesSettings() {
    return Card(
      child: ListTile(
        title: Text(strQuizzes),
        subtitle: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(strQuizzesInstructions),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: _canCreateQuiz,
                  onChanged: _handleCanCreateQuizChange,
                ),
                Expanded(
                  child: Text(strCanCreateQuizzes),
                ),
                Radio(
                  value: 0,
                  groupValue: _canCreateQuiz,
                  onChanged: _handleCanCreateQuizChange,
                ),
                Expanded(
                  child: Text(strCannotCreateQuizzes),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget getOutputVoiceboxToCard() {
  //   if (linkedDevices == null) return Container();

  //   List<DropdownMenuItem> items =
  //       linkedDevices.map((MLinkedDevice mLinkedDevice) {
  //     return DropdownMenuItem(
  //       child: new Text(mLinkedDevice.name),
  //       value: mLinkedDevice.id,
  //     );
  //   }).toList();
  //   items.add(DropdownMenuItem(
  //     child: new Text(''),
  //     value: 0,
  //   ));

  //   return Card(
  //     child: Column(
  //       children: <Widget>[
  //         ListTile(
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text(
  //                 translations['linked devices'],
  //                 style: TextStyle(
  //                   color: Theme.of(context).primaryColor,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           subtitle: Row(
  //             children: <Widget>[
  //               Switch(
  //                 value: outputVoiceboxToAnotherDevice,
  //                 onChanged: (value) {
  //                   toggleOutputVoiceboxToAnotherDevice(value);
  //                 },
  //               ),
  //               Expanded(
  //                 child: GestureDetector(
  //                     onTap: () => {
  //                           setState(() {
  //                             outputVoiceboxToAnotherDevice =
  //                                 !outputVoiceboxToAnotherDevice;
  //                             toggleOutputVoiceboxToAnotherDevice(
  //                                 outputVoiceboxToAnotherDevice);
  //                           })
  //                         },
  //                     child: Text(translations['output voicebox to device'])),
  //               ),
  //               Container(
  //                 padding: EdgeInsets.only(left: 5.0),
  //                 child: outputVoiceboxToAnotherDevice
  //                     ? linkedDevices.isEmpty
  //                         ? Text('No linked devices')
  //                         : DropdownButtonHideUnderline(
  //                             child: DropdownButton<int>(
  //                               //hint: Text("Select Device"),
  //                               value: Helper.deviceToOutputVoicebox,
  //                               isDense: true,
  //                               onChanged: (newValue) {
  //                                 Helper.deviceToOutputVoicebox = newValue;

  //                                 // if (mounted) {
  //                                 //   setState(() {
  //                                 //     outputVoiceboxToAnotherDevice = value;
  //                                 //   });
  //                                 // }

  //                                 LocalPreferences.setInt(
  //                                     'deviceToOutputVoicebox', newValue);
  //                               },
  //                               items: items,
  //                             ),
  //                           )
  //                     : Container(),
  //               ),
  //             ],
  //           ),
  //           //subtitle: Text(_strCategoryInstructions),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getSettingsPasswordProtected() {
    return Card(
      child: ListTile(
        title: Text(translations['settings password protected']),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(translations['settings restrictions instructions']),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _settingsRestrictions,
                  onChanged: _handleSettingsRestrictionsChange,
                ),
                Expanded(
                    child:
                    Text(translations['settings password protected no'])),
                Radio(
                  value: 1,
                  groupValue: _settingsRestrictions,
                  onChanged: _handleSettingsRestrictionsChange,
                ),
                Expanded(
                    child:
                    Text(translations['settings password protected yes'])),
              ],
            ),

            // show/hide stories
            Text(translations['show hide stories and schedule']),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: _showHideStoriesAndSchedule,
                  onChanged: _handleShowHideStoriesAndScheduleChange,
                ),
                Expanded(child: Text(translations['show'])),
                Radio(
                  value: 0,
                  groupValue: _showHideStoriesAndSchedule,
                  onChanged: _handleShowHideStoriesAndScheduleChange,
                ),
                Expanded(child: Text(translations['hide'])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleShowHideStoriesAndScheduleChange(int value) {
    setState(() {
      _showHideStoriesAndSchedule = value;

      LocalPreferences.setInt(
          'showHideStoriesAndSchedule', _showHideStoriesAndSchedule);
    });

    Helper.showHideStoriesAndSchedule = _showHideStoriesAndSchedule;
  }

  void _handleSettingsRestrictionsChange(int value) {
    setState(() {
      _settingsRestrictions = value;

      LocalPreferences.setInt('settings restrictions', _settingsRestrictions);
    });

    Helper.settingsRestrictions = _settingsRestrictions;
  }

  void _handleVoiceBoxSizeChange(int value) {
    setState(() {
      _voiceBoxSize = value;

      LocalPreferences.setInt('voiceBoxSize', _voiceBoxSize);
    });

    if (value == 0) {
      Helper.voiceBoxHeight = 70.0;
    } else {
      Helper.voiceBoxHeight = 140.0;
    }
  }

  void _handleCanCreateQuizChange(int value) {
    final lucasState = PropertyChangeProvider.of<LucasState>(context).value;

    lucasState.saveObject(StateProperties.canCreateQuiz, value);

    setState(() {
      _canCreateQuiz = value;

      LocalPreferences.setInt('canCreateQuiz', _canCreateQuiz);
    });
  }

  showOperationSuccessfull() {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: L.getLocalizedText('operation completed successfully'),
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  showSnackbar(String msg, Duration duration) {
    if (!mounted) return;

    final snackBar = SnackBar(
      duration: duration,
      content: Text(msg),
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget gridSizeSelector() {
    return Card(
      child: ListTile(
        title: Text(strGridSize),
        subtitle: Container(
          //color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_strColumns + ' (${_columns.toInt()})'),
                          Slider(
                            min: Helper.minGridColumns,
                            max: Helper.maxGridColumns,
                            onChanged: (newColumns) async {
                              await LocalPreferences.setInt(
                                  "gridColumns", newColumns.toInt());

                              final lucasState =
                                  PropertyChangeProvider.of<LucasState>(context,
                                      listen: false)
                                      .value;
                              lucasState.setGridColumns(newColumns.toInt());

                              setState(() => _columns = newColumns);
                            },
                            value: _columns,
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   //padding: EdgeInsets.all(5.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Text(_strRows + ' (${_rows.toInt()})'),
                    //       //L.getLocalizedJoinedText('Rows', ' (${_rows.toInt()})'),
                    //       Slider(
                    //         min: Helper.minGridColumns,
                    //         max: Helper.maxGridColumns,
                    //         onChanged: (newRows) async {
                    //           await LocalPreferences.setInt(
                    //               "gridRows", newRows.toInt());

                    //           final lucasState =
                    //               PropertyChangeProvider.of<LucasState>(context,
                    //                       listen: false)
                    //                   .value;
                    //           lucasState.setGridRows(newRows.toInt());

                    //           setState(() => _rows = newRows);
                    //         },
                    //         value: _rows,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(child: Text(strGridSizeInstructions)),
                  ],
                ),
              ),

              // IconButton(
              //   color: Theme.of(context).primaryColor,
              //   icon: Icon(Icons.close),
              //   onPressed: () {
              //     setState(() {
              //       _selectedChoice = choices[0];
              //     });
              //     //_popMenuButtonOnSelected(context, _selectedChoice);
              //   },
              // ),
              // TextButton(
              //     child: Text(_strClose.toUpperCase()),

              //     //color: Colors.white,
              //     onPressed: () {
              //       setState(() {
              //         _selectedChoice = choices[0];
              //       });
              //       //_popMenuButtonOnSelected(context, _selectedChoice);
              //     }),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }

  Future<void> backupDevice() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');

    if (strUserEmail.isEmpty || strUserName.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.warning),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(translations['warning']),
                  ),
                ],
              ),
            ),
            content: Text(translations['email or name required for backup']),
            actions: <Widget>[
              new TextButton(
                // todo
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
                child: Text(translations['close'].toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();

                  // Route route =
                  //     MaterialPageRoute(builder: (context) => UserAccount());
                  // Navigator.push(context, route);
                },
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      isBackingup = true;

    });
    actualizarEstado("Backup started");

    await HelperBackUp.backup(userEmail, userName, actualizarEstado);
    bool hasErrors = false;

    setState(() {
      isBackingup = false;
      status = 'Backup completed successfully';
    });

/*
    WebResponse webResponse;

    setState(() {
      status = translations['images'];
    });
    webResponse = await MImage.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['images'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['empty'];
    });
    webResponse = await MEmpty.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['empty'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['folders'];
    });
    webResponse = await MFolder.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['folders'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['linked devices'];
    });
    webResponse = await MLinkedDevice.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(
          translations['linked devices'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['quiz'];
    });
    webResponse = await MQuiz.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['quiz'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['relation'];
    });
    webResponse = await MRelation.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['relation'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['schedule'];
    });
    webResponse = await MSchedule.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['schedule'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['schedule day'];
    });
    webResponse = await MScheduleDay.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(
          translations['schedule day'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['sound'];
    });
    webResponse = await MSound.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['sound'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['stories'];
    });
    webResponse = await MStory.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['stories'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['video'];
    });
    webResponse = await MVideo.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['video'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['story object'];
    });
    webResponse = await MStoryObject.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(
          translations['story object'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['translation'];
    });
    webResponse = await Translation.backup();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(
          translations['translation'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    // send user created objects
    setState(() {
      status = translations['images'];
    });
    webResponse = await MImage.backupUserCreatedObjects();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['images'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['sound'];
    });
    webResponse = await MSound.backupUserCreatedObjects();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['sound'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['video'];
    });
    webResponse = await MVideo.backupUserCreatedObjects();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['video'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['folders'];
    });
    webResponse = await MFolder.backupUserCreatedObjects();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['folders'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['sound'];
    });
    webResponse = await MSound.backupUserCreatedObjectsContent();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['sound'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }

    setState(() {
      status = translations['video'];
    });
    webResponse = await MVideo.backupUserCreatedObjectsContent();
    if (!webResponse.operation) {
      hasErrors = true;
      await showWebResponseError(translations['video'], webResponse.message);
    } else {
      setState(() {
        status = webResponse.message;
      });
    }
    //await new Future.delayed(const Duration(seconds: 5));
*/


    if (!hasErrors) {
      showSnackbar(translations['operation completed successfully'],
          Duration(milliseconds: 900));
      setState(() {
        status = translations['operation completed successfully'];
      });
    }
  }

  Future<void> restoreDevice() async {
    if (userEmailNameToRestore.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.warning),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(translations['warning']),
                  ),
                ],
              ),
            ),
            content: Text(translations['email or name required for restore']),
            actions: <Widget>[
              new TextButton(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
                child: Text(translations['close'].toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      isRestoring = true;
    });

    //bool hasErrors = false;
    /*WebResponseDynamic webResponseDynamic =
    await listFoldersInRepository(userEmailNameToRestore);
    if (!webResponseDynamic.operation) {
      //hasErrors = true;
      await showWebResponseError(
          "Loading folder list", webResponseDynamic.content);
    } else {*/
      dynamic folderRemoto= await  HelperWebService(userEmailNameToRestore, userName).listRemoteFolders();
      setState(() {
        selectedFolderToRestore=null;
        folderList = folderRemoto;


      });
   // }
    //  await itmsFoldersRemotos();


    setState(() {
      isRestoring = false;
      status = "";
    });

    // if (!hasErrors) {
    //   showSnackbar(translations['operation completed successfully'],
    //       Duration(milliseconds: 900));
    // }
  }



  static Future<WebResponseDynamic> listFoldersInRepository(
      String userEmailNameToRestore) async {
    String languageCode =
    await LocalPreferences.getString("languageCode", 'en');

    String json = jsonEncode({
      "email": userEmailNameToRestore,
      "language": languageCode,
      "operation": "list folders of a user",
    });

    return await Helper.getWebResponseDynamic(json);
  }

  Future<void> replaceFolder(String userEmailNameToRestore,
      int selectedFolderToRestore, int selectedLocalFolder) async {
    setState(() {
      isRestoring = true;
      status = "";
    });
    // showSnackbar(
    //     selectedFolderToRestore.toString(), Duration(milliseconds: 900));

    await restoreAssets(userEmailNameToRestore);

    if (mounted) {
      setState(() {
        status = "Downloading info... please wait";
      });
    }

    String json = jsonEncode({
      "email": userEmailNameToRestore,
      "folderIdInDevice": selectedFolderToRestore,
      "operation": "get all info of a folder",
    });

    WebResponseDynamic webResponseDynamic =
    await Helper.getWebResponseDynamic(json);

    if (!webResponseDynamic.operation) {
      await showWebResponseError("replaceFolder::", webResponseDynamic.content);

      setState(() {
        isRestoring = false;
        status = "";
      });

      return;
    }

    dynamic remoteTranslations = webResponseDynamic.content[0];
    dynamic remoteRelations = webResponseDynamic.content[1];
    dynamic remoteImages = webResponseDynamic.content[2];
    dynamic remoteEmpties = webResponseDynamic.content[3];
    dynamic remoteFolders = webResponseDynamic.content[4];
    dynamic remoteVideos = webResponseDynamic.content[5];
    dynamic remoteSounds = webResponseDynamic.content[6];
    dynamic remoteObjectTranslations = webResponseDynamic.content[7];

    MFolder localFolder = await MFolder.getByID(selectedLocalFolder);
    if (localFolder == null) {
      setState(() {
        isRestoring = false;
        status = "";
      });
      return;
    }

    // update translations
    if (mounted) {
      setState(() {
        status = "Restoring translations";
      });
    }
    for (var v in remoteTranslations) {
      Translation folderTranslation = await Translation.getLocalized(
        "folders",
        localFolder.id,
        v["language"],
      );
      if (folderTranslation != null) {
        folderTranslation.textToShow = v["textToShow"];
        folderTranslation.textToSay = v["textToSay"];
        await Translation.update(folderTranslation);
      }
    }

    // Delete all objects (including subfolders and relations)
    List<MObject> objectsToDelete =
    await MRelation.getObjectsInFolder(6, localFolder.id);
    for (var mObject in objectsToDelete) {
      String typeOfConcept = await Helper.deleteAnObject(mObject);
      List<MRelation> relations =
      await MRelation.getAllRelationsOfItemId(typeOfConcept, mObject.id);
      for (int i = 0; i < relations.length; i++) {
        await MRelation.delete(relations[i]);
      }
    }

    // add images
    if (mounted) {
      setState(() {
        status = "Restoring images";
      });
    }
    for (var i in remoteImages) {
      await addRemoteImage(
          i, remoteObjectTranslations, remoteRelations, localFolder);
    }
    MImage.clearMemoryTables();

    // add empties
    if (mounted) {
      setState(() {
        status = "Restoring empties";
      });
    }
    for (var i in remoteEmpties) {
      await addRemoteEmpty(
          i, remoteObjectTranslations, remoteRelations, localFolder);
    }
    MEmpty.clearMemoryTables();

    // add videos
    if (mounted) {
      setState(() {
        status = "Restoring videos";
      });
    }
    for (var i in remoteVideos) {
      await addRemoteVideo(
          i, remoteObjectTranslations, remoteRelations, localFolder);
    }
    MVideo.clearMemoryTables();

    // add sounds
    if (mounted) {
      setState(() {
        status = "Restoring sounds";
      });
    }
    for (var i in remoteSounds) {
      await addRemoteSound(
          i, remoteObjectTranslations, remoteRelations, localFolder);
    }
    MSound.clearMemoryTables();

    // add folders
    if (mounted) {
      setState(() {
        status = "Restoring folders";
      });
    }
    for (var i in remoteFolders) {
      await addRemoteFolder(
          i, remoteObjectTranslations, remoteRelations, localFolder);
    }
    MFolder.clearMemoryTables();

    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
    await MRelation.getObjectsInFolder(gridColumns, localFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    if (mounted) {
      setState(() {
        isRestoring = false;
        status = "";
        status = translations['operation completed successfully'];
      });
    }

    showSnackbar(translations['operation completed successfully'],
        Duration(milliseconds: 900));
  }

  Future<void> addRemoteImage(dynamic obj, dynamic remoteObjectTranslations,
      dynamic remoteRelations, MFolder parentFolder) async {
    int maxImageId = await MImage.maxId();
    MImage mImage = MImage(
      id: maxImageId,
      fileName: obj["fileName"],
      isVisible: int.parse(obj["isVisible"]),
      isUnderstood: int.parse(obj["isUnderstood"]),
      useAsset: int.parse(obj["useAsset"]),
      localFileName: obj["localFileName"],
      userCreated: int.parse(obj["userCreated"]),
      isAvailable: int.parse(obj["isAvailable"]),
      backgroundColor: obj["backgroundColor"],
      minLevelToShow: int.parse(obj["minLevelToShow"]),
    );
    await MImage.createWithID(mImage);

    // add translation
    for (var t in remoteObjectTranslations) {
      if (t["tableName"] == MImage.TableName &&
          t["itemId"] == obj["idInDevice"]) {
        Translation entity = Translation(
          tableName: MImage.TableName,
          itemId: mImage.id,
          language: t["language"],
          textToShow: t["textToShow"],
          textToSay: t["textToSay"],
        );

        await Translation.create(entity);
      }
    }

    // Add relation
    int visibleIndex = -1;
    int userCreated = 1;
    for (var r in remoteRelations) {
      if (r["cardImageId"] == obj["idInDevice"] && r["cardType"] == "image") {
        visibleIndex = int.parse(r["visibleIndex"]);
        userCreated = int.parse(r["userCreated"]);
      }
    }

    int maxId = await MRelation.maxId();
    MRelation relation = MRelation(
      id: maxId,
      parentFolderId: parentFolder.id,
      cardType: 'image',
      cardFolderId: -1,
      cardEmptyId: -1,
      cardImageId: mImage.id,
      cardVideoId: -1,
      cardSoundId: -1,
      visibleIndex: visibleIndex,
      userCreated: userCreated,
    );

    await MRelation.createWithID(relation);
  }

  Future<void> addRemoteEmpty(dynamic obj, dynamic remoteObjectTranslations,
      dynamic remoteRelations, MFolder parentFolder) async {
    int maxEmptyId = await MEmpty.maxId();
    MEmpty mEmpty = MEmpty(
      id: maxEmptyId,
      backgroundColor: obj["backgroundColor"],
      userCreated: int.parse(obj["userCreated"]),
    );
    await MEmpty.createWithID(mEmpty);

    // Add relation
    int visibleIndex = -1;
    int userCreated = 1;
    for (var r in remoteRelations) {
      if (r["cardEmptyId"] == obj["idInDevice"] && r["cardType"] == "empty") {
        visibleIndex = int.parse(r["visibleIndex"]);
        userCreated = int.parse(r["userCreated"]);
      }
    }

    int maxId = await MRelation.maxId();
    MRelation relation = MRelation(
      id: maxId,
      parentFolderId: parentFolder.id,
      cardType: 'empty',
      cardFolderId: -1,
      cardEmptyId: mEmpty.id,
      cardImageId: -1,
      cardVideoId: -1,
      cardSoundId: -1,
      visibleIndex: visibleIndex,
      userCreated: userCreated,
    );

    await MRelation.createWithID(relation);
  }

  Future<void> addRemoteVideo(dynamic obj, dynamic remoteObjectTranslations,
      dynamic remoteRelations, MFolder parentFolder) async {
    int maxVideoId = await MVideo.maxId();
    MVideo mVideo = MVideo(
      id: maxVideoId,
      fileName: obj["fileName"],
      isVisible: int.parse(obj["isVisible"]),
      isUnderstood: int.parse(obj["isUnderstood"]),
      useAsset: int.parse(obj["useAsset"]),
      localFileName: obj["localFileName"],
      userCreated: int.parse(obj["userCreated"]),
      localVideoPath: obj["localVideoPath"],
      isAvailable: int.parse(obj["isAvailable"]),
      backgroundColor: obj["backgroundColor"],
      minLevelToShow: int.parse(obj["minLevelToShow"]),
    );
    await MVideo.createWithID(mVideo);

    // add translation
    for (var t in remoteObjectTranslations) {
      if (t["tableName"] == MVideo.TableName &&
          t["itemId"] == obj["idInDevice"]) {
        Translation entity = Translation(
          tableName: MVideo.TableName,
          itemId: mVideo.id,
          language: t["language"],
          textToShow: t["textToShow"],
          textToSay: t["textToSay"],
        );

        await Translation.create(entity);
      }
    }

    // Add relation
    int visibleIndex = -1;
    int userCreated = 1;
    for (var r in remoteRelations) {
      if (r["cardVideoId"] == obj["idInDevice"] && r["cardType"] == "video") {
        visibleIndex = int.parse(r["visibleIndex"]);
        userCreated = int.parse(r["userCreated"]);
      }
    }

    int maxId = await MRelation.maxId();
    MRelation relation = MRelation(
      id: maxId,
      parentFolderId: parentFolder.id,
      cardType: 'video',
      cardFolderId: -1,
      cardEmptyId: -1,
      cardImageId: -1,
      cardVideoId: mVideo.id,
      cardSoundId: -1,
      visibleIndex: visibleIndex,
      userCreated: userCreated,
    );

    await MRelation.createWithID(relation);
  }

  Future<void> addRemoteSound(dynamic obj, dynamic remoteObjectTranslations,
      dynamic remoteRelations, MFolder parentFolder) async {
    int maxSoundId = await MSound.maxId();
    MSound mSound = MSound(
      id: maxSoundId,
      fileName: obj["fileName"],
      isVisible: int.parse(obj["isVisible"]),
      isUnderstood: int.parse(obj["isUnderstood"]),
      useAsset: int.parse(obj["useAsset"]),
      localFileName: obj["localFileName"],
      userCreated: int.parse(obj["userCreated"]),
      localSoundFileName: obj["localSoundFileName"],
      isAvailable: int.parse(obj["isAvailable"]),
      backgroundColor: obj["backgroundColor"],
      minLevelToShow: int.parse(obj["minLevelToShow"]),
    );
    await MSound.createWithID(mSound);

    // add translation
    for (var t in remoteObjectTranslations) {
      if (t["tableName"] == MSound.TableName &&
          t["itemId"] == obj["idInDevice"]) {
        Translation entity = Translation(
          tableName: MSound.TableName,
          itemId: mSound.id,
          language: t["language"],
          textToShow: t["textToShow"],
          textToSay: t["textToSay"],
        );

        await Translation.create(entity);
      }
    }

    // Add relation
    int visibleIndex = -1;
    int userCreated = 1;
    for (var r in remoteRelations) {
      if (r["cardSoundId"] == obj["idInDevice"] && r["cardType"] == "sound") {
        visibleIndex = int.parse(r["visibleIndex"]);
        userCreated = int.parse(r["userCreated"]);
      }
    }

    int maxId = await MRelation.maxId();
    MRelation relation = MRelation(
      id: maxId,
      parentFolderId: parentFolder.id,
      cardType: 'sound',
      cardFolderId: -1,
      cardEmptyId: -1,
      cardImageId: -1,
      cardVideoId: -1,
      cardSoundId: mSound.id,
      visibleIndex: visibleIndex,
      userCreated: userCreated,
    );

    await MRelation.createWithID(relation);
  }

  Future<void> addRemoteFolder(dynamic obj, dynamic remoteObjectTranslations,
      dynamic remoteRelations, MFolder parentFolder) async {
    int maxFolderId = await MFolder.maxId();
    MFolder mFolder = MFolder(
      id: maxFolderId,
      fileName: obj["fileName"],
      isVisible: int.parse(obj["isVisible"]),
      isUnderstood: int.parse(obj["isUnderstood"]),
      useAsset: int.parse(obj["useAsset"]),
      localFileName: obj["localFileName"],
      userCreated: int.parse(obj["userCreated"]),
      isAvailable: int.parse(obj["isAvailable"]),
      backgroundColor: obj["backgroundColor"],
      minLevelToShow: int.parse(obj["minLevelToShow"]),
    );
    await MFolder.createWithID(mFolder);

    // add translation
    for (var t in remoteObjectTranslations) {
      if (t["tableName"] == MFolder.TableName &&
          t["itemId"] == obj["idInDevice"]) {
        Translation entity = Translation(
          tableName: MFolder.TableName,
          itemId: mFolder.id,
          language: t["language"],
          textToShow: t["textToShow"],
          textToSay: t["textToSay"],
        );

        await Translation.create(entity);
      }
    }

    // Add relation
    int visibleIndex = -1;
    int userCreated = 1;
    for (var r in remoteRelations) {
      if (r["cardFolderId"] == obj["idInDevice"] && r["cardType"] == "folder") {
        visibleIndex = int.parse(r["visibleIndex"]);
        userCreated = int.parse(r["userCreated"]);
      }
    }

    int maxId = await MRelation.maxId();
    MRelation relation = MRelation(
      id: maxId,
      parentFolderId: parentFolder.id,
      cardType: 'folder',
      cardFolderId: mFolder.id,
      cardEmptyId: -1,
      cardImageId: -1,
      cardVideoId: -1,
      cardSoundId: -1,
      visibleIndex: visibleIndex,
      userCreated: userCreated,
    );

    await MRelation.createWithID(relation);
  }

  // Future<WebResponseDynamic> addToFolder(String userEmailNameToRestore,
  //     int selectedFolderToRestore, int selectedLocalFolder) async {
  //   WebResponseDynamic webResponse =
  //       WebResponseDynamic(operation: true, content: "");
  //   return webResponse;

  //   // String languageCode =
  //   //     await LocalPreferences.getString("languageCode", 'en');

  //   // String json = jsonEncode({
  //   //   "email": userEmailNameToRestore,
  //   //   "language": languageCode,
  //   //   "operation": "list translations of a folder",
  //   // });

  //   // return await Helper.getFolderList(json);
  // }
  Future<void> restoreAssets(String userEmailNameToRestore) async {
    setState(() {
      isRestoring = true;
      status = "";
    });
    // showSnackbar(
    //     selectedFolderToRestore.toString(), Duration(milliseconds: 900));

    String json = jsonEncode({
      "email": userEmailNameToRestore,
      "operation": "list assets of a user",
    });

    WebResponseDynamic webResponseDynamic =
    await Helper.getWebResponseDynamic(json);

    if (!webResponseDynamic.operation) {
      await showWebResponseError(
          "list assets of a user::", webResponseDynamic.content);

      setState(() {
        isRestoring = false;
        status = "";
      });

      return;
    }

    dynamic assetsOfTheUser = webResponseDynamic.content;

    // update translations
    for (var v in assetsOfTheUser) {
      //var objectType = v["objectType"];
      //var idInDevice = v["idInDevice"];
      //var propertyName = v["propertyName"];
      var fileName = v["fileName"];

      setState(() {
        status = fileName;
      });

      String json = jsonEncode({
        "email": userEmailNameToRestore,
        "fileName": fileName,
        "operation": "get file",
      });

      WebResponseDynamic webResponseDynamic =
      await Helper.getWebResponseDynamic(json);

      if (!webResponseDynamic.operation) {
        // await showWebResponseError("get file::", webResponseDynamic.content);

        // setState(() {
        //   isRestoring = false;
        //   status = "";
        // });

        return;
      }

      String allBase64 = webResponseDynamic.content;
      String encodedStr = allBase64.replaceAll("data:image/jpg;base64,", "");

      //String filePath =
      await _createFileFromString(encodedStr, fileName);
    }

    setState(() {
      status = "";
    });
  }

  Future<String> _createFileFromString(
      String encodedStr, String fileName) async {
    String dir = Helper.appDirectory;
    File file = File("$dir/" + fileName);
    await file.writeAsBytes(base64.decode(encodedStr));
    return file.path;
  }
}