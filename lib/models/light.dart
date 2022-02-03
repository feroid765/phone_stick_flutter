import 'dart:ui';

class Light {
  String stickId;
  int idx;
  String name;
  Color color;

  Light(
      {required this.stickId,
      required this.idx,
      required this.name,
      required this.color});
  Light.asDefaultValue()
      : name = "",
        color = const Color.fromARGB(0, 0, 0, 0),
        stickId = "00000000-0000-0000-0000-000000000000",
        idx = -1;

  Map<String, dynamic> toMap() {
    return {
      'stick_id': stickId,
      'idx': idx,
      'name': name,
      'color': color.value
    };
  }
}
