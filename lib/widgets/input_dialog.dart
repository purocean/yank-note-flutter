import 'package:flutter/cupertino.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String? desc;
  final String? defaultValue;
  final void Function(String value) onOk;
  final void Function() onCancel;

  const InputDialog({
    super.key,
    required this.title,
    this.desc,
    this.defaultValue,
    required this.onOk,
    required this.onCancel,
  });

  @override
  State<StatefulWidget> createState() => _InputDialog();
}

class _InputDialog extends State<InputDialog> {
  String text = '';
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    text = widget.defaultValue ?? '';
    _textController = TextEditingController(text: text);
    _textController.selection = TextSelection(baseOffset: 0, extentOffset: _textController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Column(children: [
        if (widget.desc != null) Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(widget.desc!),
        ),
        CupertinoTextField(
          placeholder: '仓库名',
          maxLength: 20,
          controller: _textController,
          autofocus: true,
          onChanged: (str) {
            setState(() {
              text = str.trim();
            });
          }
        ),
      ]),
      actions: [
        CupertinoDialogAction(child: const Text('取消'), onPressed: () {
          widget.onCancel();
        }),
        CupertinoDialogAction(isDefaultAction: true, onPressed: text.isNotEmpty ? () {
          widget.onOk(text);
        } : null, child: const Text('确定')),
      ],
    );
  }
}

Future<String?> showInputDialog(
    BuildContext context, {
      required String title,
      String? desc,
      String? defaultValue
    }) {
  return showCupertinoDialog<String?>(context: context, builder: (context) => InputDialog(
    title: title,
    desc: desc,
    defaultValue: defaultValue,
    onOk: (String value) {
      Navigator.pop(context, value);
    },
    onCancel: () {
      Navigator.pop(context, null);
    }
  ));
}
