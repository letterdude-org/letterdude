import 'package:flutter/material.dart';
import 'package:letterdude/core/di/locator.dart';
import 'package:sembast/sembast_io.dart';
import 'package:letterdude/app.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  _initDatabase();
  runApp(const App());
}

void _initDatabase() async {
  const dbFileName = 'letterdude.db';
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDocumentDir.path, dbFileName);
  final database = await databaseFactoryIo.openDatabase(dbPath);
  locator.registerSingleton<Database>(database);
}
