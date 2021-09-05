
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static const platform = const MethodChannel('yank-note-message-channel');
}

final showToast = Fluttertoast.showToast;
