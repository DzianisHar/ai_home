import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:equatable/equatable.dart';

abstract class DishesState extends Equatable {
  const DishesState();

  @override
  List<Object> get props => <Object>[];
}

class DishesInitial extends DishesState {}

class DishesLoading extends DishesState {}

class DishesLoaded extends DishesState {
  final List<Dish> dishes;

  const DishesLoaded({required this.dishes});

  @override
  List<Object> get props => <Object>[dishes];
}

class DishesError extends DishesState {
  final String message;

  const DishesError({required this.message});

  @override
  List<Object> get props => <Object>[message];
}
