import 'dart:convert';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';

import 'MObject.dart';

class MStory extends MObject {
  static const String TableName = 'stories';

  int id = -1;
  String storyName = '';

  MStory({
    int id,
    String storyName = '',
  }) {
    this.id = id;
    this.storyName = storyName;
  }

  factory MStory.fromMap(Map<String, dynamic> json) => new MStory(
        id: json["id"],
        storyName: json["storyName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "storyName": storyName,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "storyName": storyName,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "storyName TEXT"
      ")";

  static Future<void> createTableIFNotExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery(createTableScript);
  }

  static Future<void> createWithID(MStory entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName (id,storyName)"
        " VALUES (?,?)",
        [
          entity.id,
          entity.storyName,
        ]);
  }

  static Future<List<MStory>> getAll(bool orderById) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName ';
    if (orderById)
      sql += 'ORDER BY id';
    else
      sql += 'ORDER BY storyName';

    var result = await db.rawQuery(sql);
    List<MStory> list = result.isNotEmpty
        ? result.toList().map((c) => MStory.fromMap(c)).toList()
        : <MStory>[];

    return list;
  }

  static Future<MStory> getByID(int id) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE $TableName.id = $id';

    var results = await db.rawQuery(sql);

    if (results.length > 0) {
      MStory result = MStory.fromMap(results.first);
      return result;
    }

    return null;
  }

  static Future<void> update(MStory entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap(),
        where: "id = ?", whereArgs: [entity.id]);
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");
  }

  static Future<void> delete(MStory mStory) async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE id=${mStory.id}");
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
    List<MStory> objects = await getAll(true);

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MStory list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
