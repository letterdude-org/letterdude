import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/design_system/widgets/response_body_widget.dart';
import 'package:letterdude/design_system/widgets/response_headers_widget.dart';
import 'package:letterdude/design_system/widgets/response_overview_widget.dart';
import 'package:letterdude/design_system/widgets/response_cookies_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final tabs = {
    'Response': (RequestSuccess state) => ResponseBodyWidget(result: state),
    'Headers': (RequestSuccess state) =>
        ResponseHeadersWidget(headers: state.response.headers),
    'Cookies': (RequestSuccess state) =>
        ResponseCookiesWidget(headers: state.response.headers),
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestBloc, RequestState>(
      builder: (context, state) {
        return switch (state) {
          RequestSuccess() => DefaultTabController(
              length: tabs.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponseOverviewWidget(result: state),
                  SingleChildScrollView(
                    child: IntrinsicWidth(
                      child: TabBar(
                        tabs: tabs.keys
                            .map(
                              (tab) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tab,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: tabs.values.map((tab) => tab(state)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          RequestError(:final error) => Text('Error: $error'),
          RequestInProgress() => const Center(
              child: CircularProgressIndicator(),
            ),
          RequestInitial() => const Text('Nothing to show'),
        };
      },
      listener: (context, state) {},
    );
  }
}
