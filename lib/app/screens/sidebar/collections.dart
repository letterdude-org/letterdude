import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/collection/blocs/collections/collections_bloc.dart';
import 'package:letterdude/app/modules/collection/data/models/collection_models.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/design_system/widgets/dialogs.dart';
import 'package:letterdude/design_system/widgets/collection_widget.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionsBloc>().add(const FetchCollections());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<CollectionsBloc, CollectionsState>(
            listener: (context, state) {
              if (state is CollectionsActionSuccess) {
                if (state.action == CollectionsAction.add) {
                  context.read<RequestBloc>().add(LoadRequest(
                        request: state.request,
                        collection: state.collection,
                      ));
                }
              }
            },
            builder: (context, state) {
              return switch (state) {
                CollectionsSuccess(:final collections) ||
                CollectionsActionSuccess(:final collections) =>
                  collections.isEmpty
                      ? const Center(
                          child: Text('No collections yet'),
                        )
                      : ListView.builder(
                          itemCount: collections.length,
                          itemBuilder: (context, index) {
                            final collection = collections[index];
                            return CollectionWidget(
                              collection: collection,
                            );
                          },
                        ),
                CollectionsInProgress() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                CollectionsError(:final error) => Center(
                    child: Text('Error: $error'),
                  ),
                _ => const Center(
                    child: Text('No collections yet'),
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
              onPressed: () async {
                final name = await showInputDialog(
                  context: context,
                  title: 'New Collection',
                  labelText: 'Collection Name',
                  hintText: 'Enter collection name',
                );

                if (name != null && context.mounted) {
                  context.read<CollectionsBloc>().add(
                        AddCollection(
                          Collection(
                            id: DateTime.now().toString(),
                            name: name,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            requests: const [],
                          ),
                        ),
                      );
                }
              },
              icon: const Icon(Icons.add),
              splashRadius: 18,
              tooltip: 'Add collection',
            ),
          ],
        ),
      ],
    );
  }
}
