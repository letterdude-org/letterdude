import 'package:bloc/bloc.dart';
import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/app/modules/collection/data/repository/collections_repository.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/core/di/locator.dart';
import 'package:letterdude/core/utils/logger.dart';
import 'package:equatable/equatable.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  CollectionsBloc() : super(CollectionsInitial()) {
    on<FetchCollections>((event, emit) async {
      emit(CollectionsInProgress());
      try {
        final collections = await _collectionsRepository.getCollections();
        emit(CollectionsSuccess(collections));
      } catch (e) {
        logger.e('CollectionsBloc.FetchCollections ERROR');
        logger.e(e);

        emit(CollectionsError(e));
      }
    });

    on<AddCollection>((event, emit) async {
      try {
        await _collectionsRepository.saveCollection(event.collection);
        final collections = await _collectionsRepository.getCollections();
        emit(CollectionsSuccess(collections));
      } catch (e) {
        logger.e('CollectionsBloc.AddCollection ERROR');
        logger.e(e);

        emit(CollectionsError(e));
      }
    });

    on<DeleteCollection>((event, emit) async {
      try {
        await _collectionsRepository.deleteCollection(event.collection);
        final collections = await _collectionsRepository.getCollections();
        emit(CollectionsSuccess(collections));
      } catch (e) {
        logger.e('CollectionsBloc.DeleteCollection ERROR');
        logger.e(e);

        emit(CollectionsError(e));
      }
    });

    on<AddRequestToCollection>((event, emit) async {
      try {
        final collection = event.collection;
        if (collection.requests.any((r) => r.name == event.requestName)) {
          emit(CollectionsError('Request already exists in collection'));
          return;
        }
        final request = Request(
          id: DateTime.now().toString(),
          name: event.requestName,
          method: RequestMethod.get,
          uri: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        final requests = [...collection.requests, request];
        final updatedCollection = Collection(
          id: collection.id,
          name: collection.name,
          createdAt: collection.createdAt,
          updatedAt: DateTime.now(),
          requests: requests,
        );
        await _collectionsRepository.updateCollection(updatedCollection);
        final collections = await _collectionsRepository.getCollections();
        emit(CollectionsSuccess(collections));
      } catch (e) {
        logger.e('CollectionsBloc.AddRequestToCollection ERROR');
        logger.e(e);

        emit(CollectionsError(e));
      }
    });

    on<DeleteRequestFromCollection>((event, emit) async {
      try {
        final request = event.request;
        final collection = event.collection;
        final requests = [...collection.requests];
        requests.remove(request);
        final updatedCollection = Collection(
          id: collection.id,
          name: collection.name,
          createdAt: collection.createdAt,
          updatedAt: DateTime.now(),
          requests: requests,
        );
        await _collectionsRepository.updateCollection(updatedCollection);
        final collections = await _collectionsRepository.getCollections();
        emit(CollectionsSuccess(collections));
      } catch (e) {
        logger.e('CollectionsBloc.DeleteRequestFromCollection ERROR');
        logger.e(e);

        emit(CollectionsError(e));
      }
    });

    on<UpdateCollectionRequest>((event, emit) async {
      try {
        final existingRequest = event.collection.requests
            .where((r) => r.id == event.request.id)
            .firstOrNull;
        if (existingRequest == null) {
          emit(CollectionsError('Request not found in collection'));
          return;
        }

        final updatedRequests = [...event.collection.requests];
        final index = updatedRequests.indexOf(existingRequest);
        updatedRequests[index] = event.request;

        final updatedCollection = Collection(
          id: event.collection.id,
          name: event.collection.name,
          createdAt: event.collection.createdAt,
          updatedAt: DateTime.now(),
          requests: updatedRequests,
        );

        await _collectionsRepository.updateCollection(updatedCollection);
        final collections = await _collectionsRepository.getCollections();
        emit(CollectionsSuccess(collections));
      } catch (e) {
        logger.e('CollectionsBloc.UpdateCollectionRequest ERROR');
        logger.e(e);
        emit(CollectionsError(e));
      }
    });
  }

  final CollectionsRepository _collectionsRepository = locator.get();
}
