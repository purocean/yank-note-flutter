import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:yank_note/support/files.dart';

class Files extends StatelessWidget {

  late final String name;
  late final String path;
  late final List<FileSystemEntity> list;

  Files({super.key, required Map arguments }) {
    name = arguments['name'];
    path = arguments['path'];
    list = listFiles(path);
  }

  Widget _buildFiles (BuildContext context) {
    return Column(children: list.map((e) => ListTile(title: Text(basename(e.path)))).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: CupertinoColors.secondarySystemBackground, child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(name),
          backgroundColor: CupertinoColors.secondarySystemBackground.withOpacity(0.5),
          trailing: GestureDetector(onTap: () {
            // TODO
          }, child: const Icon(CupertinoIcons.add_circled))
        ),
        SliverList(delegate: SliverChildListDelegate([
          _buildFiles(context)
        ]))
      ]
      ),
    );
  }
}
