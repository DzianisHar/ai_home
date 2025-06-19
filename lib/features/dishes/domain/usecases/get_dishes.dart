import 'package:ai_home/core/utils/either.dart';
import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:ai_home/features/dishes/domain/repositories/dishes_repository.dart';

class GetDishes {
  final DishesRepository repository;

  GetDishes(this.repository);

  Future<Either<Exception, List<Dish>>> call() async {
    return repository.getDishes();
  }
}
