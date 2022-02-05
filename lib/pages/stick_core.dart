import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
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
  static const int btnShowingTimeInMs = 5000;
  bool showBtn = true;
  bool locked = false;
  CancelableOperation timer = CancelableOperation.fromFuture(Future.value());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _runTimer() {
    timer.cancel();
    setState(() {
      showBtn = true;
    });
    timer = CancelableOperation.fromFuture(
        Future.delayed(const Duration(milliseconds: btnShowingTimeInMs), () {
      setState(() {
        showBtn = false;
      });
    }));
  }

  void onFABPressed() {
    setState(() {
      locked = !locked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: InkWell(
          child: PageView(
            physics: locked ? const NeverScrollableScrollPhysics() : null,
            scrollDirection: Axis.horizontal,
            controller: controller,
            children:
                widget.stick.lightList.map((ll) => ll.getWidget()).toList(),
          ),
          onTap: _runTimer),
      floatingActionButton: AnimatedOpacity(
          opacity: showBtn ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            backgroundColor: locked ? const Color(0xFFFAFAFA) : const Color(0xFFE0E0E0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: locked
                ? const Icon(Icons.lock_outline_rounded,
                    color: Color(0xFFFBC02D))
                : const Icon(Icons.lock_open_rounded, color: Colors.grey),
            elevation: 0,
            onPressed: onFABPressed,
          )),
    );
  }
}
