import 'dart:async';

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;
  int dbVersion =
      10; //change the version,when you make changes to the  database before push

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  // _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < newVersion) {
  //     await db.execute("DROP TABLE IF EXISTS ${Constant.studentId}");
  //     _onCreate(db, newVersion);
  //   }
  // }

  initDB() async {
    //getApplicationDocumentsDirectory
//    Directory documentsDirectory = await getDatabasesPath();
//    String path = join(documentsDirectory.path, "myApp.db");
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'myApp.db');
    return await openDatabase(
      path,
      version: dbVersion,
      onOpen: (db) {},
      // onUpgrade: _onUpgrade,
      // onCreate: _onCreate,
    );
  }
}
