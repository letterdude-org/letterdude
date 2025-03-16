import 'package:get_it/get_it.dart';
import 'package:letterdude/app/modules/request/data/providers/cache/request_history_cache_provider.dart';
import 'package:letterdude/app/modules/request/data/providers/cache/request_history_cache_provider_impl.dart';
import 'package:letterdude/app/modules/request/data/repository/request_history_repository.dart';
import 'package:letterdude/app/modules/request/data/repository/request_history_repository_impl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

GetIt locator = GetIt.instance;

Future<Database> initDatabase() async {
  final dbFileName = 'letterdude.db';
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDocumentDir.path, dbFileName);
  final database = await databaseFactoryIo.openDatabase(dbPath);
  return database;
}

Future<void> setupLocator() async {
  // nothing fow now
  final database = await initDatabase();
  locator.registerSingleton<Database>(database);
  locator.registerSingleton<RequestHistoryCacheProvider>(
    RequestHistoryCacheProviderImpl(),
  );
  locator.registerSingleton<RequestHistoryRepository>(
    RequestHistoryRepositoryImpl(),
  );
}
