import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/app/modules/request/data/providers/cache/request_history_cache_provider.dart';
import 'package:letterdude/core/di/locator.dart';
import 'package:letterdude/core/utils/constants.dart';
import 'package:sembast/sembast.dart';

class RequestHistoryCacheProviderImpl implements RequestHistoryCacheProvider {
  final _database = locator.get<Database>();
  final _historyStore = intMapStoreFactory.store(DatabaseStores.requestHistory);

  @override
  Future<List<Request>> getHistory() async {
    final requests = await _historyStore.find(_database);
    return requests.map((e) => Request.fromJson(e.value)).toList();
  }

  @override
  Future<void> saveRequest(Request request) async {
    await _database.transaction((transaction) async {
      final existingRequest = await _historyStore.find(
        transaction,
        finder: Finder(filter: Filter.equals('id', request.id)),
      );
      if (existingRequest.isNotEmpty) {
        return;
      }
      final requestCount = await _historyStore.count(transaction);
      if (requestCount == 30) {
        final requests = await _historyStore.find(transaction);
        requests.sort((a, b) => a.key - b.key);
        final lastRequest = requests[0];
        await _historyStore.record(lastRequest.key).delete(transaction);
      }
      await _historyStore.add(transaction, request.toJson());
    });
  }

  @override
  Future deleteRequest(Request request) async {
    return await _historyStore.delete(_database,
        finder: Finder(filter: Filter.equals('id', request.id)));
  }

  @override
  Future<void> clearHistory() async {
    await _historyStore.drop(_database);
  }
}
