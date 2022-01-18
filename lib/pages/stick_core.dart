import 'package:flutter/material.dart';

import '../models/light.dart';
import '../models/stick.dart';

extension LightToWidget on Light {
  Widget getWidget() {
    return Container(color: color);
  }
}

class StickView extends StatefulWidget {
  final Stick stick;

  const StickView({Key? key, required this.stick}) : super(key: key);

  @override
  _StickViewState createState() => _StickViewState();
}

class _StickViewState extends State<StickView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: widget.stick.lightList.map((ll) => ll.getWidget()).toList(),
    );
  }
}
