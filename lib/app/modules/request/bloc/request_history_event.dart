part of 'request_history_bloc.dart';

abstract class RequestHistoryEvent extends Equatable {
  const RequestHistoryEvent();
}

class FetchRequestHistory extends RequestHistoryEvent {
  const FetchRequestHistory();

  @override
  List<Object?> get props => [];
}
