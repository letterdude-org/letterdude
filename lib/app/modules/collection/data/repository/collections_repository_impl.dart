import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/app/modules/collection/data/providers/cache/collections_cache_provider.dart';
import 'package:letterdude/app/modules/collection/data/repository/collections_repository.dart';
import 'package:letterdude/core/di/locator.dart';

class CollectionsRepositoryImpl extends CollectionsRepository {
  final CollectionsCacheProvider _cacheProvider = locator.get();

  @override
  Future<void> deleteCollection(Collection collection) {
    return _cacheProvider.deleteCollection(collection);
  }

  @override
  Future<List<Collection>> getCollections() {
    return _cacheProvider.getCollections();
  }

  @override
  Future<Collection> getCollection(String id) {
    return _cacheProvider.getCollection(id);
  }

  @override
  Future<void> saveCollection(Collection collection) {
    return _cacheProvider.saveCollection(collection);
  }

  @override
  Future<void> updateCollection(Collection collection) {
    return _cacheProvider.updateCollection(collection);
  }
}
