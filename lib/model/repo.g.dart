// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoModel _$RepoModelFromJson(Map<String, dynamic> json) {
  return RepoModel(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['html_url'] as String,
      json['owner'] == null
          ? null
          : OwnerModel.fromJson(json['owner'] as Map<String, dynamic>));
}

Map<String, dynamic> _$RepoModelToJson(RepoModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'html_url': instance.html,
      'owner': instance.owner
    };
