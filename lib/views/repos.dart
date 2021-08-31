import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yank_note/helper.dart';
import 'package:yank_note/widgets/input_dialog.dart';

class Repos extends StatefulWidget {
  @override
  State<StatefulWidget> createState () => _Repos();

}

class _Repos extends State<Repos> {
  Future<Null> _pickFloder(BuildContext ctx) async {
    String path;
    try {
      path = await Helper.platform.invokeMethod('pick-folder');
    } on PlatformException catch (e) {
      path = "Failed to get battery level: '${e.message}'.";
    }

    final name = await showInputDialog(ctx, title: '添加仓库', desc: '请输入仓库名');
    if (name != null) {
      Fluttertoast.showToast(msg: name);
    }

    // final file = File(path.replaceFirst("file://", "") + '/test.txt');
    // final x = file.readAsStringSync();
  }

  Widget _buildRepos (BuildContext ctx) {
    final data = List.generate(4, (i) => i);

    if (data.length > 0) {
      return Center(child:
        CupertinoButton(child: Text('添加仓库'), onPressed: () {
          _pickFloder(ctx);
        }),
      );
    }

    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text(
              '仓库',
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.w500)
            ),
          ),
          Card(
            elevation: 1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: data.map((e) => Slidable(
                key: Key(e.toString()),
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  IconSlideAction(
                    color: CupertinoColors.systemGrey,
                    icon: CupertinoIcons.ellipsis,
                    onTap: () => {},
                  ),
                  IconSlideAction(
                    color: CupertinoColors.systemRed,
                    icon: CupertinoIcons.delete,
                    onTap: () => {},
                  ),
                ],
                child: Container(
                  // height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: CupertinoColors.separator))),
                  child: ListTile(
                    dense: true,
                    leading: Icon(CupertinoIcons.tray, color: CupertinoColors.link),
                    title: Container(
                      child: Text('xxxx'),
                    ),
                    focusColor: Colors.red,
                    onTap: () {

                    },
                  ),
                ),
              )).toList(),
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(color: CupertinoColors.secondarySystemBackground, child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          CupertinoSliverNavigationBar(
            largeTitle: Text('浏览'),
            backgroundColor: CupertinoColors.secondarySystemBackground.withOpacity(0.5),
            trailing: GestureDetector(onTap: () {  }, child: Icon(CupertinoIcons.ellipsis_circle))
          )
        ];
      },
      body: Column(children: [
        Container(
          height: MediaQuery.of(ctx).size.height,
          child: ListView(
            children: [
              Column(
                children: [ _buildRepos(ctx) ],
              )
            ]
          )
        )
      ]),
    ));
  }
}
