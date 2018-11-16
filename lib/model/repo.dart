import 'package:json_annotation/json_annotation.dart';
import 'owner.dart';

part 'repo.g.dart';

@JsonSerializable()
class RepoModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'html_url')
  final String html;
  @JsonKey(name: 'owner')
  OwnerModel owner;

  RepoModel(this.id, this.name, this.description, this.html, this.owner);

  factory RepoModel.fromJson(Map<String, dynamic> json) =>
      _$RepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepoModelToJson(this);

  String toString() =>
      'UserModel(id = $id, name = $name, description = $description, html = $html, owner = $owner)';
}
