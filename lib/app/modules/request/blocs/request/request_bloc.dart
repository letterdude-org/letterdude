import 'package:bloc/bloc.dart';
import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/core/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial.empty()) {
    on<MakeRequest>((event, emit) async {
      emit(RequestInProgress(activeRequest: state.activeRequest));
      try {
        final uri = Uri.parse(event.url);
        final startTime = DateTime.now();
        final http.Response response = switch (event.method) {
          RequestMethod.get => await http.get(uri),
          RequestMethod.post => await http.post(uri),
          RequestMethod.put => await http.put(uri),
          RequestMethod.delete => await http.delete(uri),
          RequestMethod.options => await http.head(uri),
          RequestMethod.patch => await http.patch(uri),
          RequestMethod.head => await http.head(uri),
        };
        final endTime = DateTime.now();
        final duration = endTime.difference(startTime).inMilliseconds;
        final request = state.activeRequest.request.copyWith(
          uri: uri.toString(),
          method: event.method,
          updatedAt: DateTime.now(),
        );
        emit(RequestSuccess(
          response: response,
          duration: duration,
          activeRequest: ActiveRequest(
            request: request,
            collection: state.activeRequest.collection,
          ),
        ));
      } catch (e) {
        logger.e('RequestBloc.MakeRequest ERROR');
        logger.e(e);

        emit(RequestError(
          error: e,
          activeRequest: state.activeRequest,
        ));
      }
    });

    on<LoadRequest>((event, emit) {
      emit(RequestLoaded(
        activeRequest: ActiveRequest(
          request: event.request,
          collection: event.collection,
        ),
      ));
    });
  }
}
