import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/light.dart';
import '../models/stick.dart';
import 'db_provider.dart';

extension DbHelperOnSticks on DbProvider {
  Future<List<Stick>> getSticks({bool includeLights = false}) async {
    var db = await getDb();
    final List<Map<String, dynamic>> maps =
        await db.query('sticks', columns: ['id', 'name', 'type']);

    Map<String, Stick> idToStick = {};

    for (var map in maps) {
      final Stick stick = Stick(
          id: map['id'], name: map['name'], type: map['type'], lightList: []);
      idToStick[stick.id] = stick;
    }

    if (includeLights) {
      final List<Map<String, dynamic>> lightMaps =
          await db.query('lights', orderBy: 'stick_id, idx');

      for (var map in lightMaps) {
        final Light light = Light(
            stickId: map['stick_id'],
            idx: map['idx'],
            color: Color(map['color']),
            name: map['name']);
        idToStick[light.stickId]!.lightList.add(light);
      }
    }

    return idToStick.values.toList();
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
