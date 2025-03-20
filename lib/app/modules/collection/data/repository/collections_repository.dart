import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';

abstract class CollectionsRepository {
  Future<List<Collection>> getCollections();
  Future<void> saveCollection(Collection collection);
  Future<void> deleteCollection(Collection collection);
  Future<void> updateCollection(Collection collection);
}
