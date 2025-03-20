import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/collection/blocs/collections/collections_bloc.dart';
import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/app/modules/request/data/models/request_models.dart';
import 'package:letterdude/core/utils/extensions.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({
    super.key,
    required this.request,
    this.collection,
    this.showMethod = true,
    this.showTimestamp = true,
    this.displayName = false,
  });

  final Request request;
  final Collection? collection;
  final bool showMethod;
  final bool showTimestamp;
  final bool displayName;

  @override
  Widget build(BuildContext context) {
    final listTile = ListTile(
      leading: showMethod ? _getMethodIcon(request.method) : null,
      title: displayName
          ? Text(
              request.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : _buildUriText(context),
      subtitle: displayName
          ? _buildUriText(context)
          : showTimestamp
              ? Text(
                  request.createdAt.timePassedSince(),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              : null,
      onTap: () {
        context.read<RequestBloc>().add(LoadRequest(
              request: request,
              collection: collection,
            ));
      },
      trailing: collection != null
          ? IconButton(
              icon: const Icon(Icons.delete),
              splashRadius: 18,
              tooltip: 'Remove from collection',
              onPressed: () {
                context.read<CollectionsBloc>().add(
                      DeleteRequestFromCollection(
                        collection!,
                        request,
                      ),
                    );
              },
            )
          : null,
    );

    return listTile;
  }

  Widget _buildUriText(BuildContext context) {
    return Text(
      request.uri?.toString() ?? 'No URL specified',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: request.uri != null
                ? null
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontStyle:
                request.uri != null ? FontStyle.normal : FontStyle.italic,
          ),
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
      RequestMethod.head => Colors.grey,
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
