// @dart=2.9
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:lucas/models/MCategory.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/Translation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  var logger = Logger(
    printer: PrettyPrinter(),
  );


  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "lucas.db");
    //String path = "assets/db/dic.db";

    return await openDatabase(
      path,
      version: 6,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        db.rawQuery(Translation.createTableScript);
        db.rawQuery(MImage.createTableScript);
        db.rawQuery(MCategory.createTableScript);
        db.rawQuery(MFolder.createTableScript);
        db.rawQuery(MRelation.createTableScript);
        db.rawQuery(MEmpty.createTableScript);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // if (newVersion == 5) {
        //   await Category.dropTableIfExists();
        //   await Translation.dropTableIfExists();

        //   await db.execute(Category.createTableScript());
        //   await db.execute(Translation.createTableScript());

        //   await Category.populateFromJson(false);
        // }
      },
    );
  }
}
