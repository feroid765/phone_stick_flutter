import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? db;
  static const String fileName = 'feroid_phone-stick_database.db';

  DbProvider();

  static Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE stick(id TEXT PRIMARY KEY, name TEXT NOT NULL, type TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE light(stick_id TEXT REFERENCES stick(id), index INT NOT NULL, color INT NOT NULL, name TEXT NOT NULL, PRIMARY KEY(stick_id, index))');
    await db.execute('CREATE INDEX light_name_index ON light(stick_id)');
  }

  Future _connect() async {
    if (db?.isOpen == true) return;
    var databasePath = await getDatabasesPath();
    var fullPath = path.join(databasePath, fileName);

    db = await openDatabase(fullPath, version: 1, onCreate: _onCreate);
  }

  Future<Database> getDb() async {
    await _connect();
    return db!;
  }
}
