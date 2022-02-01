import 'dart:ui';

class Light {
  String stickId;
  int index;
  String name;
  Color color;

  Light(
      {required this.stickId,
      required this.index,
      required this.name,
      required this.color});
  Light.asDefaultValue()
      : name = "",
        color = const Color.fromARGB(0, 0, 0, 0),
        stickId = "00000000-0000-0000-0000-000000000000",
        index = -1;

  Map<String, dynamic> toMap() {
    return {
      'stick_id': stickId,
      'index': index,
      'name': name,
      'color': color.value
    };
  }
}
