import 'dart:convert';

import 'package:lucas/database/Database.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/models/MObject.dart';

class MQuiz {
  static const String TableName = 'quizzes';

  int id;
  String studentEmail;
  String name;
  int timestamp;
  String quizType;
  String question;
  String answer;
  int isCorrect;
  String concepts;
  int numberOfConcepts;

  static List<MQuiz> inMemoryTable;
  static Map<int, MQuiz> inMemoryDictionary;

  MQuiz({
    int id,
    String studentEmail,
    String name,
    int timestamp,
    String quizType,
    String question,
    String answer,
    int isCorrect,
    String concepts,
    int numberOfConcepts,
  }) {
    this.id = id;
    this.studentEmail = studentEmail;
    this.name = name;
    this.timestamp = timestamp;
    this.quizType = quizType;
    this.question = question;
    this.answer = answer;
    this.isCorrect = isCorrect;
    this.concepts = concepts;
    this.numberOfConcepts = numberOfConcepts;
  }

  factory MQuiz.fromMap(Map<String, dynamic> json) => new MQuiz(
        id: json["id"],
        studentEmail: json["studentEmail"],
        name: json["name"],
        timestamp: json["timestamp"],
        quizType: json["quizType"],
        question: json["question"],
        answer: json["answer"],
        isCorrect: json["isCorrect"],
        concepts: json["concepts"],
        numberOfConcepts: json["numberOfConcepts"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "studentEmail": studentEmail,
        "name": name,
        "timestamp": timestamp,
        "quizType": quizType,
        "question": question,
        "answer": answer,
        "isCorrect": isCorrect,
        "concepts": concepts,
        "numberOfConcepts": numberOfConcepts,
      };

  Map<String, dynamic> toBDMap() => {
        "id": id,
        "studentEmail": studentEmail,
        "name": name,
        "timestamp": timestamp,
        "quizType": quizType,
        "question": question,
        "answer": answer,
        "isCorrect": isCorrect,
        "concepts": concepts,
        "numberOfConcepts": numberOfConcepts,
      };

  static String createTableScript = "CREATE TABLE IF NOT EXISTS $TableName ("
      "id INTEGER PRIMARY KEY,"
      "studentEmail TEXT,"
      "timestamp INTEGER,"
      "quizType TEXT,"
      "question TEXT,"
      "answer TEXT,"
      "isCorrect INTEGER,"
      "concepts TEXT,"
      "numberOfConcepts INTEGER"
      ")";

  static populateInMemoryTables() async {
    if (inMemoryTable == null) {
      final db = await DBProvider.db.database;
      String sql = 'SELECT $TableName.* '
          'FROM $TableName ';
      var result = await db.rawQuery(sql);
      List<MQuiz> list = result.isNotEmpty
          ? result.toList().map((c) => MQuiz.fromMap(c)).toList()
          : <MQuiz>[];

      inMemoryTable = list;
      //inMemoryTable.sort((i1, i2) => i1.textToShow.compareTo(i2.textToShow));

      inMemoryDictionary = new Map();
      for (int i = 0; i < inMemoryTable.length; i++) {
        MQuiz mQuiz = inMemoryTable[i];
        inMemoryDictionary[mQuiz.id] = mQuiz;
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

  static Future<void> createWithID(MQuiz entity) async {
    final db = await DBProvider.db.database;
    // var res = await db.insert("$TableName", entity.toMap());
    // return res;
    await db.rawInsert(
        "INSERT Into $TableName (id, studentEmail, timestamp, quizType, question, answer, isCorrect, concepts, numberOfConcepts)"
        " VALUES (?,?,?,?,?,?,?,?,?)",
        [
          entity.id,
          entity.studentEmail,
          entity.timestamp,
          entity.quizType,
          entity.question,
          entity.answer,
          entity.isCorrect,
          entity.concepts,
          entity.numberOfConcepts,
        ]);

    clearMemoryTables();
  }

  static Future<List<MQuiz>> getAll() async {
    await MQuiz.createTableIFNotExists();
    await populateInMemoryTables();

    return inMemoryTable;
  }

  static Future<MQuiz> getByID(int id) async {
    await populateInMemoryTables();

    return MQuiz.inMemoryDictionary[id];
  }

  static Future<List<dynamic>> search(
      String studentEmail, int numberOfConcepts, String textToSearch) async {
    await MQuiz.createTableIFNotExists();

    final db = await DBProvider.db.database;
    String sql = 'SELECT DISTINCT $TableName.concepts '
        'FROM $TableName '
        'WHERE studentEmail = "$studentEmail" ';
    if (numberOfConcepts == 1) {
      sql += '  AND numberOfConcepts = 1 ';
    }
    if (numberOfConcepts == 2) {
      sql += '  AND numberOfConcepts = 2 ';
    }
    if (numberOfConcepts == 3) {
      sql += '  AND numberOfConcepts >= 3 ';
    }
    if (textToSearch.isNotEmpty) {
      sql += '  AND concepts LIKE "%$textToSearch%" ';
    }
    sql += 'ORDER BY concepts';

    var result = await db.rawQuery(sql);

    return result;
  }

  static Future<List<MQuiz>> searchExact(
      String studentEmail, int numberOfConcepts, String concept) async {
    final db = await DBProvider.db.database;
    String sql = 'SELECT $TableName.* '
        'FROM $TableName '
        'WHERE studentEmail = "$studentEmail" ';
    if (numberOfConcepts == 1) {
      sql += '  AND numberOfConcepts = 1 ';
    }
    if (numberOfConcepts == 2) {
      sql += '  AND numberOfConcepts = 2 ';
    }
    if (numberOfConcepts == 3) {
      sql += '  AND numberOfConcepts >= 3 ';
    }
    sql += '  AND concepts = "$concept" ';
    sql += 'ORDER BY timestamp';

    var result = await db.rawQuery(sql);
    List<MQuiz> list = result.isNotEmpty
        ? result.toList().map((c) => MQuiz.fromMap(c)).toList()
        : <MQuiz>[];

    return list;
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

  static Future<int> maxId() async {
    await MQuiz.createTableIFNotExists();

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
    List<MQuiz> objects = await getAll();

    //String jsonEntity = jsonEncode(objects);
    String json = jsonEncode({
      "email": strUserEmail,
      "name": strUserName,
      "operation": "upload MQuiz list",
      "objects": objects,
    });

    return await Helper.invokeWebService(json);
  }
}
