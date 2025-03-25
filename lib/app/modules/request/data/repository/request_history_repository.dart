import 'package:letterdude/app/modules/request/data/models/request_models.dart';

abstract class RequestHistoryRepository {
  Future<List<Request>> getHistory();
  Future<Request> getRequest(String id);
  Future<void> saveRequest(Request request);
  Future<void> deleteRequest(Request request);
  Future<void> clearHistory();
}
