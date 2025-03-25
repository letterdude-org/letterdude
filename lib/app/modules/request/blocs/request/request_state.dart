part of 'request_bloc.dart';

class ActiveRequest extends Equatable {
  const ActiveRequest({required this.request, this.collection});

  final Request request;
  final Collection? collection;

  @override
  List<Object?> get props => [request, collection];
}

sealed class RequestState extends Equatable {
  const RequestState({required this.activeRequest});

  final ActiveRequest activeRequest;

  @override
  List<Object?> get props => [activeRequest];
}

class RequestInitial extends RequestState {
  const RequestInitial({required super.activeRequest});

  RequestInitial.empty()
      : super(
          activeRequest: ActiveRequest(
            request: Request(
              id: '',
              name: '',
              method: RequestMethod.get,
              uri: null,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        );

  @override
  List<Object> get props => [activeRequest];
}

class RequestInProgress extends RequestState {
  const RequestInProgress({required super.activeRequest});

  @override
  List<Object> get props => [activeRequest];
}

class RequestSuccess extends RequestState {
  const RequestSuccess({
    required this.response,
    required this.duration,
    required super.activeRequest,
  });

  final http.Response response;
  final int duration;

  @override
  List<Object> get props => [activeRequest, duration];
}

class RequestError extends RequestState {
  const RequestError({required this.error, required super.activeRequest});

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class RequestLoaded extends RequestState {
  const RequestLoaded({required super.activeRequest});

  @override
  List<Object> get props => [activeRequest];
}
