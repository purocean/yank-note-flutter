import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yank_note/views/files.dart';
import 'package:yank_note/views/repos.dart';

class Borowser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Navigator(
        initialRoute: '/repos',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/repos':
              return CupertinoPageRoute(builder: (context) => Repos());
            case '/files':
              return CupertinoPageRoute(builder: (context) => Files(arguments: settings.arguments as Map));
            default:
              return null;
          }
        },
      )
    );
  }
}
