part of 'request_history_bloc.dart';

abstract class RequestHistoryEvent extends Equatable {
  const RequestHistoryEvent();
}

class FetchRequestHistory extends RequestHistoryEvent {
  const FetchRequestHistory();

  @override
  List<Object?> get props => [];
}

class AddRequestHistory extends RequestHistoryEvent {
  const AddRequestHistory(this.request);

  final Request request;

  @override
  List<Object?> get props => [request];
}

class DeleteRequestHistory extends RequestHistoryEvent {
  const DeleteRequestHistory(this.request);

  final Request request;

  @override
  List<Object?> get props => [request];
}

class ClearRequestHistory extends RequestHistoryEvent {
  const ClearRequestHistory();

  @override
  List<Object?> get props => [];
}
