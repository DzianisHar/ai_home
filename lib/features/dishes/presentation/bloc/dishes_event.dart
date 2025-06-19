import 'package:equatable/equatable.dart';

abstract class DishesEvent extends Equatable {
  const DishesEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoadDishes extends DishesEvent {
  const LoadDishes();
}
