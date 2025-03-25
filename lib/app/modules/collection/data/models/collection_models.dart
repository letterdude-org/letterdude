import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';

part 'collection_models.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection extends BaseModel with EquatableMixin {
  Collection({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    this.requests = const [],
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  final String name;
  final List<Request> requests;

  @override
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @override
  List<Object?> get props => [id, requests];
}
