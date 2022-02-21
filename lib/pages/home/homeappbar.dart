import 'dart:async';

import 'package:flutter/material.dart';

AppBar buildAppBar(
  StreamController<dynamic> _myStream,
  int countUsers,
  bool _checkedMale,
  bool _checkedFemale,
  void Function() _onFiltredList,
  void Function() reset,
) {
  return AppBar(
    title: StreamBuilder<dynamic>(
        stream: _myStream.stream,
        builder: (context, snapshot) {
          return Text('Users:  ${countUsers}');
        }),
    actions: [
      Row(
        children: [
          StreamBuilder<dynamic>(
              stream: _myStream.stream,
              builder: (context, snapshot) {
                return Checkbox(
                  value: _checkedFemale,
                  onChanged: (value) {
                    _checkedFemale = value ?? _checkedFemale;
                    _onFiltredList();
                  },
                );
              }),
          const Text("Female"),
        ],
      ),
      const SizedBox(width: 15),
      Row(
        children: [
          StreamBuilder<dynamic>(
              stream: _myStream.stream,
              builder: (context, snapshot) {
                return Checkbox(
                  value: _checkedMale,
                  onChanged: (value) {
                    _checkedMale = value ?? _checkedMale;
                    _onFiltredList();
                  },
                );
              }),
          const Text("Male"),
        ],
      ),
      const SizedBox(width: 50),
      IconButton(
        onPressed: () {
          reset();
        },
        icon: const Icon(Icons.restart_alt_rounded),
      ),
      const SizedBox(width: 10),
    ],
  );
}
