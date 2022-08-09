/// Translation.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';

// import 'Language.dart';
// import 'MEmpty.dart';
// import 'MFolder.dart';
// import 'MImage.dart';
// import 'MSound.dart';
// import 'MVideo.dart';

// Translation translationFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Translation.fromJson(jsonData);
// }

// String translationToJson(Translation data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }

class Translation {
  static const String TableName = 'translations';

  int id; // internal ID of the translation
  String tableName;
  int itemId;
  String language;
  String textToShow;
  String textToSay;
  String user;

  Translation({
    this.id,
    this.tableName,
    this.itemId,
    this.language,
    this.textToShow,
    this.textToSay,
    this.user,
  }) {
    if (this.textToShow == null) {
      this.textToShow = '';
    }
    if (this.user == null) {
      this.user = '';
    }
    if (this.textToSay == null) {
      this.textToSay = '';
    }
  }

  factory Translation.fromMap(Map<String, dynamic> json) => new Translation(
        id: json["id"],
        tableName: json["tableName"],
        itemId: json["itemId"],
        language: json["language"],
        textToShow: json["textToShow"],
        textToSay: json["textToSay"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tableName": tableName,
        "itemId": itemId,
        "language": language,
        "textToShow": textToShow,
        "textToSay": textToSay,
        "user": user,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "tableName TEXT,"
      "itemId INTEGER,"
      "language TEXT,"
      "textToShow TEXT,"
      "textToSay TEXT,"
      "user TEXT"
      ")";

  static Future<void> createTableIFNotExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery(createTableScript);
  }

  static Future<void> createWithID(Translation entity) async {
    final db = await DBProvider.db.database;
    await db.insert("$TableName", entity.toMap());
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;
  }

  static Future<void> create(Translation entity) async {
    final db = await DBProvider.db.database;

    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int id = await table.first["id"] ?? 1;

    //insert translation using the new id
    await db.rawInsert(
        "INSERT Into $TableName (id,tableName,itemId,language,textToShow,textToSay)"
        " VALUES (?,?,?,?,?,?)",
        [
          id,
          entity.tableName,
          entity.itemId,
          entity.language,
          entity.textToShow,
          entity.textToSay
        ]);
  }

  static Future<bool> exists(Translation entity) async {
    final db = await DBProvider.db.database;

    String sql = 'SELECT * FROM $TableName WHERE '
        'tableName = "${entity.tableName}" '
        'AND itemId = ${entity.itemId} '
        'AND language = "${entity.language}"';

    var results = await db.rawQuery(sql);

    if (results.length > 0) {
      return true;
    }

    return false;
  }

  static Future<Translation> getByID(int id) async {
    final db = await DBProvider.db.database;
    var results = await db.rawQuery('SELECT * FROM $TableName WHERE id = $id');

    if (results.length > 0) {
      return new Translation.fromMap(results.first);
    }

    return null;
  }

  static Future<Translation> getLocalized(
      String tableName, int itemId, String language) async {
    final db = await DBProvider.db.database;
    var results = await db.rawQuery('SELECT * FROM $TableName WHERE '
        'tableName = "$tableName" '
        'AND itemId = $itemId '
        'AND language = "$language"');

    if (results.length > 0) {
      return new Translation.fromMap(results.first);
    }

    return null;
  }

  static Future<List<Translation>> getAllTranslationsOfObject(
      String tableName, int itemId) async {
    final db = await DBProvider.db.database;

    var result = await db.rawQuery('SELECT * FROM $TableName WHERE '
        'tableName = "$tableName" '
        'AND itemId = $itemId ');
    List<Translation> list = result.isNotEmpty
        ? result.toList().map((c) => Translation.fromMap(c)).toList()
        : <Translation>[];
    return list;
  }

  static Future<List<Translation>> getAll() async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName ';
    var result = await db.rawQuery(sql);
    List<Translation> list = result.isNotEmpty
        ? result.toList().map((c) => Translation.fromMap(c)).toList()
        : <Translation>[];

    //if (textToSearch.isEmpty) {
    var r = list;

    r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    return r;
    // } else {
    //   var r = list
    //       .where((f) =>
    //           f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
    //       .toList();

    //   r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    //   return r;
    // }
  }

  static Future<void> update(Translation entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toMap(),
        where: "id = ?", whereArgs: [entity.id]);
    // var result = await db.update("$TableName", entity.toMap(),
    //     where: "id = ?", whereArgs: [entity.id]);
    // return result;
  }

  static Future<void> deleteForTable(String tableName) async {
    final db = await DBProvider.db.database;
    String sql = 'DELETE FROM $TableName WHERE tableName="$tableName"';
    await db.rawQuery(sql);
  }

  static Future<void> deleteForObject(String tableName, int itemId) async {
    final db = await DBProvider.db.database;
    String sql = 'DELETE FROM $TableName WHERE '
        'tableName = "$tableName" '
        'AND itemId = $itemId ';
    await db.rawQuery(sql);
  }

  static Future<void> deleteById(int id) async {
    final db = await DBProvider.db.database;
    String sql = 'DELETE FROM $TableName WHERE '
        'id = $id ';
    await db.rawQuery(sql);
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');
  }

  static Future<void> populateFromJson(bool replaceExistingInfo,
      String tableName, String fileName, String languageCode) async {
    String assetName = 'assets/lang/${fileName}_$languageCode.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    await saveAssetInDatabase(
        replaceExistingInfo, tableName, languageCode, jsonString);
  }

  static Future<void> saveAssetInDatabase(bool replaceExistingInfo,
      String tableName, String languageCode, String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int maxId = await table.first["id"] ?? 1;

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int itemId = int.parse(item.key);
      String textToShow = item.value;
      String textToSay = item.value;
      // String textToShow = item.value["textToShow"];
      // String textToSay = item.value["textToSay"];

      Translation entity = Translation(
        tableName: tableName,
        itemId: itemId,
        language: languageCode,
        textToShow: textToShow,
        textToSay: textToSay,
      );

      //await Translation.create(entity);

      //insert translation using the new id
      batch.rawInsert(
          "INSERT Into $TableName (id,tableName,itemId,language,textToShow,textToSay)"
          " VALUES (?,?,?,?,?,?)",
          [
            maxId,
            entity.tableName,
            entity.itemId,
            entity.language,
            entity.textToShow,
            entity.textToSay
          ]);

      maxId++;

      // bool exists = await Translation.exists(entity);
      // if (replaceExistingInfo) {
      //   if (exists)
      //     await Translation.update(entity);
      //   else
      //     await Translation.create(entity);
      // } else {
      //   if (!exists) {
      //     await Translation.create(entity);
      //   }
      // }
    }

    await batch.commit(noResult: true);
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");

    //clearMemoryTables();
  }

  static Future<void> loadFromAssets() async {
    await Translation.createTableIFNotExists();
    //await Translation.deleteForTable(MSound.TableName);
    await Translation.deleteAll();

    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   //await Translation.populateFromJson(false, MEmpty.TableName,'empties', language.languageCode);
    //   await Translation.populateFromJson(false, MFolder.TableName,'folders', language.languageCode);
    //   await Translation.populateFromJson(false, MImage.TableName,'images', language.languageCode);
    //   await Translation.populateFromJson(false, MSound.TableName,'sounds', language.languageCode);
    //   await Translation.populateFromJson(false, MVideo.TableName,'videos', language.languageCode);
    // }

    await Translation.populateFromJsonImport();
  }

  static Future<void> populateFromJsonImport() async {
    String assetName = 'assets/catalogs/translations_import.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int id = int.parse(item.value["id"]);
      String tableName = item.value["tableName"];
      int itemId = int.parse(item.value["itemId"]);
      String language = item.value["language"];
      String textToShow = item.value["textToShow"];
      String textToSay = item.value["textToSay"];
      String user = '';

      Translation entity = Translation(
        id: id,
        tableName: tableName,
        itemId: itemId,
        language: language,
        textToShow: textToShow,
        textToSay: textToSay,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,tableName,itemId,language,textToShow,textToSay,user) "
          "VALUES (?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.tableName,
            entity.itemId,
            entity.language,
            entity.textToShow,
            entity.textToSay,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);
  }

  static Future<int> maxId() async {
    // final db = await DBProvider.db.database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    // int maxId = await table.first["id"] ?? 1;
    int i = UniqueKey().hashCode;
    if (i < 30000) {
      Random random = new Random();
      int randomNumber = random.nextInt(9999) + 30000;
      i += randomNumber;
    }
    // return maxId;
    return i;
  }

  Map toJson() {
    return toMap();
  }

  static Future<WebResponse> backup() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<Translation> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload Translation list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
