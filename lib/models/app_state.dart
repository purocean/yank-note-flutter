import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'repository.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState with ChangeNotifier {
  var _repos = List<Repo>.empty(growable: true);

  List<Repo> get repos => _repos;
  set repos(List<Repo> value) {
    _repos = value;
    notifyListeners();
  }

  AppState();

  static AppState? fromJson(dynamic json) => json == null ? null : _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
