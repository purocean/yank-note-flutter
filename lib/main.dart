import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yank_note/views/layout.dart';
import 'package:yank_note/store/store.dart';

void main() {
  runApp(YankNoteApp());
}

final store = getStore();

class YankNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: CupertinoApp(
        title: 'Yank Note',
        home: Layout(),
      )
    );
  }
}
