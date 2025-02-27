import 'package:flutter/material.dart';
import 'package:letterdude/app/screens/main_screen/request.dart';
import 'package:letterdude/app/screens/main_screen/result.dart';
import 'package:split_view/split_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitView(
      gripColor: Theme.of(context).dividerColor,
      gripColorActive: Theme.of(context).colorScheme.primary,
      gripSize: 2,
      viewMode: SplitViewMode.Horizontal,
      controller: SplitViewController(weights: [0.5, 0.5]),
      children: const [
        RequestScreen(),
        ResultScreen(),
      ],
    );
  }
}
