part of 'request_bloc.dart';

sealed class RequestState extends Equatable {
  const RequestState();
}

class RequestInitial extends RequestState {
  @override
  List<Object> get props => [];
}

class RequestInProgress extends RequestState {
  @override
  List<Object> get props => [];
}

class RequestSuccess extends RequestState {
  const RequestSuccess(
    this.response,
  );

  final http.Response response;

  @override
  List<Object> get props => [];
}

class RequestError extends RequestState {
  const RequestError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
