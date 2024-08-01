import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yank_note/services/state.dart';
import 'package:yank_note/views/layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const YankNoteApp());
}

class YankNoteApp extends StatelessWidget {
  const YankNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => appState,
      child: const CupertinoApp(
        title: 'Yank Note',
        home: Layout(),
      )
    );
  }
}
