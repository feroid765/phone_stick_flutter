import '../models/light.dart';
import '../models/stick.dart';
import 'db_provider.dart';

extension DbHelper on DbProvider {
  Future<List<Stick>> getStickAbstractions() async {
    var queryResult = await secureQuery("SELECT id, name FROM stick");
    return queryResult.map((single) => (Stick.fromMap(single))).toList();
  }
}
