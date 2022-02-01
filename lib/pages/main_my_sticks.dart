import 'package:flutter/material.dart';
import '../db/db_provider.dart';
import '../db/db_helper.dart';
import '../models/stick.dart';
import '../models/light.dart';
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
    var result = await dbProvider.getSticks();
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
