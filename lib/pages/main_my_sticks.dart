import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../db/db_helper.dart';
import '../db/db_provider.dart';
import '../models/stick.dart';
import '../pages/add_modify_stick.dart';
import 'stick_core.dart';

extension LightToWidget on Stick {
  ListTile getWidget(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StickView(stick: this)));
      },
      trailing: IconButton(
        icon: const FaIcon(FontAwesomeIcons.pen),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddModifyStickPage(
                      param: PageParam(PageMode.modify, this))));
        },
      ),
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

  List<Widget> _getListItems(BuildContext context) {
    return sticks.map((stick) => stick.getWidget(context)).toList();
  }

  void getSticks() async {
    var dbProvider = DbProvider();
    var result = await dbProvider.getSticks(includeLights: true);
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
    return ListView(children: _getListItems(context));
  }
}
