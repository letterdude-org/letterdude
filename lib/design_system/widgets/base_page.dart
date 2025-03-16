import 'package:flutter/material.dart';
import 'package:letterdude/core/utils/constants.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: settings
            },
            icon: const Icon(Icons.settings),
            splashRadius: 18,
            tooltip: 'Settings',
            style: Theme.of(context).iconButtonTheme.style,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
      body: child,
    );
  }
}
