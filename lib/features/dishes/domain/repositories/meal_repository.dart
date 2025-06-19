import 'package:dartz/dartz.dart';
import 'package:ai_home/core/error/failures.dart';
import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';

abstract class MealRepository {
  Future<Either<Failure, List<MealResponseModel>>> searchMeals(String query);
  Future<Either<Failure, MealResponseModel?>> getMealById(String id);
  Future<Either<Failure, List<MealResponseModel>>> getRandomMeals({int count = 10});
  Future<Either<Failure, List<MealResponseModel>>> getMealsByCategory(String category);
}
