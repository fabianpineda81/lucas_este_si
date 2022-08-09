import 'dart:convert';

import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/localizations/L.dart';

import 'package:lucas/database/Database.dart';
import 'package:lucas/models/MObject.dart';

import 'MImage.dart';

class MScheduleDay {
  static const String TableName = 'scheduleDays';
  int id;
  String name;
  int dayOrder;
  int canDelete;
  int imageId;
  MImage mImage;

  static List<MScheduleDay> inMemoryTable;
  static Map<int, MScheduleDay> inMemoryDictionary;

  MScheduleDay({
    int id,
    String name = '',
    int dayOrder = 1,
    int canDelete = 0,
    int imageId = -1,
  }) {
    this.id = id;
    this.name = name;
    this.dayOrder = dayOrder;
    this.canDelete = canDelete;
    this.imageId = imageId;
  }

  factory MScheduleDay.fromMap(Map<String, dynamic> json) => new MScheduleDay(
        id: json["id"],
        name: json["name"],
        dayOrder: json["dayOrder"],
        canDelete: json["canDelete"],
        imageId: json["imageId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "dayOrder": dayOrder,
        "canDelete": canDelete,
        "imageId": imageId,
      };

  Map<String, dynamic> idMap() => {
        "id": id,
        "name": name,
        "dayOrder": dayOrder,
        "canDelete": canDelete,
        "imageId": imageId,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "name": name,
        "dayOrder": dayOrder,
        "canDelete": canDelete,
        "imageId": imageId,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "dayOrder INTEGER,"
      "canDelete INTEGER,"
      "imageId INTEGER"
      ")";

  static populateInMemoryTables() async {
    List<String> translationItems = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
      'school',
      'home',
    ];

    Map<String, String> translations = Map<String, String>();

    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
    translations = await L.getItems(translationItems);

    if (inMemoryTable == null) {
      final db = await DBProvider.db.database;
      String sql = 'SELECT $TableName.* '
          'FROM $TableName ';
      var result = await db.rawQuery(sql);
      List<MScheduleDay> list = result.isNotEmpty
          ? result.toList().map((c) => MScheduleDay.fromMap(c)).toList()
          : <MScheduleDay>[];
      list.sort((i1, i2) => i1.dayOrder.compareTo(i2.dayOrder));

      // replace names for some key columns
      for (int i = 0; i < list.length; i++) {
        if (list[i].id == 1) list[i].name = translations['monday'];
        if (list[i].id == 2) list[i].name = translations['tuesday'];
        if (list[i].id == 3) list[i].name = translations['wednesday'];
        if (list[i].id == 4) list[i].name = translations['thursday'];
        if (list[i].id == 5) list[i].name = translations['friday'];
        if (list[i].id == 6) list[i].name = translations['saturday'];
        if (list[i].id == 7) list[i].name = translations['sunday'];
        if (list[i].id == 8) list[i].name = translations['school'];
        if (list[i].id == 9) list[i].name = translations['home'];

        list[i].mImage = await MImage.getByID(list[i].imageId);
      }

      inMemoryTable = list;
      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MScheduleDay mScheduleDay = inMemoryTable[i];
        inMemoryDictionary[mScheduleDay.id] = mScheduleDay;
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

  static Future<void> createWithID(MScheduleDay entity) async {
    final db = await DBProvider.db.database;

    await db.rawInsert(
        "INSERT Into $TableName (id,name,dayOrder,canDelete,imageId)"
        " VALUES (?,?,?,?,?)",
        [
          entity.id,
          entity.name,
          entity.dayOrder,
          entity.canDelete,
          entity.imageId,
        ]);

    clearMemoryTables();
  }

  static Future<List<MScheduleDay>> getAll({
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

  static Future<MScheduleDay> getByID(int id) async {
    await populateInMemoryTables();

    return MScheduleDay.inMemoryDictionary[id];
  }

  // static Future<Map<int, MSchedule>> getSeveralByID(List<int> ids) async {
  //   Map<int, MSchedule> result = new Map();
  //   for (int id in ids) {
  //     MSchedule mSchedule = await MSchedule.getByID(id);
  //     result[id] = mSchedule;
  //   }

  //   return result;
  // }

  static Future<void> update(MScheduleDay entity) async {
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
    List<MScheduleDay> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MScheduleDay list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
