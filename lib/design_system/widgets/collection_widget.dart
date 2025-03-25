import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/collection/blocs/collections/collections_bloc.dart';
import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/design_system/widgets/dialogs.dart';
import 'package:letterdude/design_system/widgets/request_widget.dart';

class CollectionWidget extends StatefulWidget {
  const CollectionWidget({
    super.key,
    required this.collection,
  });

  final Collection collection;

  @override
  State<CollectionWidget> createState() => _CollectionWidgetState();
}

class _CollectionWidgetState extends State<CollectionWidget> {
  late ExpansionTileController controller;

  @override
  void initState() {
    super.initState();
    controller = ExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
      title: Text(widget.collection.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<String>(
            splashRadius: 18,
            tooltip: 'Collection options',
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'add',
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 8),
                    Text(
                      'Add request',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Delete collection',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              switch (value) {
                case 'add':
                  final name = await showInputDialog(
                    context: context,
                    title: 'New Request',
                    labelText: 'Request Name',
                    hintText: 'Enter request name',
                  );

                  if (name != null && context.mounted) {
                    context.read<CollectionsBloc>().add(
                          AddRequestToCollection(widget.collection, name),
                        );
                  }
                case 'delete':
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Collection'),
                        content: Text(
                          'Are you sure you want to delete "${widget.collection.name}"? '
                          'This action cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<CollectionsBloc>()
                                  .add(DeleteCollection(widget.collection));
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  }
              }
            },
          ),
          const Icon(Icons.expand_more),
        ],
      ),
      children: [
        if (widget.collection.requests.isEmpty)
          const ListTile(
            title: Text('No requests in this collection'),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.collection.requests.length,
            itemBuilder: (context, requestIndex) {
              final request = widget.collection.requests[requestIndex];
              return RequestWidget(
                request: request,
                collection: widget.collection,
                showTimestamp: false,
                displayName: true,
              );
            },
          ),
      ],
    );
  }
}
