import 'package:flutter/cupertino.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String? desc;
  final void Function(String value) onOk;
  final void Function() onCancel;

  const InputDialog({
    Key? key,
    required this.title,
    this.desc,
    required this.onOk,
    required this.onCancel,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _InputDialog();
}

class _InputDialog extends State<InputDialog> {
  var text = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Column(children: [
        if (widget.desc != null) Text(widget.desc!),
        CupertinoTextField(placeholder: '仓库名', onChanged: (str) {
          setState(() {
            text = str.trim();
          });
        }),
      ]),
      actions: [
        CupertinoDialogAction(child: Text('取消'), onPressed: () {
          widget.onCancel();
        }),
        CupertinoDialogAction(child: Text('确定'), isDefaultAction: true, onPressed: text.length > 0 ? () {
          widget.onOk(text);
        } : null),
      ],
    );
  }
}

Future<String?> showInputDialog(BuildContext context, { required String title, String? desc }) {
  return showCupertinoDialog<String?>(context: context, builder: (ctx) => InputDialog(
    title: title,
    desc: desc,
    onOk: (String value) {
      Navigator.pop(ctx, value);
    },
    onCancel: () {
      Navigator.pop(ctx, null);
    }
  ));
}
