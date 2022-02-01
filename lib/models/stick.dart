import 'light.dart';
import 'package:uuid/uuid.dart';

class Stick {
  String id;
  String name;
  List<Light> lightList;
  String type;

  Stick(
      {required this.id,
      required this.name,
      required this.lightList,
      required this.type});

  Stick.asDefaultValue()
      : id = const Uuid().v4(),
        name = "",
        lightList = [],
        type = "";

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'type': type};
  }
}
