import 'package:letterdude/app/modules/request/data/models/request_models.dart';

abstract class RequestHistoryRepository {
  Future<List<Request>> getHistory();
  Future<void> saveRequest(Request request);
  Future<void> deleteRequest(Request request);
}
