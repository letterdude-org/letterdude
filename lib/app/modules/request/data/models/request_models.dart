import 'package:json_annotation/json_annotation.dart';

part 'request_models.g.dart';

enum Methods { get, post, put, delete, option }

@JsonSerializable()
class Request {
  Request({
    required this.id,
    required this.name,
    required this.method,
    required this.uri,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  String id;
  String name;
  Methods method;
  Uri uri;

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Collection {
  Collection({required this.id, required this.name, this.requests = const []});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  String id;
  String name;
  List<Request> requests;

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
