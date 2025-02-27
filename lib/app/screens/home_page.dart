import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          controller: SplitViewController(weights: [0.15, 0.85]),
          children: const [
            Sidebar(),
            MainScreen(),
          ],
        ),
      ),
    );
  }
}
