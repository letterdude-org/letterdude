part of 'request_history_bloc.dart';

abstract class RequestHistoryState extends Equatable {
  const RequestHistoryState();
}

class RequestHistoryInitial extends RequestHistoryState {
  @override
  List<Object> get props => [];
}

class RequestHistoryInProgress extends RequestHistoryState {
  @override
  List<Object> get props => [];
}

class RequestHistorySuccess extends RequestHistoryState {
  const RequestHistorySuccess(
    this.requests,
  );

  final List<Request> requests;

  @override
  List<Object> get props => [];
}

class RequestHistoryError extends RequestHistoryState {
  const RequestHistoryError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
