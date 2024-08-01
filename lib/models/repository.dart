import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable()
class Repo {
  final String name;
  final String path;

  Repo({required this.name, required this.path});

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Repo && other.name == name;
  }

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
