import 'package:demo_valorant/features/home/data/datasources/home_datasource.dart';
import 'package:demo_valorant/features/home/data/repositories/home_repository_impl.dart';
import 'package:demo_valorant/features/home/domain/repositories/home_repository.dart';
import 'package:demo_valorant/features/home/domain/use_cases/home_use_case.dart';
import 'package:get_it/get_it.dart';
import '../network/base_client.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<BaseClient>(() => BaseClient());

  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<BaseClient>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );

  getIt.registerLazySingleton<HomeUseCase>(
    () => HomeUseCase(homeRepository: getIt<HomeRepository>()),
  );
}
