import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:yank_note/models/app_state.dart';
import 'package:yank_note/services/repository.dart';
import 'package:yank_note/support/helper.dart';
import 'package:yank_note/models/repository.dart';
import 'package:yank_note/widgets/input_dialog.dart';

class Repos extends StatelessWidget {
  Repos({super.key});

  final logger = Logger();

  _addRepo(BuildContext context) async {
    String path;
    try {
      path = await Helper.platform.invokeMethod('pick-folder');
    } catch (e) {
      logger.e('Failed to get folder path: ${e.toString()}');
      showToast(msg: '获取文件夹路径失败');
      rethrow;
    }

    final name = await showInputDialog(
      // ignore: use_build_context_synchronously
      context,
      title: '添加仓库',
      desc: '请输入仓库名',
      defaultValue: basename(path)
    );
    if (name != null) {
      addRepo(Repo(name: name, path: path));
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
      renameRepo(repo, name);
    }
  }

  _removeRepo(BuildContext context, Repo repo) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('删除仓库'),
          content: const Text('确定要删除这个仓库吗？'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                // do nothing
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                removeRepo(repo);
              },
            ),
          ],
        );
      },
    );
  }

  _gotoFilesPage(BuildContext context, Repo repo) {
    Navigator.pushNamed(context, '/files', arguments: {
      'name': repo.name,
      'path': repo.path
    });
  }

  Widget _buildRepos (BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      if (state.repos.isEmpty) {
        return Center(child: CupertinoButton(child: const Text('添加仓库'), onPressed: () {
          _addRepo(context);
        }));
      }

      return Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                '仓库',
                textScaler: TextScaler.linear(1.5),
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
                children: state.repos.map((repo) => Slidable(
                  endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      backgroundColor: CupertinoColors.systemGrey,
                      icon: CupertinoIcons.ellipsis,
                      onPressed: (context) => {
                        _renameRepo(context, repo)
                      },
                    ),
                    SlidableAction(
                      backgroundColor: CupertinoColors.systemRed,
                      icon: CupertinoIcons.delete,
                      onPressed: (context) => {
                        _removeRepo(context, repo)
                      },
                    ),
                  ]),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: CupertinoColors.separator))),
                    child: ListTile(
                      dense: true,
                      leading: const Icon(CupertinoIcons.tray, color: CupertinoColors.link),
                      trailing: const Icon(CupertinoIcons.right_chevron),
                      title: Text(repo.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold),),
                      focusColor: Colors.red,
                      onTap: () {
                        _gotoFilesPage(context, repo);
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
    return Container(
      color: CupertinoColors.secondarySystemBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('浏览'),
            backgroundColor: CupertinoColors.secondarySystemBackground.withOpacity(0.5),
            trailing: GestureDetector(onTap: () {
              _addRepo(context);
            }, child: const Icon(CupertinoIcons.add_circled))
          ),
          SliverList(delegate: SliverChildListDelegate([
            Container(padding: const EdgeInsets.only(top: 30), child: _buildRepos(context))
          ]))
        ],
      )
    );
  }
}
