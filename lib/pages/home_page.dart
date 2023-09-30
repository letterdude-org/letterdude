import 'package:flutter/material.dart';
import 'package:letterdude/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appName)),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Nulla ad eiusmod mollit amet.'),
      ),
    );
  }
}
