import 'package:bloc/bloc.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/core/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial()) {
    on<MakeRequest>((event, emit) async {
      emit(RequestInProgress());
      try {
        print('MakeRequest ${event.method} ${event.url}');
        final uri = Uri.parse(event.url);
        final startTime = DateTime.now();
        final http.Response response = switch (event.method) {
          RequestMethod.get => await http.get(uri),
          RequestMethod.post => await http.post(uri),
          RequestMethod.put => await http.put(uri),
          RequestMethod.delete => await http.delete(uri),
          RequestMethod.options => await http.head(uri),
          RequestMethod.patch => await http.patch(uri),
        };
        final endTime = DateTime.now();
        final duration = endTime.difference(startTime).inMilliseconds;
        final request = Request(
          id: '${event.method} ${event.url}',
          name: event.url,
          uri: uri,
          method: event.method,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        emit(RequestSuccess(response, request, duration));
      } catch (e) {
        logger.e('RequestBloc.MakeRequest ERROR');
        logger.e(e);

        emit(RequestError(e));
      }
    });
  }
}
