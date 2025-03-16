import 'package:flutter/material.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/core/utils/response_color.dart';
import 'package:letterdude/core/utils/stringify_bytes.dart';

class ResponseOverviewWidget extends StatelessWidget {
  const ResponseOverviewWidget({super.key, required this.result});

  final RequestSuccess result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 8,
        top: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          Text(
            'Status: ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            result.response.statusCode.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: getResponseStatusColor(result.response.statusCode),
                ),
          ),
          const SizedBox(width: 20),
          Text(
            'Size: ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            stringifyBytes(result.response.body.length),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.green),
          ),
          const SizedBox(width: 20),
          Text(
            'Time: ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '${result.duration} ms',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
