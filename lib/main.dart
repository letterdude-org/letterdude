import 'package:flutter/material.dart';
import 'package:letterdude/core/di/locator.dart';
import 'package:letterdude/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const App());
}
