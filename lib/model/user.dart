import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'login')
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'repos_url')
  final String repos;

  UserModel(this.login, this.avatarUrl, this.id, this.email, this.repos);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String toString() =>
      'UserModel(login = $login, avatarUrl = $avatarUrl, id = $id, email = $email, reposUrl = $repos)';
}
