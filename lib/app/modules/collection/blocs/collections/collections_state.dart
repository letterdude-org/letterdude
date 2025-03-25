part of 'collections_bloc.dart';

enum CollectionsAction {
  add,
  delete,
  update,
}

abstract class CollectionsState extends Equatable {
  const CollectionsState();
}

class CollectionsInitial extends CollectionsState {
  @override
  List<Object> get props => [];
}

class CollectionsInProgress extends CollectionsState {
  @override
  List<Object> get props => [];
}

class CollectionsSuccess extends CollectionsState {
  const CollectionsSuccess(
    this.collections,
  );

  final List<Collection> collections;

  @override
  List<Object> get props => [collections];
}

class CollectionsActionSuccess extends CollectionsState {
  const CollectionsActionSuccess({
    required this.collections,
    required this.action,
    required this.request,
    required this.collection,
  });

  final List<Collection> collections;
  final CollectionsAction action;
  final Request request;
  final Collection collection;

  @override
  List<Object?> get props => [collections, action, request, collection];
}

class CollectionsError extends CollectionsState {
  const CollectionsError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
