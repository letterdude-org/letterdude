// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) => BaseModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      name: json['name'] as String,
      method: $enumDecode(_$RequestMethodEnumMap, json['method']),
      uri: Uri.parse(json['uri'] as String),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'method': _$RequestMethodEnumMap[instance.method]!,
      'uri': instance.uri.toString(),
    };

const _$RequestMethodEnumMap = {
  RequestMethod.get: 'get',
  RequestMethod.post: 'post',
  RequestMethod.put: 'put',
  RequestMethod.patch: 'patch',
  RequestMethod.delete: 'delete',
  RequestMethod.options: 'options',
};

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      name: json['name'] as String,
      requests: (json['requests'] as List<dynamic>?)
              ?.map((e) => Request.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'requests': instance.requests.map((e) => e.toJson()).toList(),
    };
