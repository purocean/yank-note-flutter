
import 'package:flutter/cupertino.dart';

class Files extends StatelessWidget {

  Widget _buildFiles (BuildContext context) {
    return Center(child: Text('xxx'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: CupertinoColors.secondarySystemBackground, child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          CupertinoSliverNavigationBar(
            largeTitle: Text('文件'),
            backgroundColor: CupertinoColors.secondarySystemBackground.withOpacity(0.5),
            trailing: GestureDetector(onTap: () {
              // TODO
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
                children: [ _buildFiles(context) ],
              )
            ]
          )
        )
      ]),
    ));
  }
}
