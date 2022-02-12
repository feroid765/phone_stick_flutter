import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phone_stick_flutter/db/db_helper.dart';
import 'package:phone_stick_flutter/db/db_provider.dart';

import '../components/add_list_tile.dart';
import '../models/light.dart';
import '../models/stick.dart';

enum AlertDialogMode { add, modify }

class AlertDialogParam {
  final AlertDialogMode alertDialogMode;
  final Light? light;

  const AlertDialogParam(this.alertDialogMode, this.light);
}

class AddStickPage extends StatefulWidget {
  const AddStickPage({Key? key}) : super(key: key);

  @override
  _AddStickPageState createState() => _AddStickPageState();
}

class _AddStickPageState extends State<AddStickPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Stick _stick = Stick.asDefaultValue();
  String _lightName = "";

  final GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();
  Color _pickerColor = const Color.fromARGB(255, 255, 255, 255);

  void _changeColor(Color color) {
    color = color.withAlpha(255);
    setState(() => _pickerColor = color);
  }

  void _addLight(String name) {
    Light newLight =
        Light(stickId: _stick.id, idx: -1, name: name, color: _pickerColor);
    setState(() => _stick.lightList.add(newLight));
  }

  void _modifyLight(String name, Light light) {
    setState(() {
      light.color = _pickerColor;
      light.name = name;
    });
  }

  void _removeLight(Light target) {
    setState(() {
      _stick.lightList.remove(target);
    });
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
      _stick.name = value;
      return null;
    }
  }

  AlertDialog _addModifyDialog(BuildContext context, AlertDialogParam param) {
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
                    validator: _onLightValidate,
                    initialValue: param.light?.name,
                  ),
                  const Divider(),
                  const Text('색깔 선택'),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: HueRingPicker(
                          pickerColor: _pickerColor,
                          enableAlpha: false,
                          onColorChanged: _changeColor)),
                  TextButton(
                    child: param.alertDialogMode == AlertDialogMode.add
                        ? const Text('색깔 추가하기')
                        : const Text('색깔 수정하기'),
                    onPressed: () {
                      if (_dialogFormKey.currentState!.validate()) {
                        if (param.alertDialogMode == AlertDialogMode.add) {
                          _addLight(_lightName);
                        } else {
                          _modifyLight(_lightName, param.light!);
                        }
                        Navigator.pop(context);
                      }
                    },
                  )
                ]))));
  }

  AlertDialog _deleteAlertDialog(BuildContext context, Light light) {
    return AlertDialog(
        title: const Text('추가할 색깔 선택하기'),
        content: Text('정말 "${light.name}" 색깔을 삭제하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('삭제'),
            onPressed: () {
              _removeLight(light);
              Navigator.pop(context);
            },
          )
        ]);
  }

  void _onAddBtnPressed() {
    if (_formKey.currentState!.validate()) {
      var dbProvider = DbProvider();
      _stick.lightList.asMap().forEach((idx, light) => {light.idx = idx});
      dbProvider.insertStick(_stick);
      Navigator.pop(context);
    }
  }

  Widget getLightWidget(Key key, Light light, BuildContext context) {
    return ListTile(
      key: key,
      title: Text(light.name),
      leading: Container(height: 24.0, width: 24.0, color: light.color),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.pen),
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) => _addModifyDialog(
                    context, AlertDialogParam(AlertDialogMode.modify, light)));
          },
        ),
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => _deleteAlertDialog(context, light));
            })
      ]),
    );
  }

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
        appBar: AppBar(title: const Text('폰광봉 만들기'), actions: <Widget>[
          TextButton(
            child: const Text('완료'),
            onPressed: _onAddBtnPressed,
          )
        ]),
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
                    Flexible(
                        child: ReorderableListView(
                            shrinkWrap: true,
                            onReorder: (int oldIndex, int newIndex) {},
                            children: _stick.lightList
                                .asMap()
                                .entries
                                .map((MapEntry mapEntry) => getLightWidget(
                                    Key(mapEntry.key.toString()),
                                    mapEntry.value as Light,
                                    context))
                                .toList())),
                    addListTile(() async {
                      await showDialog(
                          context: context,
                          builder: (context) => _addModifyDialog(
                              context,
                              const AlertDialogParam(
                                  AlertDialogMode.add, null)));
                    })
                  ])),
        ));
  }
}
