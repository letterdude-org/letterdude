part of 'collections_bloc.dart';

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

class CollectionsError extends CollectionsState {
  const CollectionsError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
