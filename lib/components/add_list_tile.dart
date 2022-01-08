import 'package:flutter/material.dart';

ListTile addListTile(GestureTapCallback? func) {
  return ListTile(
      title: const Text('추가하기'), leading: const Icon(Icons.add), onTap: func);
}
