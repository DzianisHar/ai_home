import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:ai_home/core/error/failures.dart';
import 'package:ai_home/features/dishes/domain/repositories/meal_repository.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:dartz/dartz.dart';

class DishesBloc extends Bloc<DishesEvent, DishesState> {
  final MealRepository _mealRepository;

  DishesBloc({
    required MealRepository mealRepository,
  })  : _mealRepository = mealRepository,
        super(DishesInitial()) {
    on<LoadRandomMeals>(_onLoadRandomMeals);
    on<SearchMeals>(_onSearchMeals);
    on<LoadMealsByCategory>(_onLoadMealsByCategory);
    on<LoadMealDetails>(_onLoadMealDetails);
  }

  Future<void> _onLoadRandomMeals(
    LoadRandomMeals event,
    Emitter<DishesState> emit,
  ) async {
    // Only show loading if we don't have any data yet
    if (state is! RandomMealsLoaded) {
      emit(DishesLoading());
    }
    final result = await _mealRepository.getRandomMeals(count: event.count);
    _handleMealListResult(result, emit);
  }

  Future<void> _onSearchMeals(
    SearchMeals event,
    Emitter<DishesState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LoadRandomMeals(count: 10));
      return;
    }

    emit(DishesLoading());
    final result = await _mealRepository.searchMeals(event.query);
    _handleMealListResult(result, emit);
  }

  Future<void> _onLoadMealsByCategory(
    LoadMealsByCategory event,
    Emitter<DishesState> emit,
  ) async {
    emit(DishesLoading());
    final result = await _mealRepository.getMealsByCategory(event.category);
    _handleMealListResult(result, emit);
  }

  DishesState? _previousState;

  Future<void> _onLoadMealDetails(
    LoadMealDetails event,
    Emitter<DishesState> emit,
  ) async {
    emit(DishesLoading());
    final result = await _mealRepository.getMealById(event.mealId);
    
    emit(
      result.fold(
        (failure) => DishesError(_mapFailureToMessage(failure)),
        (meal) => meal == null 
            ? const DishesEmpty('Meal not found')
            : MealDetailsLoaded(meal),
      ),
    );
  }

  void _handleMealListResult(
    Either<Failure, List<MealResponseModel>> result,
    Emitter<DishesState> emit,
  ) {
    emit(
      result.fold(
        (failure) => failure is NoInternetFailure
            ? NoInternetState()
            : DishesError(_mapFailureToMessage(failure)),
        (List<MealResponseModel> meals) => meals.isEmpty
            ? const DishesEmpty('No meals found')
            : _mapToAppropriateState(meals),
      ),
    );
  }

  DishesState _mapToAppropriateState(List<MealResponseModel> meals) {
    final mealResponses = meals.cast<MealResponseModel>().toList();
    
    if (mealResponses.isEmpty) {
      return const DishesEmpty('No meals available');
    }
    
    // Return the appropriate state based on the current state
    if (state is MealsSearched) {
      return MealsSearched(mealResponses);
    } else if (state is MealsByCategoryLoaded) {
      return MealsByCategoryLoaded(
        meals: mealResponses,
        category: (state as MealsByCategoryLoaded).category,
      );
    }
    
    // Default to RandomMealsLoaded
    return RandomMealsLoaded(mealResponses);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error';
      case NoInternetFailure:
        return 'No internet connection';
      default:
        return 'Unexpected error';
    }
  }
}
