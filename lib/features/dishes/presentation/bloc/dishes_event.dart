import 'package:equatable/equatable.dart';

abstract class DishesEvent extends Equatable {
  const DishesEvent();

  @override
  List<Object> get props => [];
}

class LoadRandomMeals extends DishesEvent {
  final int count;
  
  const LoadRandomMeals({this.count = 10});
  
  @override
  List<Object> get props => [count];
}

class SearchMeals extends DishesEvent {
  final String query;
  
  const SearchMeals(this.query);
  
  @override
  List<Object> get props => [query];
}

class LoadMealsByCategory extends DishesEvent {
  final String category;
  
  const LoadMealsByCategory(this.category);
  
  @override
  List<Object> get props => [category];
}

class LoadMealDetails extends DishesEvent {
  final String mealId;
  
  const LoadMealDetails(this.mealId);
  
  @override
  List<Object> get props => [mealId];
}
