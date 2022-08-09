import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/models/MObject.dart';

class MEmpty extends MObject {
  static const String TableName = 'empties';

  static List<MEmpty> inMemoryTable;
  static Map<int, MEmpty> inMemoryDictionary;

  MEmpty({
    int id,
    int relationId = -1,
    String backgroundColor = '',
    int userCreated = 1,
    String user = '',
    int remoteId = -1,
  }) {
    this.id = id;
    this.relationId = relationId;
    this.backgroundColor = backgroundColor ?? '';
    this.userCreated = userCreated ?? 1;
    this.user = user ?? '';
    this.remoteId = remoteId;
  }

  Future<MEmpty> clone() async {
    MEmpty newObject = new MEmpty();
    newObject.backgroundColor = this.backgroundColor;
    newObject.userCreated = this.userCreated;
    newObject.user = this.user;
    newObject.remoteId = this.remoteId;

    return newObject;
  }

  factory MEmpty.fromMap(Map<String, dynamic> json) => new MEmpty(
        id: json["id"],
        relationId: json["relationId"],
        backgroundColor: json["backgroundColor"],
        userCreated: json["userCreated"],
        user: json["user"],
        remoteId: json["remoteId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "relationId": relationId,
        "backgroundColor": backgroundColor,
        "userCreated": userCreated,
        "user": user,
        "remoteId": remoteId,
      };

  // Map<String, dynamic> idMap() => {
  //       "id": id,
  //       "textToShow": textToShow,
  //     };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "backgroundColor": backgroundColor,
        "userCreated": userCreated,
        "user": user,
        "remoteId": remoteId,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "backgroundColor TEXT,"
      "userCreated INTEGER,"
      "user TEXT,"
      "remoteId INTEGER"
      ")";

  static populateInMemoryTables() async {
    if (inMemoryTable == null) {
      final db = await DBProvider.db.database;
      String sql = 'SELECT $TableName.* '
          'FROM $TableName ';
      var result = await db.rawQuery(sql);
      List<MEmpty> list = result.isNotEmpty
          ? result.toList().map((c) => MEmpty.fromMap(c)).toList()
          : <MEmpty>[];

      inMemoryTable = list;
      inMemoryTable.sort((i1, i2) => i1.id.compareTo(i2.id));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MEmpty mImage = inMemoryTable[i];
        inMemoryDictionary[mImage.id] = mImage;
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
  }

  static Future<void> createWithID(MEmpty entity) async {
    final db = await DBProvider.db.database;

    await db.rawInsert(
        "INSERT Into $TableName (id,backgroundColor,userCreated,user,remoteId)"
        " VALUES (?,?,?,?,?)",
        [
          entity.id,
          entity.backgroundColor,
          entity.userCreated,
          entity.user,
          entity.remoteId,
        ]);

    clearMemoryTables();
  }

  static Future<List<MEmpty>> getAll({
    String textToSearch = '',
  }) async {
    await populateInMemoryTables();

    if (textToSearch.isEmpty) {
      return inMemoryTable;
    } else {
      var r = inMemoryTable
          // .where((f) =>
          //     f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
          .toList();

      r.sort((i1, i2) => i1.id.compareTo(i2.id));
      return r;
    }
  }

  static Future<List<MEmpty>> getUserCreated(String user) async {
    await populateInMemoryTables();

    var r = inMemoryTable
        .where((f) => f.userCreated == 1)
        .where((f) => f.user == user)
        .toList();

    r.sort((i1, i2) => i1.id.compareTo(i2.id));
    return r;
  }

  static Future<MEmpty> getByID(int id) async {
    await populateInMemoryTables();

    return MEmpty.inMemoryDictionary[id];
  }

  static Future<Map<int, MEmpty>> getSeveralByID(List<int> ids) async {
    Map<int, MEmpty> result = new Map();
    for (int id in ids) {
      MEmpty mImage = await MEmpty.getByID(id);
      result[id] = mImage;
    }

    return result;
  }

  static Future<void> update(MEmpty entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap(),
        where: "id = ?", whereArgs: [entity.id]);

    clearMemoryTables();
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");

    clearMemoryTables();
  }

  static Future<void> delete(MObject mobject) async {
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

  static Future<void> populateFromJson(bool replaceExistingInfo) async {
    // String assetName = 'assets/catalogs/empties.json';

    // String jsonString = await Helper.loadStringAsset(assetName);
    // await saveAssetInDatabase(replaceExistingInfo, jsonString);
  }

  static Future<void> saveAssetInDatabase(
      bool replaceExistingInfo, String jsonString) async {
    // Map<String, dynamic> jsonMap = json.decode(jsonString);

    // final db = await DBProvider.db.database;
    // Batch batch = db.batch();

    // for (MapEntry<String, dynamic> item in jsonMap.entries) {
    //   int id = int.parse(item.value["id"]);
    //   int isVisible = Helper.defaultVisibility;
    //   int isUnderstood = 0;
    //   String fileName = item.value["fileName"];
    //   int categoryId = -1;
    //   if (item.value["categoryId"] == null) {
    //     categoryId = -1;
    //   } else {
    //     if (item.value["categoryId"].isEmpty) {
    //       categoryId = -1;
    //     } else {
    //       categoryId = int.parse(item.value["categoryId"]);
    //     }
    //   }
    //   int useAsset = 1;
    //   String localFileName = '';
    //   int userCreated = 0;
    //   int isAvailable = 1;
    //   String user = '';

    //   MEmpty entity = MEmpty(
    //     id: id,
    //     fileName: fileName,
    //     categoryId: categoryId,
    //     isVisible: isVisible,
    //     isUnderstood: isUnderstood,
    //     useAsset: useAsset,
    //     localFileName: localFileName,
    //     userCreated: userCreated,
    //     isAvailable: isAvailable,
    //     user: user,
    //   );

    //   batch.rawInsert(
    //       "INSERT Into $TableName (id,fileName,categoryId, isVisible, isUnderstood, useAsset, localFileName, userCreated, isAvailable, user) "
    //       "VALUES (?,?,?,?,?,?,?,?,?,?)",
    //       [
    //         entity.id,
    //         entity.fileName,
    //         entity.categoryId,
    //         entity.isVisible,
    //         entity.isUnderstood,
    //         entity.useAsset,
    //         entity.localFileName,
    //         entity.userCreated,
    //         entity.isAvailable,
    //         entity.user,
    //       ]);
    // }

    // await batch.commit(noResult: true);

    // // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MEmpty.TableName,
    //       'images', language.languageCode);
    // }
  }

  static Future<void> populateFromJsonImport() async {
    String assetName = 'assets/catalogs/empties_import.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int id = int.parse(item.value["id"]);
      int userCreated = int.parse(item.value["userCreated"]);
      String backgroundColor = item.value["backgroundColor"];
      String user = '';

      MEmpty entity = MEmpty(
        id: id,
        userCreated: userCreated,
        backgroundColor: backgroundColor,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,userCreated,backgroundColor,user) "
          "VALUES (?,?,?,?)",
          [
            entity.id,
            entity.userCreated,
            entity.backgroundColor,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MEmpty.TableName,
    //       'images', language.languageCode);
    // }
  }

  // static MEmpty notFoundCard() {
  //   return MEmpty(
  //     id: -1,
  //     fileName: Helper.imageNotFound,
  //     // parentFolder: ['Not found'],
  //     // hexBackgroundColor: '#e1bee7',
  //   );
  // }

  static Future<void> loadFromAssets() async {
    //await Translation.createTableIFNotExists();
    await MEmpty.createTableIFNotExists();
    await MEmpty.deleteAll();

    //await MEmpty.populateFromJson(false);
    await MEmpty.populateFromJsonImport();
  }

  static Future<int> maxId() async {
    final db = await DBProvider.db.database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int maxId = table.first["id"] ?? 1;

    return maxId;
  }

  Map toJson() {
    return toBDMap();
  }

  static Future<WebResponse> backup() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MEmpty> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MEmpty list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
