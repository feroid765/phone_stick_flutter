import 'package:flutter/material.dart';
import '../db/db_provider.dart';
import '../db/db_helper.dart';
import '../models/stick.dart';

// ignore: use_key_in_widget_constructors
class MySticksPage extends StatefulWidget {
  @override
  _MySticksPageState createState() => _MySticksPageState();
}

class _MySticksPageState extends State<MySticksPage>
    with AutomaticKeepAliveClientMixin<MySticksPage> {
  List<Stick> sticks = [];

  List<Widget> _getListItems() {
    return sticks.map((stick) => Text(stick.name)).toList();
  }

  void _getSticks() async {
    var dbProvider = DbProvider();
    var result = await dbProvider.getStickAbstractions();
    setState(() {
      sticks = result;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getSticks();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(children: _getListItems());
  }
}
