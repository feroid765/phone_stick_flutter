import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  String _stickName = "";
  String _lightName = "";
  List<Light> _lightList = [];

  final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();
  Color _pickerColor = Color.fromARGB(255, 255, 255, 255);

  void _changeColor(Color color) {
    color = color.withAlpha(255);
    setState(() => _pickerColor = color);
  }

  void _addLight(String name) {
    Light newLight = Light(name, _pickerColor);
    setState(() => _lightList.add(newLight));
  }

  String? _onLightValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "색깔의 이름은 필수로 입력해야 합니다.";
    } else {
      _lightName = value;
      return null;
    }
  }

  String? _onStickValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "폰광봉의 이름은 필수로 입력해야 합니다.";
    } else {
      _stickName = value;
      return null;
    }
  }

  AlertDialog _alertDialogBuilder(BuildContext context) {
    return AlertDialog(
        title: const Text('추가할 색깔 선택하기'),
        content: Form(
            key: _dialogFormKey,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  const Text('색깔 이름'),
                  TextFormField(
                      decoration: const InputDecoration(
                          hintText: "캐릭터 이름, 유닛 이름등의 색깔 이름을 입력해주세요!"),
                      validator: _onLightValidate),
                  const Divider(),
                  const Text('색깔 선택'),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: HueRingPicker(
                          pickerColor: _pickerColor,
                          enableAlpha: false,
                          onColorChanged: _changeColor)),
                  TextButton(
                    child: const Text('추가하기'),
                    onPressed: () {
                      if (_dialogFormKey.currentState!.validate()) {
                        _addLight(_lightName);
                        Navigator.pop(context);
                      }
                    },
                  )
                ]))));
  }

  late AlertDialog _alertDialog;

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
        body: Container(
          margin: const EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('폰광봉 이름'),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "폰광봉의 이름을 입력해주세요!"),
                      validator: _onStickValidate,
                    ),
                    const Divider(),
                    const Text('색깔 목록'),
                    Expanded(
                        child: ListView(
                            children: _lightList
                                    .map((ll) => ll.getWidget())
                                    .toList() +
                                [
                                  addListTile(() async {
                                    await showDialog(
                                        context: context,
                                        builder: _alertDialogBuilder);
                                  })
                                ]))
                  ])),
        ));
  }
}
