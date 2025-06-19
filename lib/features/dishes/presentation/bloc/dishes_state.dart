import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class DishesState extends Equatable {
  const DishesState();

  @override
  List<Object> get props => [];
}

class DishesInitial extends DishesState {}

class DishesLoading extends DishesState {}

class RandomMealsLoaded extends DishesState {
  final List<MealResponseModel> meals;

  const RandomMealsLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealsSearched extends DishesState {
  final List<MealResponseModel> meals;

  const MealsSearched(this.meals);

  @override
  List<Object> get props => [meals];
}

class MealsByCategoryLoaded extends DishesState {
  final List<MealResponseModel> meals;
  final String category;

  const MealsByCategoryLoaded({
    required this.meals,
    required this.category,
  });

  @override
  List<Object> get props => [meals, category];
}

class MealDetailsLoaded extends DishesState {
  final MealResponseModel meal;

  const MealDetailsLoaded(this.meal);

  @override
  List<Object> get props => [meal];
}

class DishesError extends DishesState {
  final String message;

  const DishesError(this.message);

  @override
  List<Object> get props => [message];
}

class NoInternetState extends DishesState {}

class DishesEmpty extends DishesState {
  final String message;

  const DishesEmpty(this.message);

  @override
  List<Object> get props => [message];
}
