part of 'collections_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();
}

class FetchCollections extends CollectionsEvent {
  const FetchCollections();

  @override
  List<Object?> get props => [];
}

class AddCollection extends CollectionsEvent {
  const AddCollection(this.collection);

  final Collection collection;

  @override
  List<Object?> get props => [collection];
}

class DeleteCollection extends CollectionsEvent {
  const DeleteCollection(this.collection);

  final Collection collection;

  @override
  List<Object?> get props => [collection];
}

class AddRequestToCollection extends CollectionsEvent {
  const AddRequestToCollection(this.collection, this.requestName);

  final Collection collection;
  final String requestName;

  @override
  List<Object?> get props => [collection, requestName];
}

class DeleteRequestFromCollection extends CollectionsEvent {
  const DeleteRequestFromCollection(this.collection, this.request);

  final Collection collection;
  final Request request;

  @override
  List<Object?> get props => [collection, request];
}

class UpdateCollectionRequest extends CollectionsEvent {
  const UpdateCollectionRequest(this.collection, this.request);

  final Collection collection;
  final Request request;

  @override
  List<Object?> get props => [collection, request];
}
