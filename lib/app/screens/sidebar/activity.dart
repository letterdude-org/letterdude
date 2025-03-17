import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request_history/request_history_bloc.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/core/utils/extensions.dart';

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
    return BlocBuilder<RequestHistoryBloc, RequestHistoryState>(
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
                    return ListTile(
                      leading: _getMethodIcon(request.method),
                      title: Text(
                        request.uri.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        request.createdAt.timePassedSince(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      // onTap: () {
                      //   context.read<RequestHistoryBloc>().add(
                      //         RequestHistoryItemSelected(request),
                      //       );
                      // },
                    );
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
    );
  }

  Widget _getMethodIcon(RequestMethod method) {
    final color = switch (method) {
      RequestMethod.get => Colors.blue,
      RequestMethod.post => Colors.green,
      RequestMethod.put => Colors.orange,
      RequestMethod.patch => Colors.purple,
      RequestMethod.delete => Colors.red,
      RequestMethod.options => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        method.value,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
