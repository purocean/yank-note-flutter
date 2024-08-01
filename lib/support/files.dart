import 'dart:io';

import 'package:yank_note/support/helper.dart';

List<FileSystemEntity> listFiles (String dirPath) {
  try {
    final dir = Directory(dirPath);
    return dir.listSync();
  } catch (e) {
    showToast(msg: e.toString());
    return [];
  }
}
