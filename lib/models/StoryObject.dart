import 'dart:convert';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';

class MStoryObject {
  static const String TableName = 'storyObjects';

  int id = -1;
  int storyId = -1;
  String objectType = '';
  int objectId = -1;
  MObject mObject;

  MStoryObject({
    int id,
    int storyId,
    String objectType,
    int objectId,
  }) {
    this.id = id;
    this.storyId = storyId;
    this.objectType = objectType;
    this.objectId = objectId;
  }

  factory MStoryObject.fromMap(Map<String, dynamic> json) => new MStoryObject(
        id: json["id"],
        storyId: json["storyId"],
        objectType: json["objectType"],
        objectId: json["objectId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "storyId": storyId,
        "objectType": objectType,
        "objectId": objectId,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "storyId": storyId,
        "objectType": objectType,
        "objectId": objectId,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "storyId INTEGER,"
      "objectType TEXT,"
      "objectId INTEGER"
      ")";

  static Future<void> createTableIFNotExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery(createTableScript);
  }

  static Future<void> createWithID(MStoryObject entity) async {
    final db = await DBProvider.db.database;

    await db.rawInsert(
        "INSERT Into $TableName (id,storyId,objectType,objectId)"
        " VALUES (?,?,?,?)",
        [
          entity.id,
          entity.storyId,
          entity.objectType,
          entity.objectId,
        ]);
  }

  static Future<List<MStoryObject>> getAllObjectsInStory(int storyId) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE storyId=$storyId';

    var result = await db.rawQuery(sql);
    List<MStoryObject> list = result.isNotEmpty
        ? result.toList().map((c) => MStoryObject.fromMap(c)).toList()
        : <MStoryObject>[];

    List<MStoryObject> resultList = <MStoryObject>[];
    for (int i = 0; i < list.length; i++) {
      if (list[i].objectType == 'image') {
        MImage mImage = await MImage.getByID(list[i].objectId);
        //list[i].mObject = mImage;

        MStoryObject mStoryObject = MStoryObject();
        mStoryObject.mObject = mImage;
        mStoryObject.id = list[i].id;
        mStoryObject.objectId = list[i].objectId;
        mStoryObject.storyId = list[i].storyId;
        mStoryObject.objectType = list[i].objectType;
        resultList.add(mStoryObject);
      }
      if (list[i].objectType == 'video') {
        MVideo mVideo = await MVideo.getByID(list[i].objectId);
        //list[i].mObject = mVideo;

        MStoryObject mStoryObject = MStoryObject();
        mStoryObject.mObject = mVideo;
        mStoryObject.id = list[i].id;
        mStoryObject.objectId = list[i].objectId;
        mStoryObject.storyId = list[i].storyId;
        mStoryObject.objectType = list[i].objectType;
        resultList.add(mStoryObject);
      }
      if (list[i].objectType == 'sound') {
        MSound mSound = await MSound.getByID(list[i].objectId);
        //list[i].mObject = mSound;

        MStoryObject mStoryObject = MStoryObject();
        mStoryObject.mObject = mSound;
        mStoryObject.id = list[i].id;
        mStoryObject.objectId = list[i].objectId;
        mStoryObject.storyId = list[i].storyId;
        mStoryObject.objectType = list[i].objectType;
        resultList.add(mStoryObject);
      }
    }

    return resultList;
  }

  static Future<List<MStoryObject>> getAll() async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName ';

    var result = await db.rawQuery(sql);
    List<MStoryObject> list = result.isNotEmpty
        ? result.toList().map((c) => MStoryObject.fromMap(c)).toList()
        : <MStoryObject>[];

    List<MStoryObject> resultList = <MStoryObject>[];
    for (int i = 0; i < list.length; i++) {
      if (list[i].objectType == 'image') {
        MImage mImage = await MImage.getByID(list[i].objectId);
        //list[i].mObject = mImage;

        MStoryObject mStoryObject = MStoryObject();
        mStoryObject.mObject = mImage;
        mStoryObject.id = list[i].id;
        mStoryObject.objectId = list[i].objectId;
        mStoryObject.storyId = list[i].storyId;
        mStoryObject.objectType = list[i].objectType;
        resultList.add(mStoryObject);
      }
      if (list[i].objectType == 'video') {
        MVideo mVideo = await MVideo.getByID(list[i].objectId);
        //list[i].mObject = mVideo;

        MStoryObject mStoryObject = MStoryObject();
        mStoryObject.mObject = mVideo;
        mStoryObject.id = list[i].id;
        mStoryObject.objectId = list[i].objectId;
        mStoryObject.storyId = list[i].storyId;
        mStoryObject.objectType = list[i].objectType;
        resultList.add(mStoryObject);
      }
      if (list[i].objectType == 'sound') {
        MSound mSound = await MSound.getByID(list[i].objectId);
        //list[i].mObject = mSound;

        MStoryObject mStoryObject = MStoryObject();
        mStoryObject.mObject = mSound;
        mStoryObject.id = list[i].id;
        mStoryObject.objectId = list[i].objectId;
        mStoryObject.storyId = list[i].storyId;
        mStoryObject.objectType = list[i].objectType;
        resultList.add(mStoryObject);
      }
    }

    return resultList;
  }

  static Future<MStoryObject> getByID(int id) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE $TableName.id = $id';

    var results = await db.rawQuery(sql);

    if (results.length > 0) {
      MStoryObject result = MStoryObject.fromMap(results.first);
      return result;
    }

    return null;
  }

  static Future<void> update(MStoryObject entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap(),
        where: "id = ?", whereArgs: [entity.id]);
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");
  }

  static Future<void> delete(MStoryObject mStoryObject) async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE id=${mStoryObject.id}");
  }

  static Future<void> deleteByStoryId(int storyId) async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE storyId=$storyId");
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');
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
    List<MStoryObject> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MStoryObject list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
