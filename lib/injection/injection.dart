import 'package:ai_home/features/dishes/data/datasources/dishes_data_source.dart';
import 'package:ai_home/features/dishes/data/repositories/dishes_repository_impl.dart';
import 'package:ai_home/features/dishes/domain/repositories/dishes_repository.dart';
import 'package:ai_home/features/dishes/domain/usecases/get_dishes.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/routes/app_router.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  // Data sources
  final dataSource = DishesDataSourceImpl();
  getIt.registerLazySingleton<DishesDataSource>(() => dataSource);

  // Repositories
  final repository = DishesRepositoryImpl(dataSource);
  getIt.registerLazySingleton<DishesRepository>(() => repository);

  // Use cases
  final getDishesUseCase = GetDishes(repository);
  getIt.registerLazySingleton<GetDishes>(() => getDishesUseCase);

  // Bloc
  getIt.registerFactory<DishesBloc>(
    () => DishesBloc(getDishes: getIt<GetDishes>()),
  );

  // Router
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}
