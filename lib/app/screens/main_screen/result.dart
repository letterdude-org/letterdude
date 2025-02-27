import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/design_system/widgets/response_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestBloc, RequestState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: switch (state) {
            RequestSuccess(:final response) =>
              ResponseWidget(response: response),
            RequestError(:final error) => Text('Error: $error'),
            RequestInProgress() => const Center(
                child: CircularProgressIndicator(),
              ),
            RequestInitial() => const Text('Nothing to show'),
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
