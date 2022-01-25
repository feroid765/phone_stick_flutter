import 'package:tuple/tuple.dart';

import '../models/stick.dart';
import 'db_provider.dart';

extension DbHelper on DbProvider {
  Future<List<Stick>> getStickAbstractions() async {
    var queryResult = await secureSelectQuery("SELECT id, name FROM stick");
    return queryResult.map((single) => (Stick.fromMap(single))).toList();
  }

  Future insertStick(Stick stick) async {
    List<Tuple2<String, dynamic>> queryParamPairs = [];

    queryParamPairs.add(Tuple2(
        "INSERT INTO stick(id, name, type) VALUES (?, ?, ?)",
        [stick.id, stick.name, stick.type]));

    for (var idx = 0; idx < stick.lightList.length; idx++) {
      var light = stick.lightList[idx];
      queryParamPairs.add(Tuple2(
          "INSERT INTO light(stick_id, index, color, name) VALUES (?, ?, ?, ?)",
          [stick.id, idx, light.color.toString(), light.name]));
    }
    await secureInsertQueries(queryParamPairs);
  }
}
