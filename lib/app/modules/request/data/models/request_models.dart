import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_models.g.dart';

@JsonSerializable()
class BaseModel {
  BaseModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}

enum RequestMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE'),
  options('OPTIONS');

  const RequestMethod(this.value);
  final String value;
}

@JsonSerializable()
class Request extends BaseModel with EquatableMixin {
  Request({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.method,
    required this.uri,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  final String name;
  final RequestMethod method;
  final Uri uri;

  @override
  List<Object> get props => [id];

  @override
  Map<String, dynamic> toJson() => _$RequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Collection extends BaseModel {
  Collection({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    this.requests = const [],
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  String name;
  List<Request> requests;

  @override
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
