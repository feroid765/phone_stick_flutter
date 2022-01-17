import 'light.dart';

class Stick {
  String id;
  String name;
  List<Light> lightList;
  String type;

  Stick(this.id, this.name, this.lightList, this.type);
  Stick.asDefaultValue()
      : id = "",
        name = "",
        lightList = [],
        type = "";
  Stick.fromMap(Map<String, Object?> map)
      : id = map["id"].toString(),
        name = map["name"].toString(),
        lightList = [],
        type = "";
}
