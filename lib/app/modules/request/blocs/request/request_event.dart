part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();
}

class MakeRequest extends RequestEvent {
  const MakeRequest(this.method, this.url);

  final RequestMethod method;
  final String url;

  @override
  List<Object?> get props => [method, url];
}

class LoadRequest extends RequestEvent {
  const LoadRequest({required this.request, this.collection});

  final Request request;
  final Collection? collection;

  @override
  List<Object?> get props => [request, collection];
}
