import 'package:ai_home/core/utils/either.dart';
import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:ai_home/features/dishes/domain/usecases/get_dishes.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:bloc/bloc.dart';

class DishesBloc extends Bloc<DishesEvent, DishesState> {
  final GetDishes getDishes;

  DishesBloc({required this.getDishes}) : super(DishesInitial()) {
    on<LoadDishes>(_onLoadDishes);
  }

  Future<void> _onLoadDishes(
    LoadDishes event,
    Emitter<DishesState> emit,
  ) async {
    emit(DishesLoading());
    final Either<Exception, List<Dish>> result = await getDishes();
    result.fold(
      (Exception failure) => emit(DishesError(message: failure.toString())),
      (List<Dish> dishes) => emit(DishesLoaded(dishes: dishes)),
    );
  }
}
