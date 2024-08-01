
import 'package:flutter/cupertino.dart';
import 'package:yank_note/views/browser.dart';

List _views = [
  const Browser(),
  const CupertinoPageScaffold(
    child: Center(
      child: Text('编辑'),
    ),
  ),
  const CupertinoPageScaffold(
    child: Center(
      child: Text('预览'),
    ),
  ),
];

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        border: null,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.folder)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.pencil_circle)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.eye)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _views[index];
          },
        );
      },
    );
  }
}
