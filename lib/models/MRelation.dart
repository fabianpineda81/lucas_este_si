import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';

// enum CardType {
//   image,
//   folder,
//   video,
//   sound,
//   notAssigned
// }

class MRelation {
  static const String TableName = 'relations';

  //static List<MRelation> relations = List<MRelation>();

  String cardType = 'image'; // type of card
  int id = -1; // entity's ID
  int parentFolderId = -1; // folder where this card belongs to
  int cardFolderId = -1; // folder ID of this card
  int cardImageId = -1; // image ID of this card
  int cardEmptyId = -1; // empty ID of this card
  int cardVideoId = -1; // video ID of this card
  int cardSoundId = -1; // sound ID of this card
  int userCreated = 0; // indicates if the user has created this relationship
  String parentFolderName = '';
  int visibleIndex = -1; // defines the objects placement in the grid
  int gridColumns =
      6; // inicated that the layout applies when using this number of columns
  String user =
      ''; // Indicates to what user the folder,image, video or sound belongs to
  static bool first = true;
  static List<MRelation> inMemoryTable;
  static Map<int, MRelation> inMemoryDictionary;

  MRelation({
    int id = -1,
    int parentFolderId = -1,
    String cardType = 'image',
    int cardFolderId = -1,
    int cardImageId = -1,
    int cardEmptyId = -1,
    int cardVideoId = -1,
    int cardSoundId = -1,
    int userCreated = 0,
    int visibleIndex = -1,
    String user = '',
    int gridColumns = 6,
  }) {
    this.id = id;
    this.parentFolderId = parentFolderId;
    this.cardType = cardType;
    this.cardFolderId = cardFolderId;
    this.cardImageId = cardImageId;
    this.cardEmptyId = cardEmptyId;
    this.cardVideoId = cardVideoId;
    this.cardSoundId = cardSoundId;
    this.userCreated = userCreated;
    this.visibleIndex = visibleIndex;
    this.gridColumns = gridColumns;
    this.user = user ?? '';
  }

  factory MRelation.fromMap(Map<String, dynamic> json) => new MRelation(
        id: json["id"],
        parentFolderId: json["parentFolderId"],
        cardType: json["cardType"],
        cardFolderId: json["cardFolderId"],
        cardImageId: json["cardImageId"],
        cardEmptyId: json["cardEmptyId"],
        cardVideoId: json["cardVideoId"],
        cardSoundId: json["cardSoundId"],
        userCreated: json["userCreated"],
        visibleIndex: json["visibleIndex"],
        gridColumns: json["gridColumns"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "parentFolderId": parentFolderId,
        "cardType": cardType,
        "cardFolderId": cardFolderId,
        "cardImageId": cardImageId,
        "cardEmptyId": cardEmptyId,
        "cardVideoId": cardVideoId,
        "cardSoundId": cardSoundId,
        "userCreated": userCreated,
        "visibleIndex": visibleIndex,
        "gridColumns": gridColumns,
        "user": user,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "parentFolderId INTEGER,"
      "visibleIndex INTEGER,"
      "gridColumns INTEGER,"
      "cardType TEXT,"
      "cardFolderId INTEGER,"
      "cardEmptyId INTEGER,"
      "cardImageId INTEGER,"
      "cardVideoId INTEGER,"
      "cardSoundId INTEGER,"
      "userCreated INTEGER,"
      "user TEXT"
      ")";

  static populateInMemoryTables() async {
    if (inMemoryTable == null) {
      final db = await DBProvider.db.database;
      String sql = 'SELECT $TableName.* '
          'FROM $TableName ';
      var result = await db.rawQuery(sql);
      List<MRelation> list = result.isNotEmpty
          ? result.toList().map((c) => MRelation.fromMap(c)).toList()
          : <MRelation>[];

      inMemoryTable = list;
      inMemoryTable
          .sort((i1, i2) => i1.visibleIndex.compareTo(i2.visibleIndex));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MRelation mRelation = inMemoryTable[i];
        inMemoryDictionary[mRelation.id] = mRelation;
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

  static Future<void> createWithID(MRelation entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName ("
        "id, parentFolderId,cardType,cardFolderId,cardImageId,cardEmptyId,cardVideoId,cardSoundId, userCreated, visibleIndex,gridColumns,user)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          entity.id,
          entity.parentFolderId,
          entity.cardType,
          entity.cardFolderId,
          entity.cardImageId,
          entity.cardEmptyId,
          entity.cardVideoId,
          entity.cardSoundId,
          entity.userCreated,
          entity.visibleIndex,
          entity.gridColumns,
          entity.user,
        ]);

    clearMemoryTables();
  }

  static Future<List<MRelation>> getAll({
    textToSearch = '',
  }) async {
    await populateInMemoryTables();

    return inMemoryTable;

    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.* '
    //     'FROM $TableName ';
    // var result = await db.rawQuery(sql);
    // List<MRelation> list = result.isNotEmpty
    //     ? result.toList().map((c) => MRelation.fromMap(c)).toList()
    //     : List<MRelation>();

    // return list;
  }

  static Future<List<MRelation>> getInFolder(
      int gridColumns, int parentFolderId) async {
    await populateInMemoryTables();

    var result = inMemoryTable
        .where((f) =>
            f.parentFolderId == parentFolderId && f.gridColumns == gridColumns)
        .toList();

    result.sort((i1, i2) => i1.visibleIndex.compareTo(i2.visibleIndex));

    return result;
    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.* '
    //     'FROM $TableName '
    //     'WHERE parentFolderId = $parentFolderId '
    //     'ORDER BY visibleIndex';
    // var result = await db.rawQuery(sql);
    // List<MRelation> list = result.isNotEmpty
    //     ? result.toList().map((c) => MRelation.fromMap(c)).toList()
    //     : List<MRelation>();

    // return list;
  }

  static Future<List<MObject>> getLearningObjectsInFolder(
      int currentLevel, int parentFolderId, int gridColumns) async {
    List<MRelation> relations =
        await getVisibleInFolder(parentFolderId, gridColumns);
    List<MRelation> relations6Cols =
        await getVisibleInFolder(parentFolderId, 6);

    // If no relations are found, it can be because only the default relations for gridColumns==6 exist,
    // so create them in the selected layout
    if (relations.length != relations6Cols.length) {
      for (int i = 0; i < relations6Cols.length; i++) {
        MRelation mRelation6Cols = relations6Cols[i];

        bool exists = false;
        for (int j = 0; j < relations.length; j++) {
          MRelation mExistingRelation = relations[j];
          if (mExistingRelation.parentFolderId ==
                  mRelation6Cols.parentFolderId &&
              mExistingRelation.cardFolderId == mRelation6Cols.cardFolderId &&
              mExistingRelation.cardImageId == mRelation6Cols.cardImageId &&
              mExistingRelation.cardEmptyId == mRelation6Cols.cardEmptyId &&
              mExistingRelation.cardType == mRelation6Cols.cardType &&
              mExistingRelation.cardVideoId == mRelation6Cols.cardVideoId &&
              mExistingRelation.user == mRelation6Cols.user &&
              mExistingRelation.userCreated == mRelation6Cols.userCreated) {
            exists = true;
            break;
          }
        }

        if (!exists) {
          int maxRelationId = await MRelation.maxId();
          MRelation relationToAdd = MRelation(
            id: maxRelationId,
            parentFolderId: mRelation6Cols.parentFolderId,
            cardType: mRelation6Cols.cardType,
            cardFolderId: mRelation6Cols.cardFolderId,
            cardImageId: mRelation6Cols.cardImageId,
            cardEmptyId: mRelation6Cols.cardEmptyId,
            visibleIndex: mRelation6Cols.visibleIndex,
            gridColumns: gridColumns,
            userCreated: mRelation6Cols.userCreated,
          );

          await MRelation.createWithID(relationToAdd);
          relations.add(relationToAdd);
        }
      }

      relations = await getInFolder(gridColumns, parentFolderId);
    }

    //var r = relations.where((f) => f.parentFolderId == parentFolderId).toList();
    List<MObject> result = <MObject>[];
    for (int i = 0; i < relations.length; i++) {
      if (relations[i].cardType == 'empty') {
        MEmpty mEmpty = await MEmpty.getByID(relations[i].cardEmptyId);

        if (mEmpty != null) {
          mEmpty.relationId = relations[i].id;
          mEmpty.visibleIndex = relations[i].visibleIndex;
          result.add(mEmpty);
        }
      }

      if (relations[i].cardType == 'image') {
        MImage mImage = await MImage.getByID(relations[i].cardImageId);

        if (mImage != null) {
          mImage.relationId = relations[i].id;
          mImage.visibleIndex = relations[i].visibleIndex;
          if (currentLevel >= mImage.minLevelToShow) {
            result.add(mImage);
          } else {
            result.add(MEmpty());
          }
        }
      }

      // Folders are shown only after level 5
      if (currentLevel > 5) {
        if (relations[i].cardType == 'folder') {
          MFolder mFolder = await MFolder.getByID(relations[i].cardFolderId);

          if (mFolder != null) {
            if (mFolder.id != -1) {
              mFolder.relationId = relations[i].id;
              mFolder.visibleIndex = relations[i].visibleIndex;
              if (currentLevel >= mFolder.minLevelToShow) {
                result.add(mFolder);
              } else {
                result.add(MEmpty());
              }
            }
          }
        }
      }

      if (relations[i].cardType == 'video') {
        MVideo mVideo = await MVideo.getByID(relations[i].cardVideoId);

        // mVideo.strBase64 = MObject.getStrBase64(mVideo.useAsset, mVideo.localFileName);
        if (mVideo != null) {
          mVideo.relationId = relations[i].id;
          mVideo.visibleIndex = relations[i].visibleIndex;
          if (currentLevel >= mVideo.minLevelToShow) {
            result.add(mVideo);
          } else {
            result.add(MEmpty());
          }
        }
      }

      if (relations[i].cardType == 'sound') {
        MSound mSound = await MSound.getByID(relations[i].cardSoundId);

        // mSound.strBase64 = MObject.getStrBase64(mSound.useAsset, mSound.localFileName);
        if (mSound != null) {
          mSound.relationId = relations[i].id;
          mSound.visibleIndex = relations[i].visibleIndex;
          if (currentLevel >= mSound.minLevelToShow) {
            result.add(mSound);
          } else {
            result.add(MEmpty());
          }
        }
      }
    }

    return result;
  }

  static Future<List<MObject>> getObjectsInFolder(
      int gridColumns, int parentFolderId) async {
    MFolder.clearMemoryTables();
    MImage.clearMemoryTables();
    MSound.clearMemoryTables();
    MVideo.clearMemoryTables();
    MEmpty.clearMemoryTables();
    MRelation.clearMemoryTables();

    List<MObject> result = <MObject>[];

    //if (relations == null) return result;
    List<MRelation> relations = await getInFolder(gridColumns, parentFolderId);
    List<MRelation> relations6Cols = await getInFolder(6, parentFolderId);

    // If no relations are found, it can be because only the default relations for gridColumns==6 exist,
    // so create them in the selected layout
    if (relations.length != relations6Cols.length) {
      for (int i = 0; i < relations6Cols.length; i++) {
        MRelation mRelation6Cols = relations6Cols[i];

        bool exists = false;
        for (int j = 0; j < relations.length; j++) {
          MRelation mExistingRelation = relations[j];
          if (mExistingRelation.parentFolderId ==
                  mRelation6Cols.parentFolderId &&
              mExistingRelation.cardFolderId == mRelation6Cols.cardFolderId &&
              mExistingRelation.cardImageId == mRelation6Cols.cardImageId &&
              mExistingRelation.cardEmptyId == mRelation6Cols.cardEmptyId &&
              mExistingRelation.cardType == mRelation6Cols.cardType &&
              mExistingRelation.cardVideoId == mRelation6Cols.cardVideoId &&
              mExistingRelation.user == mRelation6Cols.user &&
              mExistingRelation.userCreated == mRelation6Cols.userCreated) {
            exists = true;
            break;
          }
        }

        if (!exists) {
          int maxRelationId = await MRelation.maxId();
          MRelation relationToAdd = MRelation(
            id: maxRelationId,
            parentFolderId: mRelation6Cols.parentFolderId,
            cardType: mRelation6Cols.cardType,
            cardFolderId: mRelation6Cols.cardFolderId,
            cardImageId: mRelation6Cols.cardImageId,
            cardEmptyId: mRelation6Cols.cardEmptyId,
            visibleIndex: mRelation6Cols.visibleIndex,
            gridColumns: gridColumns,
            userCreated: mRelation6Cols.userCreated,
          );

          await MRelation.createWithID(relationToAdd);
          relations.add(relationToAdd);
        }
      }

      relations = await getInFolder(gridColumns, parentFolderId);
    }

    //var r = relations.where((f) => f.parentFolderId == parentFolderId).toList();
    for (int i = 0; i < relations.length; i++) {
      MRelation mRelation = relations[i];

      if (mRelation.cardType == 'empty') {
        MEmpty mEmpty = await MEmpty.getByID(mRelation.cardEmptyId);
        if (mEmpty != null) {
          mEmpty.relationId = mRelation.id;
          mEmpty.visibleIndex = mRelation.visibleIndex;
          result.add(mEmpty);
        }
      }

      if (mRelation.cardType == 'image') {
        //MImage.clearMemoryTables();
        //MImage mImage = MImage.inMemoryDictionary[mRelation.cardImageId];
        MImage mImage = await MImage.getByID(mRelation.cardImageId);
        if (mImage != null) {
          mImage.relationId = mRelation.id;
          mImage.visibleIndex = mRelation.visibleIndex;
          result.add(mImage);
        }
      }

      if (mRelation.cardType == 'folder') {
        MFolder mFolder = await MFolder.getByID(mRelation.cardFolderId);
        if (mFolder != null) {
          if (mFolder.id != -1) {
            mFolder.relationId = mRelation.id;
            mFolder.visibleIndex = mRelation.visibleIndex;
            result.add(mFolder);
          }
        }
      }

      if (mRelation.cardType == 'video') {
        MVideo mVideo = await MVideo.getByID(mRelation.cardVideoId);
        if (mVideo != null) {
          if (mVideo.id != -1) {
            mVideo.relationId = mRelation.id;
            mVideo.visibleIndex = mRelation.visibleIndex;
            result.add(mVideo);
          }
        }
      }

      if (mRelation.cardType == 'sound') {
        MSound mSound = await MSound.getByID(mRelation.cardSoundId);
        if (mSound != null) {
          if (mSound.id != -1) {
            mSound.relationId = mRelation.id;
            mSound.visibleIndex = mRelation.visibleIndex;
            result.add(mSound);
          }
        }
      }
    }

    return result;
  }

  static Future<List<MObject>> getObjectsInFolderBD(int parentFolderId) async {
    List<MObject> objets = <MObject>[];
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE parentFolderId = $parentFolderId '
        'ORDER BY visibleIndex';
    var result = await db.rawQuery(sql);
    List<MRelation> relations = result.isNotEmpty
        ? result.toList().map((c) => MRelation.fromMap(c)).toList()
        : <MRelation>[];

    for (int i = 0; i < relations.length; i++) {
      MRelation mRelation = relations[i];

      if (mRelation.cardType == 'empty') {
        MEmpty mEmpty = await MEmpty.getByID(mRelation.cardEmptyId);
        if (mEmpty != null) {
          mEmpty.relationId = mRelation.id;
          mEmpty.visibleIndex = mRelation.visibleIndex;
          objets.add(mEmpty);
        }
      }

      if (mRelation.cardType == 'image') {
        //MImage.clearMemoryTables();
        //MImage mImage = MImage.inMemoryDictionary[mRelation.cardImageId];
        MImage mImage = await MImage.getByID(mRelation.cardImageId);
        if (mImage != null) {
          mImage.relationId = mRelation.id;
          mImage.visibleIndex = mRelation.visibleIndex;
          objets.add(mImage);
        }
      }

      if (mRelation.cardType == 'folder') {
        MFolder mFolder = await MFolder.getByID(mRelation.cardFolderId);
        if (mFolder != null) {
          if (mFolder.id != -1) {
            mFolder.relationId = mRelation.id;
            mFolder.visibleIndex = mRelation.visibleIndex;
            objets.add(mFolder);
          }
        }
      }

      if (mRelation.cardType == 'video') {
        MVideo mVideo = await MVideo.getByID(mRelation.cardVideoId);
        if (mVideo != null) {
          if (mVideo.id != -1) {
            mVideo.relationId = mRelation.id;
            mVideo.visibleIndex = mRelation.visibleIndex;
            objets.add(mVideo);
          }
        }
      }

      if (mRelation.cardType == 'sound') {
        MSound mSound = await MSound.getByID(mRelation.cardSoundId);
        if (mSound != null) {
          if (mSound.id != -1) {
            mSound.relationId = mRelation.id;
            mSound.visibleIndex = mRelation.visibleIndex;
            objets.add(mSound);
          }
        }
      }
    }

    return objets;
  }

  static Future<List<MRelation>> getAllRelationsOfItemId(
      String typeOfConcept, int itemId) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE cardType = "$typeOfConcept" ';

    if (typeOfConcept == 'image') {
      sql += ' AND cardImageId = $itemId';
    }
    if (typeOfConcept == 'folder') {
      sql += ' AND cardFolderId = $itemId';
    }
    if (typeOfConcept == 'video') {
      sql += ' AND cardVideoId = $itemId';
    }
    if (typeOfConcept == 'sound') {
      sql += ' AND cardSoundId = $itemId';
    }
    if (typeOfConcept == 'empty') {
      sql += ' AND cardEmptyId = $itemId';
    }

    var result = await db.rawQuery(sql);
    List<MRelation> list = result.isNotEmpty
        ? result.toList().map((c) => MRelation.fromMap(c)).toList()
        : <MRelation>[];

    for (int i = 0; i < list.length; i++) {
      int parentFolderId = list[i].parentFolderId;
      if (parentFolderId == -1)
        list[i].parentFolderName = '/';
      else {
        MFolder mFolder = await MFolder.getByID(parentFolderId);
        if (mFolder != null)
          list[i].parentFolderName = mFolder.textToShow;
        else
          list[i].parentFolderName = '';
      }
    }

    return list;
  }

  static Future<List<MRelation>> getVisibleInFolder(
      int parentFolderId, int gridColumns) async {
    await populateInMemoryTables();

    var r = inMemoryTable
        .where((f) =>
            f.parentFolderId == parentFolderId && f.gridColumns == gridColumns)
        .toList();

    r.sort((i1, i2) => i1.visibleIndex.compareTo(i2.visibleIndex));
    return r;
  }

  static Future<MRelation> getByID(int id) async {
    await populateInMemoryTables();

    return MRelation.inMemoryDictionary[id];
    // final db = await DBProvider.db.database;
    // String sql = 'SELECT $TableName.* '
    //     'FROM $TableName '
    //     'WHERE $TableName.id = $id';

    // var results = await db.rawQuery(sql);

    // if (results.length > 0) {
    //   MRelation result = MRelation.fromMap(results.first);
    //   return result;
    // }

    // return null;
  }

  static Future<void> update(MRelation entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toMap(),
        where: "id = ?", whereArgs: [entity.id]);
  }

  static Future<void> updateVisibleIndexById(int visibleIndex, int relationId,
      int parentFolderId, int gridColumns) async {
    try {
      final db = await DBProvider.db.database;

      String qry = 'UPDATE $TableName '
          'SET visibleIndex = $visibleIndex '
          'WHERE id = $relationId'; // AND gridColumns = $gridColumns AND parentFolderId = $parentFolderId';

      await db.rawInsert(qry);

      // MRelation mRel = await getByID(relationId);
      // if (mRel == null) {}
    } catch (err) {
      //int a = 0;
    }
  }

  static Future<void> updateVisibleIndex(MObject mObject) async {
    clearMemoryTables();

    // final db = await DBProvider.db.database;

    // // get all relations of object
    // List<MRelation> mRelations = List<MRelation>();
    // MRelation mRelation = await MRelation.getByID(mObject.relationId);
    // if (mRelation != null) {
    //   if (mRelation.cardType == 'image') {
    //     mRelations = await getAllRelationsOfItemId(
    //         mRelation.cardType, mRelation.cardImageId);
    //   }
    //   if (mRelation.cardType == 'folder') {
    //     mRelations = await getAllRelationsOfItemId(
    //         mRelation.cardType, mRelation.cardFolderId);
    //   }
    //   if (mRelation.cardType == 'video') {
    //     mRelations = await getAllRelationsOfItemId(
    //         mRelation.cardType, mRelation.cardVideoId);
    //   }
    //   if (mRelation.cardType == 'sound') {
    //     mRelations = await getAllRelationsOfItemId(
    //         mRelation.cardType, mRelation.cardSoundId);
    //   }
    // }

    // // set visibleIndex of all relations of object
    // for (int i = 0; i < mRelations.length; i++) {
    //   MRelation mRelation = mRelations[i];
    //   if (mRelation.visibleIndex == -1) {
    //     await db.rawInsert('UPDATE $TableName '
    //         'SET visibleIndex = visibleIndex+1 '
    //         'WHERE visibleIndex!=-1');

    //     await db.rawInsert('UPDATE $TableName '
    //         'SET visibleIndex = 0 '
    //         'WHERE id = ${mRelation.id}');
    //   }
    // }
  }

  static Future<void> deleteAllNotUserCreated() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE userCreated=0");

    clearMemoryTables();
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");

    clearMemoryTables();
  }

  static Future<void> delete(MRelation mobject) async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE id=${mobject.id}");

    clearMemoryTables();
  }

  static Future<void> deleteDuplicated() async {
    final db = await DBProvider.db.database;

    List<MRelation> relations = await MRelation.getAll();
    List<MRelation> duplicatedRelations = <MRelation>[];
    for (int i = 0; i < relations.length; i++) {
      MRelation iRelation = relations[i];

      for (int j = i + 1; j < relations.length; j++) {
        MRelation jRelation = relations[j];
        if (jRelation.cardFolderId == iRelation.cardFolderId &&
            jRelation.cardImageId == iRelation.cardImageId &&
            jRelation.cardEmptyId == iRelation.cardEmptyId &&
            jRelation.cardType == iRelation.cardType &&
            jRelation.parentFolderId == iRelation.parentFolderId) {
          duplicatedRelations.add(jRelation);
        }
      }
    }

    for (int i = 0; i < duplicatedRelations.length; i++) {
      await db.rawQuery(
          "delete from $TableName WHERE id=${duplicatedRelations[i].id}");
    }

    clearMemoryTables();
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');

    clearMemoryTables();
  }

  static Future<void> populateFromJson(bool replaceExistingInfo) async {
    String assetName = 'assets/catalogs/relations.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    await saveAssetInDatabase(replaceExistingInfo, jsonString);
  }

  static Future<void> saveAssetInDatabase(
      bool replaceExistingInfo, String jsonString) async {
    final db = await DBProvider.db.database;
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    Batch batch = db.batch();

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $TableName");
    int maxId = await table.first["id"] ?? 1;

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      //int id = int.parse(item.value["id"]);
      int parentFolderId = int.parse(item.value["parentFolderId"]);
      String cardType = item.value["cardType"];
      int cardFolderId = int.parse(item.value["cardFolderId"]);
      int cardImageId = int.parse(item.value["cardImageId"]);
      int cardEmptyId = -1;
      if (item.value["cardEmptyId"] != null)
        cardEmptyId = int.parse(item.value["cardEmptyId"]);
      int cardVideoId = int.parse(item.value["cardVideoId"]);
      int cardSoundId = int.parse(item.value["cardSoundId"]);
      int visibleIndex = int.parse(item.value["visibleIndex"]);
      int userCreated = 0;
      String user = '';

      MRelation entity = MRelation(
        id: maxId,
        parentFolderId: parentFolderId,
        cardType: cardType,
        cardFolderId: cardFolderId,
        cardImageId: cardImageId,
        cardEmptyId: cardEmptyId,
        cardVideoId: cardVideoId,
        cardSoundId: cardSoundId,
        visibleIndex: visibleIndex,
        userCreated: userCreated,
        user: user,
      );

      maxId++;

      batch.rawInsert(
          "INSERT Into $TableName ("
          "id, parentFolderId,cardType,cardFolderId,cardImageId, cardEmptyId,cardVideoId, cardSoundId, userCreated, visibleIndex, gridColumns, user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.parentFolderId,
            entity.cardType,
            entity.cardFolderId,
            entity.cardImageId,
            entity.cardEmptyId,
            entity.cardVideoId,
            entity.cardSoundId,
            entity.userCreated,
            entity.visibleIndex,
            entity.gridColumns,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);
  }

  static Future<void> populateFromJsonImport() async {
    String assetName = 'assets/catalogs/relations.json';

    String jsonString = await Helper.loadStringAsset(assetName);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    final db = await DBProvider.db.database;
    Batch batch = db.batch();

    for (MapEntry<String, dynamic> item in jsonMap.entries) {
      int id = int.parse(item.value["id"]);
      int parentFolderId = int.parse(item.value["parentFolderId"]);
      String cardType = item.value["cardType"];
      int cardFolderId = int.parse(item.value["cardFolderId"]);
      int cardImageId = int.parse(item.value["cardImageId"]);
      int cardEmptyId = int.parse(item.value["cardEmptyId"]);
      int cardVideoId = int.parse(item.value["cardVideoId"]);
      int cardSoundId = int.parse(item.value["cardSoundId"]);
      int userCreated = int.parse(item.value["userCreated"]);
      int visibleIndex = int.parse(item.value["visibleIndex"]);
      int gridColumns = int.parse(item.value["gridColumns"]);
      String user = '';

      MRelation entity = MRelation(
        id: id,
        parentFolderId: parentFolderId,
        cardType: cardType,
        cardFolderId: cardFolderId,
        cardImageId: cardImageId,
        cardEmptyId: cardEmptyId,
        cardVideoId: cardVideoId,
        cardSoundId: cardSoundId,
        userCreated: userCreated,
        visibleIndex: visibleIndex,
        gridColumns: gridColumns,
        user: user,
      );

      batch.rawInsert(
          "INSERT Into $TableName ("
          "id,parentFolderId,cardType,cardFolderId,cardImageId,cardEmptyId,cardVideoId,cardSoundId,userCreated,visibleIndex,gridColumns,user) "
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            entity.id,
            entity.parentFolderId,
            entity.cardType,
            entity.cardFolderId,
            entity.cardImageId,
            entity.cardEmptyId,
            entity.cardVideoId,
            entity.cardSoundId,
            entity.userCreated,
            entity.visibleIndex,
            entity.gridColumns,
            entity.user,
          ]);
    }

    await batch.commit(noResult: true);
  }

  static Future<void> loadFromAssets() async {
    await MRelation.createTableIFNotExists();

    // await MRelation.deleteAllNotUserCreated();
    // await MRelation.populateFromJson(false);

    await MRelation.deleteAll();
    // await MRelation.populateFromJson(false);
    await MRelation.populateFromJsonImport();
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

  static Future<List<MObject>> moveItem(MObject mDraggedObject,
      MObject mDraggedToObject, int gridColumns, int parentFolderId) async {
    List<MObject> objectsInFolder =
        await getObjectsInFolder(gridColumns, parentFolderId);

    await fixConsecutiveVisibleIndex(gridColumns, parentFolderId);

    // Logger().e(objectsInFolder[15].visibleIndex);

    // If visible index 1000 found, renumber visible index
    //bool needToRefresh = await fixVisibleIndex1000(gridColumns, parentFolderId);
    //if (needToRefresh) {
    //objectsInFolder = await getObjectsInFolder(gridColumns, parentFolderId);
    //return objectsInFolder;
    //}

    if (mDraggedObject.visibleIndex == mDraggedToObject.visibleIndex)
      return objectsInFolder;

    try {
      var temp = mDraggedObject.visibleIndex;
      var to = mDraggedToObject.visibleIndex;

      await MRelation.updateVisibleIndexById(objectsInFolder[to].visibleIndex,
          objectsInFolder[temp].relationId, parentFolderId, gridColumns);
      await MRelation.updateVisibleIndexById(objectsInFolder[temp].visibleIndex,
          objectsInFolder[to].relationId, parentFolderId, gridColumns);
    } catch (err) {}

    // If visible renumber consecutively
    await fixConsecutiveVisibleIndex(gridColumns, parentFolderId);

    clearMemoryTables();
    objectsInFolder = await getObjectsInFolder(gridColumns, parentFolderId);
    return objectsInFolder;
  }

  static Future<bool> fixVisibleIndex1000(
      int gridColumns, int parentFolderId) async {
    List<MObject> objectsInFolder =
        await getObjectsInFolder(gridColumns, parentFolderId);

    bool foundVisibleIndex1000 = false;
    for (int i = 0; i < objectsInFolder.length; i++) {
      if (objectsInFolder[i].visibleIndex == 1000) {
        foundVisibleIndex1000 = true;
        break;
      }
    }
    if (foundVisibleIndex1000) {
      for (int i = 0; i < objectsInFolder.length; i++) {
        objectsInFolder[i].visibleIndex = i + 1;
      }
      for (int i = 0; i < objectsInFolder.length; i++) {
        await MRelation.updateVisibleIndexById(objectsInFolder[i].visibleIndex,
            objectsInFolder[i].relationId, parentFolderId, gridColumns);
      }
      clearMemoryTables();

      return true;
    }

    return false;
  }

  static Future<bool> fixConsecutiveVisibleIndex(
      int gridColumns, int parentFolderId) async {
    List<MObject> objectsInFolder =
        await getObjectsInFolder(gridColumns, parentFolderId);

    bool mustFixNumbering = false;
    for (int i = 0; i < objectsInFolder.length; i++) {
      if (objectsInFolder[i].visibleIndex != i) {
        mustFixNumbering = true;
        break;
      }
    }
    if (mustFixNumbering) {
      for (int i = 0; i < objectsInFolder.length; i++) {
        objectsInFolder[i].visibleIndex = i;
      }
      for (int i = 0; i < objectsInFolder.length; i++) {
        await MRelation.updateVisibleIndexById(objectsInFolder[i].visibleIndex,
            objectsInFolder[i].relationId, parentFolderId, gridColumns);
      }
      clearMemoryTables();
      return true;
    }
    return false;
  }

  Map toJson() {
    return toMap();
  }

  static Future<WebResponse> backup() async {
    String strUserEmail = await LocalPreferences.getString('userEmail', '');
    String strUserName = await LocalPreferences.getString('userName', '');
    List<MRelation> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MRelation list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }

  factory MRelation.jsonToRelation(Map<String, dynamic> json) => MRelation(
        id: json["idInDevice"],
        parentFolderId: json["parentFolderId"],
        cardType: json["cardType"],
        cardFolderId: json["cardFolderId"],
        cardImageId: json["cardImageId"],
        userCreated: json["userCreated"] ?? '',
        visibleIndex: json["visibleIndex"] ?? '',
        gridColumns: json["gridColumns"] ?? '',
        user: json["user"] ?? '',
      );
}
