import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../db/db_helper.dart';
import '../db/db_provider.dart';
import '../models/stick.dart';
import '../pages/add_modify_stick.dart';
import 'stick_core.dart';

void _deleteStick(Stick stick) async {
  var dbProvider = DbProvider();
  await dbProvider.deleteStick(stick);
}

AlertDialog _deleteAlertDialog(
    BuildContext context, Stick stick, Function callback) {
  return AlertDialog(
      content: Text('정말 "${stick.name}" 폰광봉을 삭제하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          child: const Text('취소'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('삭제'),
          onPressed: () {
            _deleteStick(stick);
            callback();
            Navigator.pop(context);
          },
        )
      ]);
}

extension LightToWidget on Stick {
  ListTile getWidget(BuildContext context, Function callback) {
    return ListTile(
        title: Text(name),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StickView(stick: this)));
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.pen),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddModifyStickPage(
                            param: PageParam(PageMode.modify, this))));
              },
            ),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) =>
                          _deleteAlertDialog(context, this, callback));
                })
          ],
        ));
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
    return sticks.map((stick) => stick.getWidget(context, getSticks)).toList();
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
