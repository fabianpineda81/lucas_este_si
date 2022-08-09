import 'dart:convert';
import 'dart:io';
import 'dart:math';
//import 'dart:ui';
//import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
//import 'package:lucas/models/Language.dart';
import 'package:lucas/models/MCategory.dart';
import 'package:lucas/models/MObject.dart';

import 'Translation.dart';

class MImage extends MObject {
  static const String TableName = 'images';
  int minLevelToShow = 1; // min level for which the category will be shown
  String strBase64 = ''; // base 64 of image to show to user

  static List<MImage> inMemoryTable;
  static Map<int, MImage> inMemoryDictionary;

  MImage({
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
      this.fileName = 'assets/images/ui_empty.png';
    }

    if (this.fileName.isEmpty) {
      this.fileName = 'assets/images/ui_empty.png';
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
    this.isAvailable = isAvailable;
    this.user = user ?? '';
  }

  Future<MImage> clone() async {
    // final String jsonString = json.encode(this);
    // final jsonResponse = json.decode(jsonString);

    // return MImage.fromMap(jsonResponse as Map<String, dynamic>);
    MImage newObject = new MImage();
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
    newObject.maxColumn = this.maxColumn;
    newObject.minColumn = this.minColumn;
    newObject.minLevelToShow = this.minLevelToShow;
    newObject.pageToShow = this.pageToShow;
    newObject.relationId = this.relationId;
    newObject.remoteId = this.remoteId;
    newObject.strBase64 = this.strBase64;
    newObject.tag = this.tag;
    newObject.textToSay = this.textToSay;
    newObject.textToShow = this.textToShow;
    newObject.useAsset = this.useAsset;
    newObject.user = this.user;
    newObject.userCreated = this.userCreated;

    return newObject;
  }

  factory MImage.fromMap(Map<String, dynamic> json) => new MImage(
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
        "isAvailable": isAvailable,
        "user": user,
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
          'AND ${Translation.TableName}.tableName="${MImage.TableName}" '
          'AND ${Translation.TableName}.itemId=$TableName.id ';
      // 'LEFT JOIN ${MCategory.TableName} '
      // 'ON ${MCategory.TableName}.id=$TableName.categoryId ';
      var result = await db.rawQuery(sql);
      List<MImage> list = result.isNotEmpty
          ? result.toList().map((c) => MImage.fromMap(c)).toList()
          : <MImage>[];

      inMemoryTable = list;
      //inMemoryTable.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
      inMemoryTable.sort((i1, i2) => i1.id.compareTo(i2.id));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MImage mImage = inMemoryTable[i];
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

  static Future<void> createWithID(MImage entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName (id,fileName,categoryId, isVisible, isUnderstood, useAsset, localFileName, userCreated,isAvailable,user,backgroundColor)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [
          entity.id,
          entity.fileName,
          entity.categoryId,
          entity.isVisible,
          entity.isUnderstood,
          entity.useAsset,
          entity.localFileName,
          entity.userCreated,
          entity.isAvailable,
          entity.user,
          entity.backgroundColor,
        ]);

    clearMemoryTables();
  }

  static Future<List<MImage>> getAll({
    String textToSearch = '',
  }) async {
    await populateInMemoryTables();

    if (textToSearch.isEmpty) {
      return inMemoryTable;
    } else {
      var r = inMemoryTable
          .where((f) =>
              //f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
              f.textToShow.toLowerCase().contains(textToSearch.toLowerCase()))
          .toList();

      r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
      return r;
    }
  }

  static Future<List<MImage>> getUserCreated(String user) async {
    await populateInMemoryTables();

    var r = inMemoryTable
        .where((f) => f.userCreated == 1)
        .where((f) => f.user == user)
        .toList();

    r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    return r;
  }

  static Future<MImage> getByID(int id) async {
    await populateInMemoryTables();

    return MImage.inMemoryDictionary[id];
  }

  static Future<Map<int, MImage>> getSeveralByID(List<int> ids) async {
    Map<int, MImage> result = new Map();
    for (int id in ids) {
      MImage mImage = await MImage.getByID(id);
      result[id] = mImage;
    }

    return result;
  }

  static Future<void> update(MImage entity) async {
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

    inMemoryTable = null;
    inMemoryDictionary = null;
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');

    clearMemoryTables();
  }

  static Future<void> populateFromJson(bool replaceExistingInfo) async {
    String assetName = 'assets/catalogs/images.json';

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
      int isAvailable = 1;
      String user = '';

      MImage entity = MImage(
        id: id,
        fileName: fileName,
        categoryId: categoryId,
        isVisible: isVisible,
        isUnderstood: isUnderstood,
        useAsset: useAsset,
        localFileName: localFileName,
        userCreated: userCreated,
        isAvailable: isAvailable,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,fileName,categoryId, isVisible, isUnderstood, useAsset, localFileName, userCreated, isAvailable, user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.fileName,
            entity.categoryId,
            entity.isVisible,
            entity.isUnderstood,
            entity.useAsset,
            entity.localFileName,
            entity.userCreated,
            entity.isAvailable,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MImage.TableName,
    //       'images', language.languageCode);
    // }
  }

  static Future<void> populateFromJsonImport() async {
    String assetName = 'assets/catalogs/images_import.json';

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
      int isAvailable = int.parse(item.value["isAvailable"]);
      String backgroundColor = item.value["backgroundColor"];
      int minLevelToShow = int.parse(item.value["minLevelToShow"]);
      String user = '';

      MImage entity = MImage(
        id: id,
        fileName: fileName,
        isVisible: isVisible,
        isUnderstood: isUnderstood,
        useAsset: useAsset,
        localFileName: localFileName,
        userCreated: userCreated,
        isAvailable: isAvailable,
        backgroundColor: backgroundColor,
        minLevelToShow: minLevelToShow,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,fileName,isVisible,isUnderstood,useAsset,localFileName,userCreated,isAvailable,backgroundColor,minLevelToShow,user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.fileName,
            entity.isVisible,
            entity.isUnderstood,
            entity.useAsset,
            entity.localFileName,
            entity.userCreated,
            entity.isAvailable,
            entity.backgroundColor,
            entity.minLevelToShow,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MImage.TableName,
    //       'images', language.languageCode);
    // }
  }

  static MImage notFoundCard() {
    return MImage(
      id: -1,
      fileName: Helper.imageNotFound,
      // parentFolder: ['Not found'],
      // hexBackgroundColor: '#e1bee7',
    );
  }

  static Future<void> loadFromAssets() async {
    //await Translation.createTableIFNotExists();
    await MImage.createTableIFNotExists();

    //await Translation.deleteForTable(MImage.TableName);
    await MImage.deleteAll();

    //await MImage.populateFromJson(false);
    await MImage.populateFromJsonImport();
  }

  static Future<int> maxId() async {
    // final db = await DBProvider.db.database;

    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    // int maxId = table.first["id"] ?? 1;
    int i = UniqueKey().hashCode;
    if(i<30000){
      Random random = new Random();
      int randomNumber = random.nextInt(9999)+30000;
      i+=randomNumber;
    }
    return i;
    // return maxId;
  }

  static updateBackgroundColor() async {
    List<MImage> objects = await getAll();
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].backgroundColor == "") {
        MCategory mCategory = await MCategory.getByID(objects[i].categoryId);
        if (mCategory != null) {
          objects[i].backgroundColor = mCategory.backgroundColor;
          objects[i].minLevelToShow = mCategory.minLevelToShow;
          await MImage.update(objects[i]);
        }
      }
    }
  }

  Map toJson() {
    return toBDMap();
  }

  static Future<WebResponse> backup() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MImage> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MImage list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }

  static Future<WebResponse> backupUserCreatedObjects() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MImage> objects = await getAll();

    WebResponse webResponse = WebResponse(message: "", operation: true);
    for (int i = 0; i < objects.length; i++) {
      MImage obj = objects[i];
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

  factory MImage.jsonToImage(Map<String, dynamic> json) => MImage(
    id: json["idInDevice"],
    fileName: json["fileName"],
    categoryId: json["categoryId"]??-1,
    textToShow: json["textToShow"]??'',
    textToSay: json["textToSay"]??'',
    relationId: json["relationId"]??-1,
    isVisible: json["isVisible"],
    isUnderstood: json["isUnderstood"],
    backgroundColor: json["backgroundColor"],
    minColumn: json["minColumn"]??1,
    maxColumn: json["maxColumn"]??1,
    minLevelToShow: json["minLevelToShow"]??1,
    useAsset: json["useAsset"]??1,
    localFileName: json["localFileName"],
    userCreated: json["userCreated"]??1,
    isAvailable: json["isAvailable"]??1,
    user: json["user"]??''
        '',
  );

}
