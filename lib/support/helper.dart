
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static const platform = MethodChannel('yank-note-message-channel');
}

const showToast = Fluttertoast.showToast;
