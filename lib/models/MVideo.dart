import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
//import 'package:lucas/models/Language.dart';
import 'package:lucas/models/MCategory.dart';
import 'package:lucas/models/MObject.dart';

import 'Translation.dart';

class MVideo extends MObject {
  static const String TableName = 'videos';
  String localVideoPath = '';
  //String strBase64 = ''; // base 64 of image to show to user

  static List<MVideo> inMemoryTable;
  static Map<int, MVideo> inMemoryDictionary;

  MVideo({
    int id,
    String fileName = '',
    String textToShow = '',
    String textToSay = '',
    int categoryId = -1,
    int relationId = -1,
    int isVisible = 0,
    int isUnderstood = 0,
    String backgroundColor = '',
    int minColumn = 1,
    int maxColumn = 1,
    int minLevelToShow = 1,
    int useAsset = 1,
    String localFileName = '',
    int userCreated = 1,
    String localVideoPath = '',
    int isAvailable = 1,
    String user = '',
    int remoteId = -1,
  }) {
    this.id = id;
    this.fileName = fileName;
    this.textToShow = textToShow;
    this.textToSay = textToSay;

    this.relationId = relationId;

    this.categoryId = categoryId;
    if (this.categoryId == -1) {
      this.categoryId = 17;
    }

    MCategory.getByID(this.categoryId).then((mCategory) {
      this.category = mCategory;
    });

    if (this.textToShow == null) {
      this.textToShow = '';
    }

    if (this.textToSay == null) {
      this.textToSay = '';
    }

    if (this.fileName == null) {
      this.fileName = '';
    }

    this.isVisible = isVisible;
    this.isUnderstood = isUnderstood;
    this.backgroundColor = backgroundColor ?? '';
    this.minColumn = minColumn ?? 1;
    this.maxColumn = maxColumn ?? 1;
    this.minLevelToShow = minLevelToShow ?? 1;
    this.useAsset = useAsset ?? 1;
    this.localFileName = localFileName ?? '';

    this.userCreated = userCreated ?? 1;
    this.localVideoPath = localVideoPath ?? '';
    this.isAvailable = isAvailable;
    this.user = user ?? '';
  }

  Future<MVideo> clone() async {
    // final String jsonString = json.encode(this);
    // final jsonResponse = json.decode(jsonString);

    // return MImage.fromMap(jsonResponse as Map<String, dynamic>);
    MVideo newObject = new MVideo();
    newObject.backgroundColor = this.backgroundColor;
    newObject.canShow = this.canShow;
    newObject.categoryId = this.categoryId;
    newObject.category = await MCategory.getByID(this.categoryId);
    newObject.columnToShow = this.columnToShow;
    newObject.fileName = this.fileName;
    newObject.highlighted = this.highlighted;
    newObject.id = this.id;
    newObject.isAvailable = this.isAvailable;
    newObject.isShown = this.isShown;
    newObject.isUnderstood = this.isUnderstood;
    newObject.isVisible = this.isVisible;
    newObject.localFileName = this.localFileName;
    newObject.localVideoPath = this.localVideoPath;
    newObject.maxColumn = this.maxColumn;
    newObject.minColumn = this.minColumn;
    newObject.minLevelToShow = this.minLevelToShow;
    newObject.pageToShow = this.pageToShow;
    newObject.relationId = this.relationId;
    newObject.remoteId = this.remoteId;
    newObject.tag = this.tag;
    newObject.textToSay = this.textToSay;
    newObject.textToShow = this.textToShow;
    newObject.useAsset = this.useAsset;
    newObject.user = this.user;
    newObject.userCreated = this.userCreated;

    return newObject;
  }

  factory MVideo.fromMap(Map<String, dynamic> json) => new MVideo(
        id: json["id"],
        fileName: json["fileName"],
        categoryId: json["categoryId"],
        textToShow: json["textToShow"],
        textToSay: json["textToSay"],
        relationId: json["relationId"],
        isVisible: json["isVisible"],
        isUnderstood: json["isUnderstood"],
        backgroundColor: json["backgroundColor"],
        minColumn: json["minColumn"],
        maxColumn: json["maxColumn"],
        minLevelToShow: json["minLevelToShow"],
        useAsset: json["useAsset"],
        localFileName: json["localFileName"],
        userCreated: json["userCreated"],
        localVideoPath: json["localVideoPath"],
        isAvailable: json["isAvailable"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fileName": fileName,
        "categoryId": categoryId,
        "textToShow": textToShow,
        "textToSay": textToSay,
        "relationId": relationId,
        "isVisible": isVisible,
        "isUnderstood": isUnderstood,
        "minLevelToShow": minLevelToShow,
        "useAsset": useAsset,
        "localFileName": localFileName,
        "userCreated": userCreated,
        "localVideoPath": localVideoPath,
        "isAvailable": isAvailable,
        "user": user,
        "backgroundColor": backgroundColor,
      };

  Map<String, dynamic> idMap() => {
        "id": id,
        "textToShow": textToShow,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "fileName": fileName,
        "categoryId": categoryId,
        "isVisible": isVisible,
        "isUnderstood": isUnderstood,
        "useAsset": useAsset,
        "localFileName": localFileName,
        "userCreated": userCreated,
        "localVideoPath": localVideoPath,
        "isAvailable": isAvailable,
        "backgroundColor": backgroundColor,
        "minLevelToShow": minLevelToShow,
        "user": user,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "fileName TEXT,"
      "categoryId INTEGER,"
      "isVisible INTEGER,"
      "isUnderstood INTEGER,"
      "useAsset INTEGER,"
      "localFileName TEXT,"
      "userCreated INTEGER,"
      "localVideoPath TEXT,"
      "isAvailable INTEGER,"
      "backgroundColor TEXT,"
      "minLevelToShow INTEGER,"
      "user TEXT"
      ")";

  static populateInMemoryTables() async {
    if (inMemoryTable == null) {
      String languageCode =
          await LocalPreferences.getString('languageCode', 'en');

      final db = await DBProvider.db.database;
      String sql = 'SELECT $TableName.*, '
          '${Translation.TableName}.textToShow, ${Translation.TableName}.textToSay '
          //'${MCategory.TableName}.backgroundColor, ${MCategory.TableName}.minColumn, '
          // '${MCategory.TableName}.minColumn, '
          // '${MCategory.TableName}.maxColumn '
          //'${MCategory.TableName}.maxColumn, ${MCategory.TableName}.minLevelToShow '
          'FROM $TableName '
          'LEFT JOIN ${Translation.TableName} '
          'ON ${Translation.TableName}.language="$languageCode" '
          'AND ${Translation.TableName}.tableName="${MVideo.TableName}" '
          'AND ${Translation.TableName}.itemId=$TableName.id ';
      // 'LEFT JOIN ${MCategory.TableName} '
      // 'ON ${MCategory.TableName}.id=$TableName.categoryId ';
      var result = await db.rawQuery(sql);
      List<MVideo> list = result.isNotEmpty
          ? result.toList().map((c) => MVideo.fromMap(c)).toList()
          : <MVideo>[];

      inMemoryTable = list;
      inMemoryTable.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MVideo mImage = inMemoryTable[i];
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

  static Future<void> createWithID(MVideo entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName (id,fileName,categoryId, isVisible, isUnderstood, useAsset, localFileName, userCreated, localVideoPath,isAvailable,user,backgroundColor)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          entity.id,
          entity.fileName,
          entity.categoryId,
          entity.isVisible,
          entity.isUnderstood,
          entity.useAsset,
          entity.localFileName,
          entity.userCreated,
          entity.localVideoPath,
          entity.isAvailable,
          entity.user,
          entity.backgroundColor,
        ]);

    clearMemoryTables();
  }

  static Future<List<MVideo>> getAll({
    String textToSearch = '',
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
    // String sql = 'SELECT $TableName.*, '
    //     '${Translation.TableName}.textToShow, ${Translation.TableName}.textToSay '
    //     'FROM $TableName '
    //     'INNER JOIN ${Translation.TableName} '
    //     'ON ${Translation.TableName}.language="$languageCode" '
    //     'AND ${Translation.TableName}.tableName="$TableName" '
    //     'AND ${Translation.TableName}.itemId=$TableName.id ';
    // if (textToSearch.isNotEmpty) {
    //   sql += 'AND ${Translation.TableName}.textToShow LIKE "%$textToSearch%" ';
    // }

    // var result = await db.rawQuery(sql);
    // List<MVideo> list = result.isNotEmpty
    //     ? result.toList().map((c) => MVideo.fromMap(c)).toList()
    //     : List<MVideo>();

    // var r = list;

    // r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    // return r;
  }

  static Future<List<MVideo>> getUserCreated(String user) async {
    await populateInMemoryTables();

    var r = inMemoryTable
        .where((f) => f.userCreated == 1)
        .where((f) => f.user == user)
        .toList();

    r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    return r;
    // String languageCode =
    //     await LocalPreferences.getString('languageCode', 'en');

    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.*, '
    //     '${Translation.TableName}.textToShow, ${Translation.TableName}.textToSay '
    //     'FROM $TableName '
    //     'INNER JOIN ${Translation.TableName} '
    //     'ON ${Translation.TableName}.language="$languageCode" '
    //     'AND ${Translation.TableName}.tableName="$TableName" '
    //     'AND ${Translation.TableName}.itemId=$TableName.id '
    //     'WHERE $TableName.userCreated = 1 '
    //     'AND $TableName.user="$user" ';

    // var result = await db.rawQuery(sql);
    // List<MVideo> list = result.isNotEmpty
    //     ? result.toList().map((c) => MVideo.fromMap(c)).toList()
    //     : List<MVideo>();

    // var r = list;

    // r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    // return r;
  }

  static Future<MVideo> getByID(int id) async {
    await populateInMemoryTables();

    return MVideo.inMemoryDictionary[id];
    // String languageCode =
    //     await LocalPreferences.getString('languageCode', 'en');

    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.*, '
    //     '${Translation.TableName}.textToShow, ${Translation.TableName}.textToSay, '
    //     '${MCategory.TableName}.backgroundColor, ${MCategory.TableName}.minColumn, '
    //     '${MCategory.TableName}.maxColumn, ${MCategory.TableName}.minLevelToShow '
    //     'FROM $TableName '
    //     'LEFT JOIN ${Translation.TableName} '
    //     'ON ${Translation.TableName}.language="$languageCode" '
    //     'AND ${Translation.TableName}.tableName="${MVideo.TableName}" '
    //     'AND ${Translation.TableName}.itemId=$TableName.id '
    //     'LEFT JOIN ${MCategory.TableName} '
    //     'ON ${MCategory.TableName}.id=$TableName.categoryId '
    //     'WHERE $TableName.id = $id';

    // var results = await db.rawQuery(sql);

    // if (results.length > 0) {
    //   MVideo result = MVideo.fromMap(results.first);
    //   //result.strBase64 = MObject.getStrBase64(result.useAsset, result.localFileName);

    //   return result;
    // }

    // return null;
  }

  static Future<Map<int, MVideo>> getSeveralByID(List<int> ids) async {
    Map<int, MVideo> result = new Map();
    for (int id in ids) {
      MVideo mVideo = await MVideo.getByID(id);
      result[id] = mVideo;
    }

    return result;
  }

  static Future<void> update(MVideo entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap(),
        where: "id = ?", whereArgs: [entity.id]);

    clearMemoryTables();
  }

  static Future<void> updateIsVisible(int id, int isVisible) async {
    final db = await DBProvider.db.database;
    await db.rawInsert('UPDATE $TableName '
        'SET isVisible = $isVisible '
        'WHERE id = $id');

    clearMemoryTables();
  }

  static Future<void> updateIsUnderstood(int id, int isUnderstood) async {
    final db = await DBProvider.db.database;
    await db.rawInsert('UPDATE $TableName '
        'SET isUnderstood = $isUnderstood '
        'WHERE id = $id');

    clearMemoryTables();
  }

  static Future<void> updateIsAvailable(int id, int isAvailable) async {
    final db = await DBProvider.db.database;
    await db.rawInsert('UPDATE $TableName '
        'SET isAvailable = $isAvailable '
        'WHERE id = $id');

    clearMemoryTables();
  }

  static Future<void> unlockAll() async {
    final db = await DBProvider.db.database;
    await db.rawInsert('UPDATE $TableName '
        'SET isVisible = 1 ');

    clearMemoryTables();
  }

  static Future<void> lockAll() async {
    final db = await DBProvider.db.database;
    await db.rawInsert('UPDATE $TableName '
        'SET isVisible = 0 ');

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

    clearMemoryTables();
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');

    clearMemoryTables();
  }

  static Future<void> populateFromJson(bool replaceExistingInfo) async {
    String assetName = 'assets/catalogs/videos.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    await saveAssetInDatabase(replaceExistingInfo, jsonString);
  }

  static Future<void> saveAssetInDatabase(
      bool replaceExistingInfo, String jsonString) async {
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int id = int.parse(item.value["id"]);
      int isVisible = Helper.defaultVisibility;
      int isUnderstood = 0;
      String fileName = item.value["fileName"];
      int categoryId = -1;
      if (item.value["categoryId"] == null) {
        categoryId = -1;
      } else {
        if (item.value["categoryId"].isEmpty) {
          categoryId = -1;
        } else {
          categoryId = int.parse(item.value["categoryId"]);
        }
      }
      int useAsset = 1;
      String localFileName = '';
      int userCreated = 0;
      String localVideoPath = '';
      int isAvailable = 1;
      String user = '';

      MVideo entity = MVideo(
        id: id,
        fileName: fileName,
        categoryId: categoryId,
        isVisible: isVisible,
        isUnderstood: isUnderstood,
        useAsset: useAsset,
        localFileName: localFileName,
        userCreated: userCreated,
        localVideoPath: localVideoPath,
        isAvailable: isAvailable,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,fileName,categoryId, isVisible, isUnderstood, useAsset, localFileName, userCreated, localVideoPath, isAvailable, user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.fileName,
            entity.categoryId,
            entity.isVisible,
            entity.isUnderstood,
            entity.useAsset,
            entity.localFileName,
            entity.userCreated,
            entity.localVideoPath,
            entity.isAvailable,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MVideo.TableName,
    //       'videos', language.languageCode);
    // }
  }

  static Future<void> populateFromJsonImport() async {
    String assetName = 'assets/catalogs/videos_import.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int id = int.parse(item.value["id"]);
      String fileName = item.value["fileName"];
      int isVisible = int.parse(item.value["isVisible"]);
      int isUnderstood = int.parse(item.value["isUnderstood"]);
      int useAsset = int.parse(item.value["useAsset"]);
      String localFileName = item.value["localFileName"];
      int userCreated = int.parse(item.value["userCreated"]);
      String localVideoPath = item.value["localVideoPath"];
      int isAvailable = int.parse(item.value["isAvailable"]);
      String backgroundColor = item.value["backgroundColor"];
      int minLevelToShow = int.parse(item.value["minLevelToShow"]);
      String user = '';

      MVideo entity = MVideo(
        id: id,
        fileName: fileName,
        isVisible: isVisible,
        isUnderstood: isUnderstood,
        useAsset: useAsset,
        localFileName: localFileName,
        userCreated: userCreated,
        localVideoPath: localVideoPath,
        isAvailable: isAvailable,
        backgroundColor: backgroundColor,
        minLevelToShow: minLevelToShow,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,fileName,isVisible,isUnderstood,useAsset,localFileName,userCreated,localVideoPath,isAvailable,backgroundColor,minLevelToShow,user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.fileName,
            entity.isVisible,
            entity.isUnderstood,
            entity.useAsset,
            entity.localFileName,
            entity.userCreated,
            entity.localVideoPath,
            entity.isAvailable,
            entity.backgroundColor,
            entity.minLevelToShow,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);
  }

  static Future<void> loadFromAssets() async {
    //await Translation.createTableIFNotExists();
    await MVideo.createTableIFNotExists();
    // await Translation.deleteForTable(MVideo.TableName);
    await MVideo.deleteAll();

    //await MVideo.populateFromJson(false);
    await MVideo.populateFromJsonImport();
  }

  static Future<int> maxId() async {
    final db = await DBProvider.db.database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int maxId = await table.first["id"] ?? 1;

    return maxId;
  }

  static updateBackgroundColor() async {
    List<MVideo> objects = await getAll();
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].backgroundColor == "") {
        MCategory mCategory = await MCategory.getByID(objects[i].categoryId);
        if (mCategory != null) {
          objects[i].backgroundColor = mCategory.backgroundColor;
          objects[i].minLevelToShow = mCategory.minLevelToShow;
          await MVideo.update(objects[i]);
        }
      }
    }
  }

  Map toJson() {
    return toMap();
  }

  static Future<WebResponse> backup() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MVideo> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MVideo list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }

  static Future<WebResponse> backupUserCreatedObjects() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MVideo> objects = await getAll();

    WebResponse webResponse = WebResponse(message: "", operation: true);
    for (int i = 0; i < objects.length; i++) {
      MVideo obj = objects[i];
      //if (obj.userCreated == 1 && obj.useAsset == 0) {
      if (obj.useAsset == 0) {
        File f = File('${Helper.appDirectory}/${obj.localFileName}');
        //Image.file(f);
        final bytes = await f.readAsBytes();
        if (bytes != null) {
          String base64 = Base64Encoder().convert(bytes);

          String json = jsonEncode({
            "email": strUserEmail,
            "name": strUserName,
            "operation": "upload asset",
            "objectType": 'image',
            "fileName": obj.localFileName,
            "id": obj.id,
            "propertyName": 'localFileName',
            "base64": base64,
          });
          webResponse = await Helper.invokeWebService(json);
          if (!webResponse.operation) {
            return webResponse;
          }
        }
      }
    }

    webResponse = WebResponse(message: "", operation: true);
    return webResponse;
  }

  static Future<WebResponse> backupUserCreatedObjectsContent() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MVideo> objects = await getAll();

    WebResponse webResponse = WebResponse(message: "", operation: true);
    for (int i = 0; i < objects.length; i++) {
      MVideo obj = objects[i];
      //if (obj.userCreated == 1 && obj.useAsset == 0) {
      if (obj.localVideoPath.length > 0) {
        File f = File('${Helper.appDirectory}/${obj.localVideoPath}');
        //Image.file(f);
        final bytes = await f.readAsBytes();
        if (bytes != null) {
          String base64 = Base64Encoder().convert(bytes);

          String json = jsonEncode({
            "email": strUserEmail,
            "name": strUserName,
            "operation": "upload asset",
            "objectType": 'image',
            "fileName": obj.localVideoPath,
            "id": obj.id,
            "propertyName": 'localVideoPath',
            "base64": base64,
          });
          webResponse = await Helper.invokeWebService(json);
          if (!webResponse.operation) {
            return webResponse;
          }
        }
      }
    }

    webResponse = WebResponse(message: "", operation: true);
    return webResponse;
  }
}
