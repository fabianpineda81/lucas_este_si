import 'dart:convert';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/models/MObject.dart';

import 'MEmpty.dart';
import 'MFolder.dart';
import 'MImage.dart';
import 'MScheduleDay.dart';
import 'MSound.dart';
import 'MStory.dart';
import 'MVideo.dart';

class MSchedule {
  static const String TableName = 'schedule';
  int id;
  String objectType;
  int objectId;
  int hour;
  int day;
  MObject mObject;
  static List<MSchedule> inMemoryTable;
  static Map<int, MSchedule> inMemoryDictionary;

  MSchedule({
    int id,
    String objectType = '',
    int objectId = -1,
    int hour = 8,
    int day = 1,
  }) {
    this.id = id;
    this.objectType = objectType;
    this.objectId = objectId;
    this.hour = hour;
    this.day = day;
  }

  factory MSchedule.fromMap(Map<String, dynamic> json) => new MSchedule(
        id: json["id"],
        objectType: json["objectType"],
        objectId: json["objectId"],
        hour: json["hour"],
        day: json["day"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "objectType": objectType,
        "objectId": objectId,
        "hour": hour,
        "day": day,
      };

  Map<String, dynamic> idMap() => {
        "id": id,
        "objectType": objectType,
        "objectId": objectId,
        "hour": hour,
        "day": day,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "objectType": objectType,
        "objectId": objectId,
        "hour": hour,
        "day": day,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "objectType TEXT,"
      "objectId INTEGER,"
      "hour INTEGER,"
      "day INTEGER"
      ")";

  static Future<MSchedule> getByHourDay(int hour, int day) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE $TableName.hour = $hour '
        '  AND $TableName.day = $day ';

    var results = await db.rawQuery(sql);

    if (results.length > 0) {
      MSchedule result = MSchedule.fromMap(results.first);
      return result;
    }

    return null;
  }

  static populateInMemoryTables() async {
    if (inMemoryTable == null) {
      //final db = await DBProvider.db.database;

      List<MSchedule> list = <MSchedule>[];
      List<MScheduleDay> days = await MScheduleDay.getAll();
      for (int iHour = 0; iHour < 23; iHour++) {
        List<MSchedule> listByHour = <MSchedule>[];
        bool hourHasObjects = false;
        for (int iDay = 0; iDay < days.length; iDay++) {
          MSchedule mSchedule =
              await MSchedule.getByHourDay(iHour, days[iDay].id);
          if (mSchedule == null) {
            mSchedule = new MSchedule();
            mSchedule.id = -1;
            mSchedule.objectType = 'image';
            mSchedule.objectId = -1;
            mSchedule.hour = iHour;
            mSchedule.day = days[iDay].id;
          } else {
            hourHasObjects = true;
          }
          listByHour.add(mSchedule);
        }
        if (hourHasObjects) {
          for (int i = 0; i < listByHour.length; i++) {
            list.add(listByHour[i]);
          }
        }
      }
      // String sql = 'SELECT $TableName.* '
      //     'FROM $TableName ';
      // var result = await db.rawQuery(sql);
      // List<MSchedule> list = result.isNotEmpty
      //     ? result.toList().map((c) => MSchedule.fromMap(c)).toList()
      //     : List<MSchedule>();
      // list.sort((m1, m2) {
      //   var r = m1.hour.compareTo(m2.hour);
      //   if (r != 0) return r;
      //   return m1.day.compareTo(m2.day);
      // });

      for (int i = 0; i < list.length; i++) {
        if (list[i].objectType == 'image') {
          MImage theImage = await MImage.getByID(list[i].objectId);
          if (theImage != null) {
            list[i].mObject = await theImage.clone();
          }
        }
        if (list[i].objectType == 'empty')
          list[i].mObject = await MEmpty.getByID(list[i].objectId);
        if (list[i].objectType == 'folder')
          list[i].mObject = await MFolder.getByID(list[i].objectId);
        if (list[i].objectType == 'video')
          list[i].mObject = await MVideo.getByID(list[i].objectId);
        if (list[i].objectType == 'sound')
          list[i].mObject = await MSound.getByID(list[i].objectId);
        if (list[i].objectType == 'story')
          list[i].mObject = await MStory.getByID(list[i].objectId);
      }

      for (int i = 0; i < list.length; i++) {
        if (list[i].mObject != null) list[i].mObject.tag = null;
      }

      inMemoryTable = list;
      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MSchedule mSchedule = inMemoryTable[i];
        inMemoryDictionary[mSchedule.id] = mSchedule;
      }
    }
  }

  static clearMemoryTables() {
    inMemoryTable = null;
    inMemoryDictionary = null;
  }

  static Future<void> createTableIFNotExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery(createTableScript);

    // Create days
    //await MScheduleDay.dropTableIfExists();
    await MScheduleDay.createTableIFNotExists();

    for (int i = 1; i <= 9; i++) {
      MScheduleDay entity = await MScheduleDay.getByID(i);
      if (entity == null) {
        entity = new MScheduleDay();
        entity.id = await MScheduleDay.maxId() ?? 1;
        entity.dayOrder = i;
        entity.canDelete = 0;

        if (i == 1) entity.imageId = 464; // monday
        if (i == 2) entity.imageId = 673; // tuesday
        if (i == 3) entity.imageId = 674; // wednesday
        if (i == 4) entity.imageId = 675; // thursday
        if (i == 5) entity.imageId = 676; // friday
        if (i == 6) entity.imageId = 677; // saturday
        if (i == 7) entity.imageId = 678; // sunday
        if (i == 8) entity.imageId = 889; // school
        if (i == 9) entity.imageId = 890; // home

        await MScheduleDay.createWithID(entity);
      }
    }
  }

  static Future<void> createWithID(MSchedule entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName (id,objectType,objectId,hour,day)"
        " VALUES (?,?,?,?,?)",
        [
          entity.id,
          entity.objectType,
          entity.objectId,
          entity.hour,
          entity.day,
        ]);

    clearMemoryTables();
  }

  static Future<List<MSchedule>> getAll({
    String textToSearch = '',
  }) async {
    await populateInMemoryTables();

    //if (textToSearch.isEmpty) {
    return inMemoryTable;
    // } else {
    //   var r = inMemoryTable
    //       .where((f) =>
    //           f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
    //       .toList();

    //   r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    //   return r;
    // }
  }

  static Future<MSchedule> getByID(int id) async {
    await populateInMemoryTables();

    return MSchedule.inMemoryDictionary[id];
  }

  // static Future<Map<int, MSchedule>> getSeveralByID(List<int> ids) async {
  //   Map<int, MSchedule> result = new Map();
  //   for (int id in ids) {
  //     MSchedule mSchedule = await MSchedule.getByID(id);
  //     result[id] = mSchedule;
  //   }

  //   return result;
  // }

  static Future<void> update(MSchedule entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap(),
        where: "id = ?", whereArgs: [entity.id]);

    clearMemoryTables();
  }

  // static Future<void> updateIsVisible(int id, int isVisible) async {
  //   final db = await DBProvider.db.database;
  //   await db.rawInsert('UPDATE $TableName '
  //       'SET isVisible = $isVisible '
  //       'WHERE id = $id');

  //   clearMemoryTables();
  // }

  // static Future<void> updateIsUnderstood(int id, int isUnderstood) async {
  //   final db = await DBProvider.db.database;
  //   await db.rawInsert('UPDATE $TableName '
  //       'SET isUnderstood = $isUnderstood '
  //       'WHERE id = $id');

  //   clearMemoryTables();
  // }

  // static Future<void> updateIsAvailable(int id, int isAvailable) async {
  //   final db = await DBProvider.db.database;
  //   await db.rawInsert('UPDATE $TableName '
  //       'SET isAvailable = $isAvailable '
  //       'WHERE id = $id');

  //   clearMemoryTables();
  // }

  // static Future<void> unlockAll() async {
  //   final db = await DBProvider.db.database;
  //   await db.rawInsert('UPDATE $TableName '
  //       'SET isVisible = 1 ');

  //   clearMemoryTables();
  // }

  // static Future<void> lockAll() async {
  //   final db = await DBProvider.db.database;
  //   await db.rawInsert('UPDATE $TableName '
  //       'SET isVisible = 0 ');

  //   clearMemoryTables();
  // }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");

    clearMemoryTables();
  }

  static Future<void> delete(MSchedule mobject) async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE id=${mobject.id}");

    inMemoryTable = null;
    inMemoryDictionary = null;
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');

    clearMemoryTables();
  }

  static Future<int> maxId() async {
    final db = await DBProvider.db.database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int maxId = await table.first["id"] ?? 1;

    return maxId;
  }

  Map toJson() {
    return toMap();
  }

  static Future<WebResponse> backup() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MSchedule> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MSchedule list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
