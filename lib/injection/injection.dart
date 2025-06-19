import 'package:ai_home/core/network/api_client.dart';
import 'package:ai_home/core/network/network_info.dart';
import 'package:ai_home/features/dishes/data/api/meal_api_service.dart';
import 'package:ai_home/features/dishes/data/repositories/meal_repository_impl.dart';
import 'package:ai_home/features/dishes/domain/repositories/meal_repository.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/routes/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() {
  // Core
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<Logger>(() => Logger());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  
  // Network
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );
  
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(getIt<Dio>(), getIt<Logger>()),
  );

  // API Services
  getIt.registerLazySingleton<MealApiService>(
    () => MealApiService(getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(
      apiService: getIt<MealApiService>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Blocs
  getIt.registerFactory<DishesBloc>(
    () => DishesBloc(mealRepository: getIt<MealRepository>()),
  );

  // Router
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}
