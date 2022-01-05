import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database? db;
  static const String fileName = 'feroid_phone-stick_database.db';

  DbProvider();

  static Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE stick(id TEXT PRIMARY KEY, name TEXT NOT NULL, light_list TEXT NOT NULL)');
  }

  Future _connect() async {
    if (db?.isOpen == true) return;
    var databasePath = await getDatabasesPath();
    var fullPath = path.join(databasePath, fileName);

    db = await openDatabase(fullPath, version: 1, onCreate: _onCreate);
  }

  Future<List<Map<String, Object?>>> secureQuery(String query) async {
    _connect();

    return await db!.rawQuery(query);
  }

  static Future<DbProvider> create() async {
    var result = DbProvider();
    await result._connect();

    return result;
  }
}
