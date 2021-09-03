import 'package:json_annotation/json_annotation.dart';

import 'repository.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  var repos = List<Repo>.empty(growable: true);

  AppState();

  static AppState? fromJson(dynamic? json) => json == null ? null : _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
