import 'light.dart';

class Stick {
  String id;
  String name;
  List<Light> lightList;

  Stick(this.id, this.name, this.lightList);
  Stick.asDefaultValue()
      : id = "",
        name = "",
        lightList = [];
  Stick.fromMap(Map<String, Object?> map)
      : id = map["id"].toString(),
        name = map["name"].toString(),
        lightList = [];
}
