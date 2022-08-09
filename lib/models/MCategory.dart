/// MCategory.dart
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/models/Language.dart';
import 'package:lucas/models/Translation.dart';

// MCategory categoryFromJson(String str) {
//   final jsonData = json.decode(str);
//   return MCategory.fromJson(jsonData);
// }

// String categoryToJson(MCategory data) {
//   final dyn = data.toJson();
//   return json.encode(dyn);
// }

class MCategory {
  static const String TableName = 'categories';

  int id; // internal ID of the category
  String backgroundColor; // background color all concepts should have
  int minColumn; // minimum grid column index where the concepts should be shown. Positive numbers start left to right, negative numbers start right to left
  int maxColumn; // maximum grid column index where the concepts should be shown. Positive numbers start left to right, negative numbers start right to left
  String textToShow;
  int minLevelToShow;

  static List<MCategory> inMemoryTable;
  static Map<int, MCategory> inMemoryDictionary;

  MCategory({
    this.id,
    this.backgroundColor,
    this.minColumn,
    this.maxColumn,
    this.textToShow,
    this.minLevelToShow,
  }) {
    if (this.textToShow == null) {
      this.textToShow = '';
    }
  }

  static populateInMemoryTables() async {
    if (inMemoryTable == null) {
      String languageCode =
          await LocalPreferences.getString('languageCode', 'en');

      final db = await DBProvider.db.database;
      String sql = 'SELECT $TableName.*, ${Translation.TableName}.textToShow '
          'FROM $TableName '
          'LEFT JOIN ${Translation.TableName} '
          'ON ${Translation.TableName}.language="$languageCode" '
          'AND ${Translation.TableName}.tableName="$TableName" '
          'AND ${Translation.TableName}.itemId=$TableName.id ';
      var result = await db.rawQuery(sql);
      List<MCategory> list = result.isNotEmpty
          ? result.toList().map((c) => MCategory.fromMap(c)).toList()
          : <MCategory>[];

      inMemoryTable = list;
      inMemoryTable.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MCategory mImage = inMemoryTable[i];
        inMemoryDictionary[mImage.id] = mImage;
      }
    }
  }

  static clearMemoryTables() {
    inMemoryTable = null;
    inMemoryDictionary = null;
  }

  factory MCategory.fromMap(Map<String, dynamic> json) => new MCategory(
        id: json["id"],
        backgroundColor: json["backgroundColor"],
        minColumn: json["minColumn"],
        maxColumn: json["maxColumn"],
        minLevelToShow: json["minLevelToShow"],
        textToShow: json["textToShow"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "backgroundColor": backgroundColor,
        "minColumn": minColumn,
        "maxColumn": maxColumn,
        "minLevelToShow": minLevelToShow,
        "textToShow": textToShow,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "backgroundColor TEXT,"
      "minColumn INTEGER,"
      "maxColumn INTEGER,"
      "minLevelToShow INTEGER"
      ")";

  static Future<void> createTableIFNotExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery(createTableScript);
  }

  static Future<void> createWithID(MCategory entity) async {
    final db = await DBProvider.db.database;

    await db.rawInsert(
        "INSERT Into $TableName (id, backgroundColor, minColumn, maxColumn, minLevelToShow)"
        " VALUES (?,?,?,?,?)",
        [
          entity.id,
          entity.backgroundColor,
          entity.minColumn,
          entity.maxColumn,
          entity.minLevelToShow
        ]);

    clearMemoryTables();
  }

  static Future<List<MCategory>> getAll({
    textToSearch = '',
  }) async {
    await populateInMemoryTables();

    if (textToSearch.isEmpty) {
      return inMemoryTable;
    } else {
      var r = inMemoryTable
          .where((f) =>
              f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
          .toList();

      r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
      return r;
    }
    // String languageCode =
    //     await LocalPreferences.getString('languageCode', 'en');

    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.*, ${Translation.TableName}.textToShow '
    //     'FROM $TableName '
    //     'LEFT JOIN ${Translation.TableName} '
    //     'ON ${Translation.TableName}.language="$languageCode" '
    //     'AND ${Translation.TableName}.tableName="${MCategory.TableName}" '
    //     'AND ${Translation.TableName}.itemId=$TableName.id ';
    // var result = await db.rawQuery(sql);
    // List<MCategory> list = result.isNotEmpty
    //     ? result.toList().map((c) => MCategory.fromMap(c)).toList()
    //     : List<MCategory>();

    // if (textToSearch.isEmpty) {
    //   var r = list;

    //   r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    //   return r;
    // } else {
    //   var r = list
    //       .where((f) =>
    //           f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
    //       .toList();

    //   r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    //   return r;
    // }
  }

  static Future<MCategory> getByID(int id) async {
    await populateInMemoryTables();

    return MCategory.inMemoryDictionary[id];
  }

  static Future<void> update(MCategory entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toMap(),
        where: "id = ?", whereArgs: [entity.id]);

    clearMemoryTables();
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");

    clearMemoryTables();
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');

    clearMemoryTables();
  }

  static Future<void> populateFromJson(bool replaceExistingInfo) async {
    String assetName = 'assets/catalogs/categories.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    await saveAssetInDatabase(replaceExistingInfo, jsonString);
  }

  static Future<void> saveAssetInDatabase(
      bool replaceExistingInfo, String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      //jsonMap.forEach((key, value) async {
      int id = int.parse(item.value["id"]);
      String backgroundColor = item.value["backgroundColor"];
      int minColumn = int.parse(item.value["minColumn"]);
      int maxColumn = int.parse(item.value["maxColumn"]);
      int minLevelToShow = int.parse(item.value["minLevelToShow"]);

      MCategory entity = MCategory(
        id: id,
        backgroundColor: backgroundColor,
        minColumn: minColumn,
        maxColumn: maxColumn,
        minLevelToShow: minLevelToShow,
      );

      //await MCategory.createWithID(category);

      batch.rawInsert(
          "INSERT Into $TableName (id,backgroundColor,minColumn,maxColumn,minLevelToShow)"
          " VALUES (?,?,?,?,?)",
          [
            entity.id,
            entity.backgroundColor,
            entity.minColumn,
            entity.maxColumn,
            entity.minLevelToShow
          ]);
      // MCategory existingMCategory = await MCategory.getByID(category.id);
      // if (replaceExistingInfo) {
      //   if (existingMCategory == null)
      //     await MCategory.create(category);
      //   else
      //     await MCategory.update(category);
      // } else {
      //   if (existingMCategory == null) {
      //     await MCategory.create(category);
      //   }
      // }
    }

    await batch.commit(noResult: true);

    // populate translations
    List<Language> languages = Language.getAll();
    for (int i = 0; i < languages.length; i++) {
      Language language = languages[i];
      await Translation.populateFromJson(replaceExistingInfo,
          MCategory.TableName, 'categories', language.languageCode);
    }
  }

  static Future<void> loadFromAssets() async {
    await Translation.createTableIFNotExists();
    await MCategory.dropTableIfExists();
    await MCategory.createTableIFNotExists();
    await Translation.deleteForTable(MCategory.TableName);
    await MCategory.deleteAll();

    await MCategory.populateFromJson(false);
  }

  static Future<int> maxId() async {
    final db = await DBProvider.db.database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int maxId = table.first["id"] ?? 1;

    return maxId;
  }
}
