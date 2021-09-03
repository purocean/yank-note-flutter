import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yank_note/models/app_state.dart';
import 'package:yank_note/views/layout.dart';
import 'package:yank_note/store/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final store = await getStore();

  runApp(YankNoteApp(store));
}

class YankNoteApp extends StatelessWidget {
  final store;
  YankNoteApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: CupertinoApp(
        title: 'Yank Note',
        home: Layout(),
      )
    );
  }
}
