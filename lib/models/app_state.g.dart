// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState()
    ..repos = (json['repos'] as List<dynamic>)
        .map((e) => Repo.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'repos': instance.repos,
    };
