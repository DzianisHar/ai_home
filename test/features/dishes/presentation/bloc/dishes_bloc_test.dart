import 'package:ai_home/core/error/failures.dart';
import 'package:ai_home/features/dishes/data/models/meal_model.dart';
import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';
import 'package:ai_home/features/dishes/domain/repositories/meal_repository.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMealRepository extends Mock implements MealRepository {}

void main() {
  late DishesBloc dishesBloc;
  late MockMealRepository mockMealRepository;

  const MealModel tMeal = MealModel(
    idMeal: '1',
    strMeal: 'Test Meal',
    strMealThumb: 'https://example.com/meal.jpg',
    strCategory: 'Test Category',
    strArea: 'Test Area', strInstructions: '',
  );

  const MealResponseModel tMealResponse = MealResponseModel(
    meals: [tMeal],
  );

  setUp(() {
    mockMealRepository = MockMealRepository();
    dishesBloc = DishesBloc(mealRepository: mockMealRepository);
  });

  tearDown(() {
    dishesBloc.close();
  });

  group('LoadRandomMeals', () {
    blocTest<DishesBloc, DishesState>(
      'emits [DishesLoading, RandomMealsLoaded] when LoadRandomMeals is added and succeeds',
      build: () {
        when(() => mockMealRepository.getRandomMeals(count: 3))
            .thenAnswer((_) async => Right([tMealResponse]));
        return dishesBloc;
      },
      act: (bloc) => bloc.add(const LoadRandomMeals(count: 3)),
      expect: () => [
        isA<DishesLoading>(),
        isA<RandomMealsLoaded>(),
      ],
      verify: (_) {
        verify(() => mockMealRepository.getRandomMeals(count: 3)).called(1);
      },
    );

    blocTest<DishesBloc, DishesState>(
      'emits [DishesLoading, DishesError] when LoadRandomMeals fails',
      build: () {
        when(() => mockMealRepository.getRandomMeals(count: 3))
            .thenAnswer((_) async => Left(ServerFailure()));
        return dishesBloc;
      },
      act: (bloc) => bloc.add(const LoadRandomMeals(count: 3)),
      expect: () => [
        isA<DishesLoading>(),
        isA<DishesError>(),
      ],
    );
  });


    blocTest<DishesBloc, DishesState>(
      'loads random meals when search query is empty',
      build: () {
        when(() => mockMealRepository.getRandomMeals(count: 10))
            .thenAnswer((_) async => const Right(<MealResponseModel>[tMealResponse]));
        return dishesBloc;
      },
      act: (DishesBloc bloc) => bloc.add(const SearchMeals('')),
      expect: () => [
        isA<DishesLoading>(),
        isA<RandomMealsLoaded>(),
      ],
      verify: (_) {
        verifyNever(() => mockMealRepository.searchMeals(any()));
        verify(() => mockMealRepository.getRandomMeals(count: 10)).called(1);
      },
    );



  group('LoadMealDetails', () {
    const tMealId = '123';

    blocTest<DishesBloc, DishesState>(
      'emits [DishesLoading, MealDetailsLoaded] when LoadMealDetails is added and succeeds',
      build: () {
        when(() => mockMealRepository.getMealById(tMealId))
            .thenAnswer((_) async => Right(tMealResponse));
        return dishesBloc;
      },
      act: (bloc) => bloc.add(LoadMealDetails(tMealId)),
      expect: () => [
        isA<DishesLoading>(),
        isA<MealDetailsLoaded>(),
      ],
    );

    blocTest<DishesBloc, DishesState>(
      'emits [DishesLoading, DishesEmpty] when meal is not found',
      build: () {
        when(() => mockMealRepository.getMealById(tMealId))
            .thenAnswer((_) async => const Right(null));
        return dishesBloc;
      },
      act: (bloc) => bloc.add(LoadMealDetails(tMealId)),
      expect: () => [
        isA<DishesLoading>(),
        isA<DishesEmpty>(),
      ],
    );
  });
}
