import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yank_note/views/layout.dart';

void main() {
  runApp(YankNoteApp());
}

class YankNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Yank Note',
      home: Layout(),
    );
  }
}
