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
}
