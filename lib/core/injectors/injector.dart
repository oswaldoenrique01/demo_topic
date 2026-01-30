import 'package:demo_valorant/features/create/presentation/bloc/form/form_bloc.dart';
import 'package:demo_valorant/features/home/data/datasources/home_datasource.dart';
import 'package:demo_valorant/features/home/data/repositories/home_repository_impl.dart';
import 'package:demo_valorant/features/home/domain/repositories/home_repository.dart';
import 'package:demo_valorant/features/home/domain/use_cases/home_use_case.dart';
import 'package:demo_valorant/features/topics/data/datasources/topics_datasource.dart';
import 'package:demo_valorant/features/topics/data/repositories/topics_repository_impl.dart';
import 'package:demo_valorant/features/topics/domain/repositories/topics_repository.dart';
import 'package:demo_valorant/features/topics/domain/use_cases/get_topics_use_case.dart';
import 'package:demo_valorant/core/router/app_router.dart';
import 'package:demo_valorant/features/topics/presentation/bloc/topics_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:commons/commons.dart';
import 'package:go_router/go_router.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<BaseClient>(
    () => BaseClient(baseUrl: Constants.valorantBaseUrl),
  );

  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<BaseClient>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );

  getIt.registerLazySingleton<HomeUseCase>(
    () => HomeUseCase(homeRepository: getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton<BaseClient>(
    () => BaseClient(),
    instanceName: 'commonsClient',
  );

  getIt.registerLazySingleton<TopicsRemoteDataSource>(
    () => TopicsRemoteDataSourceImpl(
      getIt<BaseClient>(instanceName: 'commonsClient'),
    ),
  );

  getIt.registerLazySingleton<TopicsRepository>(
    () => TopicsRepositoryImpl(getIt<TopicsRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetTopicsUseCase>(
    () => GetTopicsUseCase(getIt<TopicsRepository>()),
  );

  getIt.registerFactory<TopicsBloc>(
    () => TopicsBloc(getIt<GetTopicsUseCase>()),
  );

  getIt.registerFactory<FormCreateBloc>(
    () => FormCreateBloc(),
  );

  getIt.registerLazySingleton<AppRouter>(() => AppRouter());

  getIt.registerLazySingleton<GoRouter>(
    () => GoRouter(routes: getIt<AppRouter>().routes, initialLocation: '/'),
  );
}
