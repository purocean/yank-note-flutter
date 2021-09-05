import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:yank_note/support/helper.dart';

List<FileSystemEntity> listFiles (String dirpPath) {
  try {
    final dir = Directory(dirpPath);
    return dir.listSync();
  } catch (e) {
    showToast(msg: e.toString());
    return [];
  }
}
