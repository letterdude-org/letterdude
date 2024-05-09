import 'package:flutter/material.dart';
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
      child: SplitView(
        gripColor: Theme.of(context).dividerColor,
        gripColorActive: Theme.of(context).colorScheme.primary,
        gripSize: 2,
        viewMode: SplitViewMode.Horizontal,
        children: const [
          Sidebar(),
          MainScreen(),
        ],
      ),
    );
  }
}
