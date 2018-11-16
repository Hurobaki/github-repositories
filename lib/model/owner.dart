import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class OwnerModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'login')
  final String login;

  OwnerModel(this.id, this.login);

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);

  String toString() => 'OwnerModel(id = $id, login = $login)';
}
