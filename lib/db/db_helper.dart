import 'package:flutter/material.dart';

import '../models/light.dart';
import '../models/stick.dart';
import 'db_provider.dart';

extension DbHelperOnSticks on DbProvider {
  Future<List<Stick>> getSticks({bool includeLights = false}) async {
    if (includeLights) {
      throw Exception("Not Implemented. : getSticks with Lights");
    }

    var db = await getDb();
    final List<Map<String, dynamic>> maps =
        await db.query('sticks', columns: ['id', 'name', 'type']);

    return List.generate(maps.length, (i) {
      return Stick(
          id: maps[i]['id'],
          name: maps[i]['name'],
          type: maps[i]['type'],
          lightList: []);
    });
  }

  Future insertStick(Stick stick) async {
    var db = await getDb();

    await db.transaction((txn) async {
      await txn.insert('sticks', stick.toMap());
      var lightQueryOpers =
          stick.lightList.map((light) => txn.insert('lights', light.toMap()));
      Future.wait(lightQueryOpers);
    });
  }
}

extension DbHelperOnLights on DbProvider {
  Future<List<Light>> getLightsByStickId({required String stickId}) async {
    var db = await getDb();
    final List<Map<String, dynamic>> maps =
        await db.query('lights', where: '"stick_id" = ?', whereArgs: [stickId]);
    return List.generate(maps.length, (i) {
      return Light(
          stickId: maps[i]['stick_id'],
          name: maps[i]['name'],
          idx: maps[i]['index'],
          color: Color(maps[i]['color']));
    });
  }
}
