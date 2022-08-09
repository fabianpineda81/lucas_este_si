import 'dart:convert';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';

class MLinkedDevice {
  static const String TableName = 'linkedDevices';

  int id = -1;
  String email = '';
  String name = '';
  int blocked = 0;
  String token = '';
  int outputVoicebox = 0;

  MLinkedDevice({
    int id,
    String email = '',
    String name = '',
    int blocked = 0,
    String token = '',
    int outputVoicebox = 0,
  }) {
    this.id = id;
    this.email = email;
    this.name = name;
    this.blocked = blocked;
    this.token = token;
    this.outputVoicebox = outputVoicebox;
  }

  factory MLinkedDevice.fromMap(Map<String, dynamic> json) => new MLinkedDevice(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        blocked: json["blocked"],
        token: json["token"],
        outputVoicebox: json["outputVoicebox"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
        "blocked": blocked,
        "token": token,
        "outputVoicebox": outputVoicebox,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "email": email,
        "name": name,
        "blocked": blocked,
        "token": token,
        "outputVoicebox": outputVoicebox,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "email TEXT,"
      "name TEXT,"
      "blocked NUMBER,"
      "token TEXT,"
      "outputVoicebox NUMBER"
      ")";

  static Future<void> createTableIFNotExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery(createTableScript);
  }

  static Future<void> createWithID(MLinkedDevice entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;

    await db.rawInsert(
        "INSERT Into $TableName (id,email,name,blocked,token,outputVoicebox)"
        " VALUES (?,?,?,?,?,?)",
        [
          entity.id,
          entity.email,
          entity.name,
          entity.blocked,
          entity.token,
          entity.outputVoicebox,
        ]);
  }

  static Future<List<MLinkedDevice>> getAll(bool orderById) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName ';
    if (orderById)
      sql += 'ORDER BY id';
    else
      sql += 'ORDER BY name';

    var result = await db.rawQuery(sql);
    List<MLinkedDevice> list = result.isNotEmpty
        ? result.toList().map((c) => MLinkedDevice.fromMap(c)).toList()
        : <MLinkedDevice>[];

    return list;
  }

  static Future<List<MLinkedDevice>> getAllNonBlocked(bool orderById) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE blocked = 0 ';
    if (orderById)
      sql += 'ORDER BY id';
    else
      sql += 'ORDER BY name';

    var result = await db.rawQuery(sql);
    List<MLinkedDevice> list = result.isNotEmpty
        ? result.toList().map((c) => MLinkedDevice.fromMap(c)).toList()
        : <MLinkedDevice>[];

    return list;
  }

  static Future<List<MLinkedDevice>> getDevicesForVoiceboxOutput(
      bool orderById) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE blocked = 0 '
        'AND outputVoicebox = 1 ';
    if (orderById)
      sql += 'ORDER BY id';
    else
      sql += 'ORDER BY name';

    var result = await db.rawQuery(sql);
    List<MLinkedDevice> list = result.isNotEmpty
        ? result.toList().map((c) => MLinkedDevice.fromMap(c)).toList()
        : <MLinkedDevice>[];

    return list;
  }

  static Future<MLinkedDevice> getByID(int id) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE $TableName.id = $id';

    var results = await db.rawQuery(sql);

    if (results.length > 0) {
      MLinkedDevice result = MLinkedDevice.fromMap(results.first);
      return result;
    }

    return null;
  }

  static Future<MLinkedDevice> getByEmail(String email) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE $TableName.email = \'$email\'';

    var results = await db.rawQuery(sql);

    if (results.length > 0) {
      MLinkedDevice result = MLinkedDevice.fromMap(results.first);
      return result;
    }

    return null;
  }

  static Future<void> update(MLinkedDevice entity) async {
    final db = await DBProvider.db.database;
    await db.update("$TableName", entity.toBDMap(),
        where: "id = ?", whereArgs: [entity.id]);
  }

  static Future<void> deleteAll() async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName");
  }

  static Future<void> delete(MLinkedDevice mLinkedDevice) async {
    final db = await DBProvider.db.database;
    await db.rawQuery("delete from $TableName WHERE id=${mLinkedDevice.id}");
  }

  static Future<void> dropTableIfExists() async {
    final db = await DBProvider.db.database;
    await db.rawQuery('DROP TABLE IF EXISTS $TableName');
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
    List<MLinkedDevice> objects = await getAll(true);

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MLinkedDevice list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
