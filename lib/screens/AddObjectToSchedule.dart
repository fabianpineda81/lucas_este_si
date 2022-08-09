import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSchedule.dart';
import 'package:lucas/models/MScheduleDay.dart';
import 'package:lucas/widgets/WImage.dart';
import 'package:transparent_image/transparent_image.dart';

import 'ImageSettings.dart';

class AddObjectToSchedule extends StatefulWidget {
  final int selectedScheduleId;
  final int selectedObjectId;
  final int hour;
  final int day;

  AddObjectToSchedule(
      {this.selectedScheduleId, this.selectedObjectId, this.hour, this.day});

  @override
  _AddObjectToScheduleState createState() => _AddObjectToScheduleState(
      selectedScheduleId, selectedObjectId, hour, day);
}

class _AddObjectToScheduleState extends State<AddObjectToSchedule> {
  List<String> translationItems = [
    'add object',
    'select day',
    'selected day',
    'select hour',
    'select an object',
    'accept',
    'please select an object',
    'please select a day',
    'delete',
    'existing concept',
    'reset'
  ];

  bool isLoading = false;

  int day = -1;
  int selectedScheduleId = -1;
  String selectedDay = '';
  int hour = 8;
  String objectType = 'image';
  //int objectId = -1;
  Map<String, String> translations = Map<String, String>();
  List<MScheduleDay> days;
  Map<int, String> hours;
  int selectedObjectId = -1;
  MImage selectedImage;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _AddObjectToScheduleState(
      this.selectedScheduleId, this.selectedObjectId, this.hour, this.day) {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }

    this.selectedScheduleId = selectedScheduleId ?? -1;
    this.selectedObjectId = selectedObjectId ?? -1;
    this.hour = hour ?? 8;
    this.day = day ?? -1;
  }

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      // if (mounted) {
      //   setState(() {});
      // }
    });
  }

  Future<void> initialize() async {
    Map<String, String> result = await L.getItems(translationItems);
    List<MScheduleDay> daysList = await MScheduleDay.getAll();

    Map<int, String> theHours = Map<int, String>();
    theHours[0] = '00';
    theHours[1] = '01';
    theHours[2] = '02';
    theHours[3] = '03';
    theHours[4] = '04';
    theHours[5] = '05';
    theHours[6] = '06';
    theHours[7] = '07';
    theHours[8] = '08';
    theHours[9] = '09';
    theHours[10] = '10';
    theHours[11] = '11';
    theHours[12] = '12';
    theHours[13] = '13';
    theHours[14] = '14';
    theHours[15] = '15';
    theHours[16] = '16';
    theHours[17] = '17';
    theHours[18] = '18';
    theHours[19] = '19';
    theHours[20] = '20';
    theHours[21] = '21';
    theHours[22] = '22';
    theHours[23] = '23';

    MImage mImage;
    if (this.selectedObjectId != null && this.selectedObjectId != -1) {
      mImage = await MImage.getByID(this.selectedObjectId);
    }

    if (mounted) {
      setState(() {
        translations = result;
        days = daysList;
        hours = theHours;
        if (mImage != null) selectedImage = mImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (translations == null || translations.isEmpty) {
      return Container();
    }
    if (days == null) {
      return Container();
    }
    if (hours == null) {
      return Container();
    }

    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: (translations == null || translations.isEmpty)
              ? Container()
              : Text(translations['add object']),
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            (selectedScheduleId == -1)
                ? Container()
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      //color: Colors.red,
                    ),
                    onPressed: () async {
                      MSchedule entity = new MSchedule();
                      entity.id = selectedScheduleId;
                      entity.objectType = 'image';
                      entity.objectId = selectedObjectId;
                      entity.hour = hour;
                      entity.day = day;
                      await MSchedule.delete(entity);

                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //Text('Selected schedule id: $selectedScheduleId'),
                    getSelectDay(),
                    getSelectHour(),
                    selectObject(),
                    getSaveItem(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectDay() {
    final items = <Widget>[];

    for (var i = 0; i < days.length; i++) {
      days[i].mImage.tag = days[i];
      items.add(
        Container(
          height: 90,
          width: 90,
          child: WImage(
            true,
            days[i].mImage,
            '9',
            _onDayItemTap,
            null,
            null,
            key: UniqueKey(),
          ),
        ),
      );
    }

    if (items == null) return Container();

    return ListTile(
      title: Text(
        translations['select day'],
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //decoration: BoxDecoration(color: Colors.grey[400]),
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              //reverse: true,
              children: items,
            ),
          ),
          Text(translations['selected day'] + ': ' + selectedDay)
        ],
      ),
    );
  }

  _onDayItemTap(MObject mObject) async {
    MScheduleDay obj = mObject.tag;
    setState(() {
      day = obj.id;
      selectedDay = obj.name;
    });
  }

  Widget selectObject() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ListTile(
        //   title: Text(
        //     translations['select an object'],
        //     style: TextStyle(
        //       color: Theme.of(context).primaryColor,
        //     ),
        //   ),
        // ),
        selectedObjectId == -1
            ? Container(
                width: 0.0,
                height: 0.0,
              )
            : Container(height: 200, width: 200, child: imageBuilder()),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
              child: Text(translations['select an object']),
              onPressed: () async {
                await selectObjectFromImageSettings();
              },
            ),
            TextButton(
              child: Text(translations['reset']),
              onPressed: () async {
                setState(() {
                  selectedObjectId = -1;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> selectObjectFromImageSettings() async {
    Route route = MaterialPageRoute(
        builder: (context) =>
            ImageSettings(false, false, false, false, isSelectingObject: true));
    var theSelectedImage = await Navigator.push(context, route);
    if (theSelectedImage != null) {
      if (mounted) {
        setState(() {
          selectedObjectId = theSelectedImage.id;
          selectedImage = theSelectedImage;
        });
      }
    }
  }

  Widget imageBuilder() {
    if (selectedImage == null) {
      return Image.asset(
        "assets/images/ui_empty.png",
        height: 45.0,
        width: 45.0,
      );
    }

    Image localImage;
    if (selectedImage.useAsset == 0) {
      File f = File('${Helper.appDirectory}/${selectedImage.localFileName}');
      localImage = Image.file(f);
    }
    return GestureDetector(
      onTap: () async {
        await selectObjectFromImageSettings();
      },
      child: selectedImage.useAsset == 1
          ? Image.asset(
                    selectedImage.fileName,
                  ) !=
                  null
              ? Image.asset(
                  selectedImage.fileName,
                )
              : Image.asset(Helper.imageNotFound)
          : localImage == null
              ? Container()
              : FadeInImage(
                  fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  //placeholder: kTransparentImage,
                  image: localImage.image,
                ),
    );
  }

  Widget getSelectHour() {
    List<DropdownMenuItem> items = <DropdownMenuItem>[];
    for (int i = 0; i < 24; i++) {
      items.add(
        DropdownMenuItem(
          child: Text(hours[i].toString()),
          value: i,
        ),
      );
    }

    return ListTile(
      title: Text(
        translations['select hour'],
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      subtitle: Container(
        padding: EdgeInsets.only(left: 5.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            value: hour,
            isDense: true,
            onChanged: (newValue) async {
              if (mounted) {
                setState(() {
                  hour = newValue;
                });
              }
            },
            items: items,
          ),
        ),
      ),
    );
  }

  Widget getSaveItem() {
    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        // the color to return when button is in pressed, hovered, focused state
        return Colors.red;
      }
      // the color to return when button is in it's normal/unfocused state
      return Colors.green;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              ElevatedButton(style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith(getBackgroundColor),
                ),
                onPressed: () async {
                  if (day == -1) {
                    showOperationNotSuccessfull(
                        translations['please select a day']);
                    return;
                  }
                  if (selectedObjectId == -1) {
                    showOperationNotSuccessfull(
                        translations['please select an object']);
                    return;
                  }

                  MSchedule mSchedule = await MSchedule.getByHourDay(hour, day);

                  if (selectedScheduleId == -1) {
                    if (mSchedule != null) {
                      showOperationNotSuccessfull(
                          translations['existing concept']);
                      return;
                    }

                    MSchedule entity = new MSchedule();
                    entity.id = await MSchedule.maxId() ?? 1;
                    entity.objectType = 'image';
                    entity.objectId = selectedObjectId;
                    entity.hour = hour;
                    entity.day = day;
                    await MSchedule.createWithID(entity);
                  } else {
                    if (mSchedule != null &&
                        mSchedule.id != selectedScheduleId) {
                      showOperationNotSuccessfull(
                          translations['existing concept']);
                      return;
                    }

                    MSchedule entity = new MSchedule();
                    entity.id = selectedScheduleId;
                    entity.objectType = 'image';
                    entity.objectId = selectedObjectId;
                    entity.hour = hour;
                    entity.day = day;
                    await MSchedule.update(entity);
                  }

                  Navigator.pop(context);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                        child: Icon(Icons.check_circle_outline),
                      ),
                      Text(
                        translations['accept'].toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showOperationNotSuccessfull(String text) {
    if (!mounted) return;

    final snackBar = SnackBar(
      content: Text(text),
    );

    if (_scaffoldKey.currentState != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> handleBackButton() async {
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'schedule');

    if (context != null) Navigator.pop(context);
    return false;
  }
}
