import 'package:birds/data/datasources/config_source_dotenv.dart';
import 'package:birds/data/repositories/ws_repository_impl.dart';
import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:get_it/get_it.dart';

abstract final class ServiceLocator {
  static Future<void> setup() async {
    final configSource = ConfigSourceDotenv();
    await configSource.initialize;

    GetIt.I.registerSingleton<ConfigSource>(configSource);
    GetIt.I.registerSingleton<WsRepository>(
      WsRepositoryImpl(url: configSource.wsUrl),
    );
  }
}
