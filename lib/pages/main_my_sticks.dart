import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../db/db_provider.dart';
import '../models/stick.dart';
import 'stick_core.dart';

extension LightToWidget on Stick {
  ListTile getWidget(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StickView(stick: this)));
      },
    );
  }
}

class MySticksPage extends StatefulWidget {
  const MySticksPage({Key? key}) : super(key: key);
  @override
  MySticksPageState createState() => MySticksPageState();
}

class MySticksPageState extends State<MySticksPage> {
  List<Stick> sticks = [];

  List<Widget> _getListItems() {
    return sticks.map((stick) => Text(stick.name)).toList();
  }

  void getSticks() async {
    var dbProvider = DbProvider();
    var result = await dbProvider.getSticks();
    setState(() {
      sticks = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getSticks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _getListItems());
  }
}
