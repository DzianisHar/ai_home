import 'package:ai_home/core/utils/either.dart';
import 'package:ai_home/features/dishes/domain/entities/dish.dart';

abstract class DishesRepository {
  Future<Either<Exception, List<Dish>>> getDishes();
}
