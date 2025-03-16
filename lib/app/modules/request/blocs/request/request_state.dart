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
    this.request,
    this.duration,
  );

  final http.Response response;
  final Request request;
  final int duration;

  @override
  List<Object> get props => [request, duration];
}

class RequestError extends RequestState {
  const RequestError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
