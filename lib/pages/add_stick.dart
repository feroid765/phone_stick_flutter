import 'package:flutter/material.dart';

import '../components/add_list_tile.dart';
import '../models/light.dart';

extension LightToWidget on Light {
  ListTile getWidget() {
    return ListTile(
        title: Text(name),
        leading: Container(height: 24.0, width: 24.0, color: color));
  }
}

class AddStickPage extends StatefulWidget {
  const AddStickPage({Key? key}) : super(key: key);

  @override
  _AddStickPageState createState() => _AddStickPageState();
}

class _AddStickPageState extends State<AddStickPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Light> _lightList = [];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('폰광봉 만들기'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('폰광봉 이름'),
                TextFormField(
                    decoration:
                        const InputDecoration(hintText: "폰광봉의 이름을 입력해주세요!")),
                const Divider(),
                const Text('색깔 목록'),
                ListView(
                    children: _lightList.map((ll) => ll.getWidget()).toList() +
                        [addListTile(null)])
              ])),
    );
  }
}
