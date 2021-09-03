import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';
import 'package:yank_note/helper.dart';
import 'package:yank_note/models/repository.dart';
import 'package:yank_note/store/actions.dart';
import 'package:yank_note/store/store.dart';
import 'package:yank_note/widgets/input_dialog.dart';

class Repos extends StatefulWidget {
  @override
  State<StatefulWidget> createState () => _Repos();
}

class _Repos extends State<Repos> {
  _addRepo(BuildContext context) async {
    String path;
    try {
      path = await Helper.platform.invokeMethod('pick-folder');
    } on PlatformException catch (e) {
      path = "Failed to get battery level: '${e.message}'.";
    }

    final name = await showInputDialog(
      context,
      title: '添加仓库',
      desc: '请输入仓库名',
      defaultValue: basename(path)
    );
    if (name != null) {
      (await getStore()).dispatch(ActionCreateRepo(Repo(name: name, path: path)));
    }
  }

  _renameRepo(BuildContext context, Repo repo) async {
    final name = await showInputDialog(
      context,
      title: '修改仓库名',
      desc: '请输入新名字',
      defaultValue: basename(repo.name)
    );

    if (name != null) {
      (await getStore()).dispatch(ActionRenameRepo(repo, name));
    }
  }

  Widget _buildRepos (BuildContext context) {
    return AppStoreConnector(builder: (context, store) {
      if (store.state.repos.length < 1) {
        return Center(child: CupertinoButton(child: Text('添加仓库'), onPressed: () {
          _addRepo(context);
        }));
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
                children: store.state.repos.map((repo) => Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: [
                    IconSlideAction(
                      color: CupertinoColors.systemGrey,
                      icon: CupertinoIcons.ellipsis,
                      onTap: () => {
                        _renameRepo(context, repo)
                      },
                    ),
                    IconSlideAction(
                      color: CupertinoColors.systemRed,
                      icon: CupertinoIcons.delete,
                      onTap: () => {
                        store.dispatch(ActionRemoveRepo(repo))
                      },
                    ),
                  ],
                  child: Container(
                    // height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: CupertinoColors.separator))),
                    child: ListTile(
                      dense: true,
                      leading: Icon(CupertinoIcons.tray, color: CupertinoColors.link),
                      trailing: Icon(CupertinoIcons.right_chevron),
                      title: Container(
                        child: Text(repo.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: CupertinoColors.secondarySystemBackground, child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          CupertinoSliverNavigationBar(
            largeTitle: Text('浏览'),
            backgroundColor: CupertinoColors.secondarySystemBackground.withOpacity(0.5),
            trailing: GestureDetector(onTap: () {
              _addRepo(context);
            }, child: Icon(CupertinoIcons.add_circled))
          )
        ];
      },
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Column(
                children: [ _buildRepos(context) ],
              )
            ]
          )
        )
      ]),
    ));
  }
}
