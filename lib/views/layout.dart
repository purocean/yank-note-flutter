
import 'package:flutter/cupertino.dart';
import 'package:yank_note/views/file_tree.dart';

List _views = [
  CupertinoPageScaffold(
    child: Center(
      child: FileTree()
    ),
  ),
  CupertinoPageScaffold(
    child: Center(
      child: const Text('编辑'),
    ),
  ),
  CupertinoPageScaffold(
    child: Center(
      child: const Text('预览'),
    ),
  ),
];

class Layout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Layout();
}

class _Layout extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        border: null,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc_on_doc)),
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
