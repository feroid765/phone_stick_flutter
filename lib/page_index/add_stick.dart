import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main_my_sticks.dart';

class AddStickPage extends StatefulWidget {
  const AddStickPage({Key? key}) : super(key: key);
  @override
  _AddStickPageState createState() => _AddStickPageState();
}

class _AddStickPageState extends State<AddStickPage>{

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
      body: const Text('Hi'),
    );
  }
}