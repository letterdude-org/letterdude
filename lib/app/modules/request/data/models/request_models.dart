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
  options('OPTIONS'),
  head('HEAD');

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
    this.uri,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  final String name;
  final RequestMethod method;
  final String? uri;

  Request copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    RequestMethod? method,
    String? uri,
  }) {
    return Request(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      method: method ?? this.method,
      uri: uri ?? this.uri,
    );
  }

  @override
  List<Object?> get props => [id, name, method, uri];

  @override
  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
