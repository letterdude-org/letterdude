import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/app/modules/request/data/providers/cache/request_history_cache_provider.dart';
import 'package:letterdude/app/modules/request/data/repository/request_history_repository.dart';
import 'package:letterdude/core/di/locator.dart';

class RequestHistoryRepositoryImpl extends RequestHistoryRepository {
  final RequestHistoryCacheProvider _cacheProvider = locator.get();

  @override
  Future<void> deleteRequest(Request request) {
    return _cacheProvider.deleteRequest(request);
  }

  @override
  Future<List<Request>> getHistory() {
    return _cacheProvider.getHistory();
  }

  @override
  Future<Request> getRequest(String id) {
    return _cacheProvider.getRequest(id);
  }

  @override
  Future<void> saveRequest(Request request) {
    return _cacheProvider.saveRequest(request);
  }

  @override
  Future<void> clearHistory() {
    return _cacheProvider.clearHistory();
  }
}
