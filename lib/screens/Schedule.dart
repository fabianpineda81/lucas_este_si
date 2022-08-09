import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSchedule.dart';
import 'package:lucas/models/MScheduleDay.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MStory.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/widgets/WFolder.dart';
import 'package:lucas/widgets/WImage.dart';
import 'package:lucas/widgets/WOnboard.dart';
import 'package:lucas/widgets/WSound.dart';
import 'package:lucas/widgets/WVideo.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

import 'AddObjectToSchedule.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Map<String, String> helpScreenTranslations = Map<String, String>();
  bool canShowHelpScreens = false;

  List<String> translationItems = [
    'linked devices',
  ];

  Map<String, String> translations = Map<String, String>();
  bool isEdit = false;
  bool showHourColumn = false;
  bool showChangeHourColumn = true;
  List<MScheduleDay> days;
  List<MSchedule> objects;
  String currentLevel;
  Map<int, MImage> hourImages;

  MImage todayMImage;
  MImage tomorrowMImage;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // //bool _isSaving = false;
  // GlobalKey _globalKey = new GlobalKey();

  _ScheduleState() {
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

    loadHelpScreensTranslationTexts().then((result) {
      setState(() {
        canShowHelpScreens = true;
      });
    });
  }

  Future<void> loadHelpScreensTranslationTexts() async {
    List<String> helpScreenTranslationsItems = [
      'schedule_title1',
      'schedule_title2',
      'schedule_title3',
      'schedule_title4',
      'schedule_title5',
      'schedule_text1',
      'schedule_text2',
      'schedule_text3',
      'schedule_text4',
      'schedule_text5',
    ];

    for (int i = 0; i < helpScreenTranslationsItems.length; i++) {
      helpScreenTranslations[helpScreenTranslationsItems[i]] = '';
    }

    Map<String, String> result = await L.getItems(helpScreenTranslationsItems);

    if (mounted) {
      setState(() {
        helpScreenTranslations = result;
      });
    }
  }

  Future<void> initialize() async {
    Map<String, String> result = await L.getItems(translationItems);

    currentLevel = await LocalPreferences.getString("currentLevel", "1");
    showHourColumn = await LocalPreferences.getBool("showHourColumn", false);

    //await MSchedule.dropTableIfExists();
    await MSchedule.createTableIFNotExists();

    days = await MScheduleDay.getAll();
    objects = await MSchedule.getAll();
    for (int i = 0; i < objects.length; i++) {
      MSchedule iSchedule = objects[i];
      if (iSchedule.mObject != null) {
        MObject mObject = iSchedule.mObject;
        mObject.tag = iSchedule;
      }
    }

    todayMImage = await MImage.getByID(887);
    tomorrowMImage = await MImage.getByID(888);

    if (mounted) {
      setState(() {
        translations = result;
      });
    }

    hourImages = Map<int, MImage>();
    for (int h = 0; h < 24; h++) {
      int hourRepresentation = getHourRepresentation(h);
      MImage mHourImage = await MImage.getByID(hourRepresentation);
      mHourImage = await mHourImage.clone();
      hourImages[h] = mHourImage;
    }
  }

  Widget showHelperScreens() {
    if (!canShowHelpScreens) return Container();

    List<String> images = [
      "assets/onboarding/schedule-1-intro.png",
      "assets/onboarding/schedule-2-hours.png",
      "assets/onboarding/schedule-3-edit-mode.png",
      "assets/onboarding/schedule-4-add-object.png",
      "assets/onboarding/schedule-5-manage-days.png",
    ];

    List<String> titles = [
      helpScreenTranslations['schedule_title1'],
      helpScreenTranslations['schedule_title2'],
      helpScreenTranslations['schedule_title3'],
      helpScreenTranslations['schedule_title4'],
      helpScreenTranslations['schedule_title5'],
    ];

    List<String> texts = [
      helpScreenTranslations['schedule_text1'],
      helpScreenTranslations['schedule_text2'],
      helpScreenTranslations['schedule_text3'],
      helpScreenTranslations['schedule_text4'],
      helpScreenTranslations['schedule_text5'],
    ];

    return WOnboard(images, titles, texts, StateProperties.showHelperSchedule,
        onOnBoardBtnAccept);
  }

  onOnBoardBtnAccept(dynamic a) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (days == null || days.length < 2) return Container();
    if (objects == null) return Container();

    final lucasState = PropertyChangeProvider.of<LucasState>(context).value;
    if ((lucasState.getObject(StateProperties.showHelperSchedule) ?? 'false') !=
        "false") {
      return showHelperScreens();
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        //key: _scaffoldKey,
        //backgroundColor: Colors.grey[350],
        appBar: AppBar(
          title: Text('Schedule'),
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            !isEdit
                ? Container()
                : IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () async {
                      Route route = MaterialPageRoute(
                          builder: (context) => AddObjectToSchedule());
                      await Navigator.push(context, route);

                      List<MSchedule> scheduleObjects =
                          await MSchedule.getAll();
                      for (int i = 0; i < scheduleObjects.length; i++) {
                        if (scheduleObjects[i].mObject != null)
                          scheduleObjects[i].mObject.tag = scheduleObjects[i];
                      }
                      setState(() {
                        objects = scheduleObjects;
                      });
                    },
                  ),
            !isEdit
                ? Container()
                : IconButton(
                    icon: Icon(
                      Icons.view_column,
                    ),
                    onPressed: () {},
                  ),
            showChangeHourColumn
                ? IconButton(
                    icon: Icon(
                      showHourColumn ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () async {
                      setState(() {
                        showHourColumn = !showHourColumn;
                      });
                      await LocalPreferences.setBool(
                          "showHourColumn", showHourColumn);
                    },
                  )
                : Container(),
            IconButton(
              icon: !isEdit
                  ? Icon(
                      Icons.edit,
                    )
                  : Icon(
                      Icons.done,
                    ),
              onPressed: () {
                setState(() {
                  isEdit = !isEdit;
                  showChangeHourColumn = !showChangeHourColumn;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.help,
              ),
              onPressed: () {
                String showHelpStatus =
                    lucasState.getObject(StateProperties.showHelperSchedule) ??
                        '';
                setState(() {
                  if (showHelpStatus == '')
                    lucasState.saveObject(
                        StateProperties.showHelperSchedule, 'false');
                  else
                    lucasState.saveObject(
                        StateProperties.showHelperSchedule, '');
                });
              },
            ),
          ],
        ),
        body: Center(
          child: scheduleWidget(),
        ),
        bottomNavigationBar: BottomNavigationOptions(),
      ),
    );
  }

  Widget scheduleWidget() {
    List<Widget> activities = <Widget>[];

    int iToday = DateTime.now().weekday;
    int iTomorrow = iToday + 1;
    if (iTomorrow > 7) iTomorrow = 1;

    for (int i = 0; i < days.length; i++) {
      if (isEdit) {
        // add all days
        activities.add(WImage(
          true,
          days[i].mImage,
          currentLevel,
          _onItemTap,
          null,
          _onItemLongPress,
          key: UniqueKey(),
        ));
      } else {
        // add the days after sunday
        if (i > 6) {
          activities.add(WImage(
            true,
            days[i].mImage,
            currentLevel,
            _onItemTap,
            null,
            _onItemLongPress,
            key: UniqueKey(),
          ));
        }
        if (i == 1) {
          activities.add(WImage(
            true,
            todayMImage,
            currentLevel,
            _onItemTap,
            null,
            _onItemLongPress,
            key: UniqueKey(),
          ));

          activities.add(WImage(
            true,
            tomorrowMImage,
            currentLevel,
            _onItemTap,
            null,
            _onItemLongPress,
            key: UniqueKey(),
          ));
        }
      }
    }
    if (!isEdit) {
      if (showHourColumn) {
        activities.add(Container());
      }
    }

    int iDay = 0;
    bool newRow = true;
    int hour = -1;
    List<Widget> rowWidgets = <Widget>[];
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].mObject != null) {
        MSchedule mScheduleToFindHour = objects[i].mObject.tag;
        hour = mScheduleToFindHour.hour;
      }

      iDay++;
      if (isEdit) {
        if (objects[i].mObject == null) {
          activities.add(Container());
        }

        activities = addObject(activities, i);
      } else
      // is not in edit mode
      {
        // if not days of week
        if (iDay > 7) {
          if (objects[i].mObject == null) {
            rowWidgets.add(Container());
            //activities.add(Container());
          } else {
            Widget widget = widgetToAdd(i);
            if (widget != null) rowWidgets.add(widget);
            //activities = addObject(activities, i);
          }
        }
        // if days of week
        if (newRow) {
          newRow = false;
          int dayOfWeekIndex = 1;
          for (int j = i; j < i + 7; j++) {
            if (dayOfWeekIndex == iToday) {
              if (objects[j].mObject == null) {
                rowWidgets.add(Container());
                //activities.add(Container());
              } else {
                Widget widget = widgetToAdd(j);
                if (widget != null) rowWidgets.add(widget);
                //activities = addObject(activities, j);
              }
            }
            dayOfWeekIndex++;
          }

          dayOfWeekIndex = 1;
          for (int j = i; j < i + 7; j++) {
            if (dayOfWeekIndex == iTomorrow) {
              if (objects[j].mObject == null) {
                rowWidgets.add(Container());
                //activities.add(Container());
              } else {
                Widget widget = widgetToAdd(j);
                if (widget != null) rowWidgets.add(widget);
                //activities = addObject(activities, j);
              }
            }
            dayOfWeekIndex++;
          }
        }
      }

      if (!isEdit) {
        if (iDay > days.length - 1) {
          iDay = 0;
          newRow = true;

          bool hasImage = false;
          for (int a = 0; a < rowWidgets.length; a++) {
            if (rowWidgets[a] is Container) {
            } else {
              hasImage = true;
            }
          }
          if (hasImage) {
            for (int w = 0; w < rowWidgets.length; w++) {
              activities.add(rowWidgets[w]);
            }
            if (showHourColumn) {
              activities.add(Container(
                  child: WImage(
                true,
                hourImages[hour],
                currentLevel,
                _onItemTap,
                null,
                _onItemLongPress,
                key: UniqueKey(),
              )));
            }
          }
          rowWidgets = <Widget>[];
        }
      }
    }

    return GridView.count(
      crossAxisCount:
          isEdit ? days.length : days.length - 5 + (showHourColumn ? 1 : 0),
      children: activities,
    );
  }

  int getHourRepresentation(hour) {
    if (hour == 0) return 670;
    if (hour == 1) return 670;
    if (hour == 2) return 670;
    if (hour == 3) return 670;
    if (hour == 4) return 670;
    if (hour == 5) return 670;
    if (hour == 6) return 672;
    if (hour == 7) return 672;
    if (hour == 8) return 672;
    if (hour == 9) return 672;
    if (hour == 10) return 672;
    if (hour == 11) return 672;
    if (hour == 12) return 671;
    if (hour == 13) return 671;
    if (hour == 14) return 671;
    if (hour == 15) return 671;
    if (hour == 16) return 671;
    if (hour == 17) return 671;
    if (hour == 18) return 670;
    if (hour == 19) return 670;
    if (hour == 20) return 670;
    if (hour == 21) return 670;
    if (hour == 22) return 670;
    if (hour == 23) return 670;
    return 669;
  }

  List<Widget> addObject(List<Widget> activities, int index) {
    // if (activities==null)
    //   return activities;
    // if (objects[i].mObject == null) {
    //   activities.add(Container());
    // }

    if (objects[index].mObject is MImage) {
      activities.add(WImage(
        true,
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      ));
    }
    if (objects[index].mObject is MFolder) {
      activities.add(WFolder(
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      ));
    }
    if (objects[index].mObject is MVideo) {
      activities.add(WVideo(
        true,
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      ));
    }
    if (objects[index].mObject is MSound) {
      activities.add(WSound(
        true,
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      ));
    }
    if (objects[index].mObject is MStory) {
      // activities.add(WStory(
      //   true,
      //   objects[i].mObject,
      //   currentLevel,
      //   null,
      //   null,
      //   null,
      //   key: UniqueKey(),
      // ));
    }

    return activities;
  }

  Widget widgetToAdd(int index) {
    // if (activities==null)
    //   return activities;
    // if (objects[i].mObject == null) {
    //   activities.add(Container());
    // }

    if (objects[index].mObject is MImage) {
      return WImage(
        true,
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (objects[index].mObject is MFolder) {
      return WFolder(
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (objects[index].mObject is MVideo) {
      return WVideo(
        true,
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (objects[index].mObject is MSound) {
      return WSound(
        true,
        objects[index].mObject,
        '9',
        _onItemTap,
        null,
        _onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (objects[index].mObject is MStory) {
      // activities.add(WStory(
      //   true,
      //   objects[i].mObject,
      //   currentLevel,
      //   null,
      //   null,
      //   null,
      //   key: UniqueKey(),
      // ));
    }

    return null;
  }

  _onItemTap(MObject mObject) async {
    if (isEdit) {
      if (mObject != null) {
        MSchedule mSchedule = mObject.tag;
        if (mSchedule != null) {
          Route route = MaterialPageRoute(
              builder: (context) => AddObjectToSchedule(
                  selectedScheduleId: mSchedule.id,
                  selectedObjectId: mSchedule.objectId,
                  hour: mSchedule.hour,
                  day: mSchedule.day));
          await Navigator.push(context, route);

          List<MSchedule> scheduleObjects = await MSchedule.getAll();
          for (int i = 0; i < scheduleObjects.length; i++) {
            if (scheduleObjects[i].mObject != null)
              scheduleObjects[i].mObject.tag = scheduleObjects[i];
          }
          setState(() {
            objects = scheduleObjects;
          });
        }
      }

      List<MSchedule> scheduleObjects = await MSchedule.getAll();
      setState(() {
        objects = scheduleObjects;
      });
    }
  }

  _onItemLongPress(MObject mObject) async {
    if (!isEdit) {
      _showDialog(mObject);
    }
  }

  void _showDialog(MObject mObject) async {
    String strCurrentLevel =
        await LocalPreferences.getString("currentLevel", "1");

    Widget objectWidget;
    if (mObject is MFolder) {
      objectWidget = WFolder(
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
    }
    if (mObject is MImage) {
      MImage mImage = mObject;
      objectWidget = WImage(
        true,
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      if (mImage.useAsset == 0) {
        objectWidget =
            Container(padding: EdgeInsets.all(3.0), child: objectWidget);
      }
    }
    if (mObject is MVideo) {
      MVideo mVideo = mObject;
      objectWidget = WVideo(
        true,
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      if (mVideo.useAsset == 0) {
        objectWidget =
            Container(padding: EdgeInsets.all(3.0), child: objectWidget);
      }
    }
    if (mObject is MSound) {
      MSound mSound = mObject;
      objectWidget = WSound(
        true,
        mObject,
        strCurrentLevel,
        null,
        null,
        null,
        key: UniqueKey(),
      );
      if (mSound.useAsset == 0) {
        objectWidget =
            Container(padding: EdgeInsets.all(3.0), child: objectWidget);
      }
    }

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          //title: new Text(mObject.textToShow),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: objectWidget,
                        // Image.asset(
                        //   fileName ?? '',
                        //   // height: MediaQuery.of(context).size.height / 2,
                        //   // width: MediaQuery.of(context).size.width / 2,
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onBackPressed() async {
    return true;
  }
}

class ScheduleDay {
  String name;
  String assetFileName;

  ScheduleDay(this.name, this.assetFileName);
}
