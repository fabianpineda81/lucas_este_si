import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
//import 'package:lucas/models/Language.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/Translation.dart';

import 'MCategory.dart';

class MFolder extends MObject {
  static const String TableName = 'folders';

  //static List<MFolder> folders = List<MFolder>();

  static List<MFolder> inMemoryTable;
  static Map<int, MFolder> inMemoryDictionary;

  int parentFolderId;

  MFolder({
    int id = -1,
    String fileName = '',
    String textToShow = '',
    String textToSay = '',
    int parentFolderId = -1,
    int categoryId = -1,
    int relationId = -1,
    int isVisible = 0,
    int isUnderstood = 0,
    String backgroundColor = '',
    int minColumn = 1,
    int maxColumn = 1,
    int minLevelToShow = 1,
    int userCreated = 1,
    int isAvailable = 1,
    int useAsset = 1,
    String localFileName = '',
    String user = '',
    int remoteId = -1,
  }) {
    this.id = id;
    this.fileName = fileName;
    this.textToShow = textToShow;
    this.textToSay = textToSay;
    this.parentFolderId = parentFolderId;
    this.categoryId = categoryId;
    this.isUnderstood = isUnderstood;

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
      this.fileName = 'assets/images/folders_folder.png';
    }

    if (this.fileName.isEmpty) {
      this.fileName = 'assets/images/folders_folder.png';
    }

    this.isVisible = isVisible;
    this.backgroundColor = backgroundColor ?? '';
    this.minColumn = minColumn ?? 1;
    this.maxColumn = maxColumn ?? 1;
    this.minLevelToShow = minLevelToShow ?? 1;

    this.userCreated = userCreated ?? 1;
    this.isAvailable = isAvailable;

    this.useAsset = useAsset ?? 1;
    this.localFileName = localFileName ?? '';
    this.user = user ?? '';
  }

  Future<MFolder> clone() async {
    // final String jsonString = json.encode(this);
    // final jsonResponse = json.decode(jsonString);

    // return MImage.fromMap(jsonResponse as Map<String, dynamic>);
    MFolder newObject = new MFolder();
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
    newObject.tag = this.tag;
    newObject.textToSay = this.textToSay;
    newObject.textToShow = this.textToShow;
    newObject.useAsset = this.useAsset;
    newObject.user = this.user;
    newObject.userCreated = this.userCreated;

    return newObject;
  }

  factory MFolder.fromMap(Map<String, dynamic> json) => new MFolder(
        id: json["id"],
        parentFolderId: json["parentFolderId"],
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
        userCreated: json["userCreated"],
        isAvailable: json["isAvailable"],
        useAsset: json["useAsset"],
        localFileName: json["localFileName"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "parentFolderId": parentFolderId,
        "fileName": fileName,
        "categoryId": categoryId,
        "textToShow": textToShow,
        "textToSay": textToSay,
        "relationId": relationId,
        "isVisible": isVisible,
        "isUnderstood": isUnderstood,
        "minLevelToShow": minLevelToShow,
        "userCreated": userCreated,
        "isAvailable": isAvailable,
        "useAsset": useAsset,
        "localFileName": localFileName,
        "user": user,
      };

  Map<String, dynamic> idMap() => {
        "id": id,
        "textToShow": textToShow,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "parentFolderId": parentFolderId,
        "fileName": fileName,
        "categoryId": categoryId,
        "isVisible": isVisible,
        "isUnderstood": isUnderstood,
        "userCreated": userCreated,
        "isAvailable": isAvailable,
        "useAsset": useAsset,
        "localFileName": localFileName,
        "backgroundColor": backgroundColor,
        "minLevelToShow": minLevelToShow,
        "user": user,
      };

  Map<String, dynamic> toBDMap2() => {
    "id": id,
    "fileName": fileName,
    "categoryId": categoryId,
    "isVisible": isVisible,
    "isUnderstood": isUnderstood,
    "userCreated": userCreated,
    "isAvailable": isAvailable,
    "useAsset": useAsset,
    "localFileName": localFileName,
    "backgroundColor": backgroundColor,
    "minLevelToShow": minLevelToShow,
    "user": user,
  };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "parentFolderId INTEGER,"
      "fileName TEXT,"
      "categoryId INTEGER,"
      "isVisible INTEGER,"
      "isUnderstood INTEGER,"
      "userCreated INTEGER,"
      "isAvailable INTEGER,"
      "useAsset INTEGER,"
      "localFileName TEXT,"
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
          'AND ${Translation.TableName}.tableName="${MFolder.TableName}" '
          'AND ${Translation.TableName}.itemId=$TableName.id '
          'ORDER BY ${Translation.TableName}.textToShow';
      // 'LEFT JOIN ${MCategory.TableName} '
      // 'ON ${MCategory.TableName}.id=$TableName.categoryId ';
      var result = await db.rawQuery(sql);
      List<MFolder> list = result.isNotEmpty
          ? result.toList().map((c) {
              //int id = c["id"];
              return MFolder.fromMap(c);
            }).toList()
          // ? result.toList().map((c) =>
          //     MFolder.fromMap(c)
          //   ).toList()
          : <MFolder>[];

      inMemoryTable = list;
      inMemoryTable.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MFolder mImage = inMemoryTable[i];
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

  static Future<void> createWithID(MFolder entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName (id,parentFolderId,fileName,categoryId, isVisible, isUnderstood, userCreated, isAvailable, useAsset, localFileName,user,backgroundColor) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          entity.id,
          entity.parentFolderId,
          entity.fileName,
          entity.categoryId,
          entity.isVisible,
          entity.isUnderstood,
          entity.userCreated,
          entity.isAvailable,
          entity.useAsset,
          entity.localFileName,
          entity.user,
          entity.backgroundColor,
        ]);

    clearMemoryTables();
  }

  static Future<List<MFolder>> getAll({
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
  }

  static Future<List<MFolder>> getUserCreated(String user) async {
    await populateInMemoryTables();

    var r = inMemoryTable
        .where((f) => f.userCreated == 1)
        .where((f) => f.user == user)
        .toList();

    r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    return r;
  }

  static Future<List<MFolder>> getFoldersIn(int parentFolderId) async {
    await populateInMemoryTables();

    var r =
        inMemoryTable.where((f) => f.parentFolderId == parentFolderId).toList();

    r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    return r;
    // String languageCode =
    //     await LocalPreferences.getString('languageCode', 'en');

    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.*, '
    //     '${Translation.TableName}.textToShow, ${Translation.TableName}.textToSay '
    //     'FROM $TableName '
    //     'LEFT JOIN ${Translation.TableName} '
    //     'ON ${Translation.TableName}.language="$languageCode" '
    //     'AND ${Translation.TableName}.tableName="$TableName" '
    //     'AND ${Translation.TableName}.itemId=$TableName.id '
    //     'AND ${Translation.TableName}.parentFolderId=$parentFolderId ';
    // var result = await db.rawQuery(sql);
    // List<MFolder> list = result.isNotEmpty
    //     ? result.toList().map((c) => MFolder.fromMap(c)).toList()
    //     : List<MFolder>();

    // var r = list;
    // r.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));
    // return r;
  }

  static Future<MFolder> getByID(int id) async {
    await populateInMemoryTables();

    return MFolder.inMemoryDictionary[id];
  }

  static Future<MFolder> getByFolderName(String folderName) async {
    await populateInMemoryTables();

    var results =
        inMemoryTable.where((f) => f.textToSay.contains(folderName)).toList();

    results.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));

    if (results.length > 0) {
      return results.first;
    }

    return null;
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
    //     'AND ${Translation.TableName}.tableName="${MFolder.TableName}" '
    //     'AND ${Translation.TableName}.itemId=$TableName.id '
    //     'LEFT JOIN ${MCategory.TableName} '
    //     'ON ${MCategory.TableName}.id=$TableName.categoryId '
    //     'WHERE ${Translation.TableName}.textToSay = "$folderName"';

    // var results = await db.rawQuery(sql);

    // if (results.length > 0) {
    //   MFolder result = MFolder.fromMap(results.first);
    //   return result;
    // }

    // return null;
  }

  static Future<MFolder> getDefaultUserFolder() async {
    return MFolder.inMemoryDictionary[95];

    // MFolder mFolder = await getByID(95);

    // return mFolder;
  }

  static Future<Map<int, MFolder>> getSeveralByID(List<int> ids) async {
    Map<int, MFolder> result = new Map();
    for (int id in ids) {
      MFolder mImage = await MFolder.getByID(id);
      result[id] = mImage;
    }

    return result;
  }

  static Future<List<MFolder>> getPath(MFolder mFolder) async {
    List<MFolder> folderList = <MFolder>[];

    while (mFolder.id != -1) {
      folderList.insert(0, mFolder);
      mFolder = await MFolder.getByID(mFolder.parentFolderId);
    }
    folderList.insert(0, mFolder);

    return folderList;
  }

  static Future<String> getBreadcrumb(int folderId) async {
    MFolder mFolder = await MFolder.getByID(folderId);
    List<MFolder> mFolders = await getPath(mFolder);

    String strResult = '';

    for (var i = 0; i < mFolders.length; i++) {
      strResult += mFolders[i].textToShow;
      if (i != mFolders.length - 1) {
        strResult += '/';
      }
    }

    return strResult;
  }

  static Future<void> update(MFolder entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap2(),
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
    String assetName = 'assets/catalogs/folders.json';

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
      int parentFolderId = int.parse(item.value["parentFolderId"]);
      String fileName = item.value["fileName"];
      int categoryId = int.parse(item.value["categoryId"]);
      // if (item.value["categoryId"] != null) {
      //   categoryId = int.parse(item.value["categoryId"]);
      // }
      int userCreated = 0;
      int isAvailable = 1;
      int useAsset = 1;
      String localFileName = '';
      String user = '';

      MFolder entity = MFolder(
        id: id,
        parentFolderId: parentFolderId,
        isVisible: isVisible,
        fileName: fileName,
        categoryId: categoryId,
        isUnderstood: isUnderstood,
        userCreated: userCreated,
        isAvailable: isAvailable,
        useAsset: useAsset,
        localFileName: localFileName,
        user: user,
      );

      //await MFolder.createWithID(mImage);

      batch.rawInsert(
          "INSERT Into $TableName (id,parentFolderId,fileName,categoryId, isVisible, isUnderstood, userCreated, isAvailable, useAsset, localFileName, user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.parentFolderId,
            entity.fileName,
            entity.categoryId,
            entity.isVisible,
            entity.isUnderstood,
            entity.userCreated,
            entity.isAvailable,
            entity.useAsset,
            entity.localFileName,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);

    MFolder mFolder = await MFolder.getByID(-1);
    if (mFolder == null) {
      mFolder = MFolder(
        id: -1,
        parentFolderId: -1,
        fileName: 'assets/images/folders_folder.png',
        categoryId: -1,
        isVisible: 1,
      );

      await MFolder.createWithID(mFolder);
    }

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MFolder.TableName,
    //       'folders', language.languageCode);
    // }
  }

  static Future<void> populateFromJsonImport() async {
    String assetName = 'assets/catalogs/folders_import.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int id = int.parse(item.value["id"]);
      int parentFolderId = int.parse(item.value["parentFolderId"]);
      int isVisible = int.parse(item.value["isVisible"]);
      int isUnderstood = int.parse(item.value["isUnderstood"]);
      int userCreated = int.parse(item.value["userCreated"]);
      int isAvailable = int.parse(item.value["isAvailable"]);
      int useAsset = int.parse(item.value["useAsset"]);
      String localFileName = item.value["localFileName"];
      String backgroundColor = item.value["backgroundColor"];
      String fileName = item.value["fileName"];
      int minLevelToShow = int.parse(item.value["minLevelToShow"]);
      String user = '';

      MFolder entity = MFolder(
        id: id,
        parentFolderId: parentFolderId,
        isVisible: isVisible,
        isUnderstood: isUnderstood,
        userCreated: userCreated,
        isAvailable: isAvailable,
        useAsset: useAsset,
        localFileName: localFileName,
        backgroundColor: backgroundColor,
        minLevelToShow: minLevelToShow,
        user: user,
        fileName: fileName,
      );

      batch.rawInsert(
          "INSERT Into $TableName (id,parentFolderId,isVisible,isUnderstood,userCreated,isAvailable,useAsset,localFileName,backgroundColor,minLevelToShow,user,fileName) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.parentFolderId,
            entity.isVisible,
            entity.isUnderstood,
            entity.userCreated,
            entity.isAvailable,
            entity.useAsset,
            entity.localFileName,
            entity.backgroundColor,
            entity.minLevelToShow,
            entity.user,
            entity.fileName,
          ]);
    }

    await batch.commit(noResult: true);

    MFolder mFolder = await MFolder.getByID(-1);
    if (mFolder == null) {
      mFolder = MFolder(
        id: -1,
        parentFolderId: -1,
        fileName: 'assets/images/folders_folder.png',
        categoryId: -1,
        isVisible: 1,
      );

      await MFolder.createWithID(mFolder);
    }

    // populate translations
    // List<Language> languages = Language.getAll();
    // for (int i = 0; i < languages.length; i++) {
    //   Language language = languages[i];
    //   await Translation.populateFromJson(replaceExistingInfo, MFolder.TableName,
    //       'folders', language.languageCode);
    // }
  }

  static Future<void> loadFromAssets() async {
    //await Translation.createTableIFNotExists();
    await MFolder.createTableIFNotExists();
    // await Translation.deleteForTable(MFolder.TableName);
    await MFolder.deleteAll();

    // await MFolder.populateFromJson(false);
    await MFolder.populateFromJsonImport();
  }

  static MFolder notFoundFolder() {
    return MFolder(
      id: -1,
      parentFolderId: -1,
      categoryId: -1,
      fileName: Helper.imageNotFound,
    );
  }

  static Future<int> maxId() async {
    // final db = await DBProvider.db.database;
    int i = UniqueKey().hashCode;
    if(i<30000){
      Random random = new Random();
      int randomNumber = random.nextInt(9999)+30000;
      i+=randomNumber;
    }
    return i;

    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    // int maxId = table.first["id"] ?? 1;

    // return maxId;
  }

  static updateBackgroundColor() async {
    List<MFolder> objects = await getAll();
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].backgroundColor == "") {
        MCategory mCategory = await MCategory.getByID(objects[i].categoryId);
        if (mCategory != null) {
          objects[i].backgroundColor = mCategory.backgroundColor;
          objects[i].minLevelToShow = mCategory.minLevelToShow;
          await MFolder.update(objects[i]);
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
    List<MFolder> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MFolder list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }

  static Future<WebResponse> backupUserCreatedObjects() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MFolder> objects = await getAll();

    WebResponse webResponse = WebResponse(message: "", operation: true);
    for (int i = 0; i < objects.length; i++) {
      MFolder obj = objects[i];
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

  factory MFolder.jsonToFolder(Map<String, dynamic> json) => MFolder(
    id: json["idInDevice"],
    parentFolderId: json["parentFolderId"],
    fileName: json["fileName"]??'',
    categoryId: json["categoryId"]??-1,
    textToShow: json["textToShow"]??'',
    textToSay: json["textToSay"]??'',
    isVisible: json["isVisible"]??1,
    isUnderstood: json["isUnderstood"]??1,
    backgroundColor: json["backgroundColor"]??'',
    //minColumn: json["minColumn"],
    //maxColumn: json["maxColumn"],
    minLevelToShow: json["minLevelToShow"]??1,
    userCreated: json["userCreated"]??1,
    isAvailable: json["isAvailable"]??1,
    useAsset: json["useAsset"]??1,
    localFileName: json["localFileName"]??'',
    user: json["user"]??'',
  );
}
