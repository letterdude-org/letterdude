import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterdude/app/modules/collection/blocs/collections/collections_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request/request_bloc.dart';
import 'package:letterdude/app/modules/request/blocs/request_history/request_history_bloc.dart';
import 'package:letterdude/app/screens/main_screen/main_screen.dart';
import 'package:letterdude/app/screens/sidebar/sidebar.dart';
import 'package:letterdude/design_system/widgets/base_page.dart';
import 'package:split_view/split_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CollectionsBloc>(
            create: (_) => CollectionsBloc(),
          ),
          BlocProvider<RequestBloc>(
            create: (_) => RequestBloc(),
          ),
          BlocProvider<RequestHistoryBloc>(
            create: (_) => RequestHistoryBloc(),
          ),
        ],
        child: SplitView(
          gripColor: Theme.of(context).dividerColor,
          gripColorActive: Theme.of(context).colorScheme.primary,
          gripSize: 2,
          viewMode: SplitViewMode.Horizontal,
          controller: SplitViewController(
            weights: [0.2, 0.8],
            limits: [
              WeightLimit(min: 0.2, max: 0.2),
              WeightLimit(min: 0.8, max: 0.8),
            ],
          ),
          onWeightChanged: (value) {},
          children: const [
            Sidebar(),
            MainScreen(),
          ],
        ),
      ),
    );
  }
}
