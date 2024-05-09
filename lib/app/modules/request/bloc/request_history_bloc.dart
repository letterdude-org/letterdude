import 'package:bloc/bloc.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/app/modules/request/data/repository/request_history_repository.dart';
import 'package:letterdude/core/di/locator.dart';
import 'package:letterdude/core/utils/logger.dart';
import 'package:equatable/equatable.dart';

part 'request_history_event.dart';
part 'request_history_state.dart';

class RequestHistoryBloc
    extends Bloc<RequestHistoryEvent, RequestHistoryState> {
  RequestHistoryBloc() : super(RequestHistoryInitial()) {
    on<FetchRequestHistory>((event, emit) async {
      emit(RequestHistoryInProgress());
      try {
        final requests = await _requestHistoryRepository.getHistory();
        emit(RequestHistorySuccess(requests));
      } catch (e) {
        logger.e('RequestHistoryBloc.FetchRequestHistory ERROR');
        logger.e(e);

        emit(RequestHistoryError(e));
      }
    });
  }

  final RequestHistoryRepository _requestHistoryRepository = locator.get();
}
