import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yank_note/views/repos.dart';

class Borowser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Borowser();
}

class _Borowser extends State<Borowser> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Navigator(
        initialRoute: '/repos',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/repos':
              return CupertinoPageRoute(builder: (BuildContext ctx) => Repos());
            default:
              return null;
          }
        },
      )
    );
  }
}
