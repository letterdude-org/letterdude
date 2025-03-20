import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request_history/request_history_bloc.dart';
import 'package:letterdude/design_system/widgets/request_widget.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  void initState() {
    super.initState();
    context.read<RequestHistoryBloc>().add(FetchRequestHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<RequestHistoryBloc, RequestHistoryState>(
            builder: (context, state) {
              return switch (state) {
                RequestHistorySuccess(:final requests) => requests.isEmpty
                    ? const Center(
                        child: Text('No activity yet'),
                      )
                    : ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return RequestWidget(request: request);
                        },
                      ),
                RequestHistoryInProgress() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                RequestHistoryError(:final error) => Center(
                    child: Text('Error: $error'),
                  ),
                _ => const Center(
                    child: Text('No activity yet'),
                  ),
              };
            },
          ),
        ),
        const Divider(height: 1),
        Wrap(
          alignment: WrapAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                context.read<RequestHistoryBloc>().add(ClearRequestHistory());
              },
              icon: const Icon(Icons.delete_forever),
              splashRadius: 18,
              tooltip: 'Clear history',
            ),
          ],
        ),
      ],
    );
  }
}
