// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo(
    name: json['name'] as String,
    path: json['path'] as String,
  );
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
    };
