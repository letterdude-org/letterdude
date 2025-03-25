import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/app/modules/collection/data/providers/cache/collections_cache_provider.dart';
import 'package:letterdude/core/di/locator.dart';
import 'package:letterdude/core/utils/constants.dart';
import 'package:sembast/sembast.dart';

class CollectionsCacheProviderImpl implements CollectionsCacheProvider {
  final _database = locator.get<Database>();
  final _collectionsStore =
      intMapStoreFactory.store(DatabaseStores.collections);

  @override
  Future<List<Collection>> getCollections() async {
    final collections = await _collectionsStore.find(_database);
    return collections.map((e) => Collection.fromJson(e.value)).toList();
  }

  @override
  Future<Collection> getCollection(String id) async {
    final collection = await _collectionsStore.find(_database,
        finder: Finder(filter: Filter.equals('id', id)));
    if (collection.isEmpty) {
      throw Exception('Collection not found');
    }
    return Collection.fromJson(collection.first.value);
  }

  @override
  Future<void> saveCollection(Collection collection) async {
    await _database.transaction((transaction) async {
      await _collectionsStore.add(transaction, collection.toJson());
    });
  }

  @override
  Future<void> deleteCollection(Collection collection) async {
    await _collectionsStore.delete(_database,
        finder: Finder(filter: Filter.equals('id', collection.id)));
  }

  @override
  Future<void> updateCollection(Collection collection) async {
    await _database.transaction((transaction) async {
      await _collectionsStore.update(transaction, collection.toJson(),
          finder: Finder(filter: Filter.equals('id', collection.id)));
    });
  }
}
