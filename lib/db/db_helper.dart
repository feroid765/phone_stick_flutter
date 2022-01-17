import 'dart:convert';
import '../models/light.dart';
import '../models/stick.dart';
import 'db_provider.dart';

extension DbHelper on DbProvider {
  Future<List<Stick>> getStickAbstractions() async {
    var queryResult = await secureSelectQuery("SELECT id, name FROM stick");
    return queryResult.map((single) => (Stick.fromMap(single))).toList();
  }

  Future insertStick(Stick stick) async {
    await secureInsertQuery(
        "INSERT INTO stick(id, name, light_list, type) VALUES (?, ?, ?, ?)",
        [stick.id, stick.name, jsonEncode(stick.lightList), stick.type]);
  }
}
