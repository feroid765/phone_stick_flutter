import 'dart:ui';

class Light {
  String name;
  Color color;

  Light(this.name, this.color);
  Light.asDefaultValue()
      : name = "",
        color = const Color.fromARGB(0, 0, 0, 0);
}
