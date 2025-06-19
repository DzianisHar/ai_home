import 'package:ai_home/core/utils/either.dart';
import 'package:ai_home/features/dishes/data/datasources/dishes_data_source.dart';
import 'package:ai_home/features/dishes/data/models/dish_model.dart';
import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:ai_home/features/dishes/domain/repositories/dishes_repository.dart';

class DishesRepositoryImpl implements DishesRepository {
  final DishesDataSource dataSource;

  DishesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, List<Dish>>> getDishes() async {
    try {
      final List<DishModel> dishes = await dataSource.getDishes();
      return Either<Exception, List<Dish>>.right(dishes);
    } catch (e) {
      return Either<Exception, List<Dish>>.left(Exception('Failed to load dishes: $e'));
    }
  }
}
