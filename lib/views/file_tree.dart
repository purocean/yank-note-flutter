import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileTree();
}

class _FileTree extends State<FileTree> {
  static const platform = const MethodChannel('yank-note-message-channel');

  String _path = '未选择';

  Future<Null> _pickFloder() async {
    String path;
    try {
      path = await platform.invokeMethod('pick-folder');
    } on PlatformException catch (e) {
      path = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _path = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(children: [
        CupertinoButton(child: Text('添加仓库'), onPressed: () {
          Fluttertoast.showToast(msg: '选择成功');
          _pickFloder();
        }),
        Text(_path),
      ]),
    );
  }
}
