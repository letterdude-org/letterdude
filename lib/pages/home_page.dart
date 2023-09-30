import 'package:flutter/material.dart';
import 'package:letterdude/widgets/base_page.dart';
import 'package:split_view/split_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/';

  Widget _getLeftSide(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Collections',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Wrap(
          alignment: WrapAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                // TODO: settings
              },
              icon: const Icon(Icons.settings),
              splashRadius: 18,
              tooltip: 'Settings',
            ),
          ],
        ),
      ],
    );
  }

  Widget _getRightSide(BuildContext context) {
    // TODO: request panel
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        'Request',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: SplitView(
        gripColor: Theme.of(context).dividerColor,
        gripColorActive: Theme.of(context).colorScheme.primary,
        gripSize: 2,
        viewMode: SplitViewMode.Horizontal,
        children: [
          _getLeftSide(context),
          _getRightSide(context),
        ],
      ),
    );
  }
}
