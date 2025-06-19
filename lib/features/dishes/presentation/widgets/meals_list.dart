import 'package:ai_home/features/dishes/data/models/meal_model.dart';
import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:ai_home/features/dishes/presentation/widgets/meal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_home/core/widgets/loading_widget.dart';
import 'package:ai_home/core/widgets/error_widget.dart' as error_widget;

class MealsList extends StatefulWidget {
  final String? category;
  final bool showSearch;

  const MealsList({
    super.key,
    this.category,
    this.showSearch = true,
  });

  @override
  State<MealsList> createState() => _MealsListState();
}

class _MealsListState extends State<MealsList> {
  List<MealModel> _meals = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMeals();
    });
  }

  @override
  void didUpdateWidget(MealsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.category != oldWidget.category) {
      _loadMeals();
    }
  }

  void _loadMeals() {
    if (widget.category != null) {
      context.read<DishesBloc>().add(LoadMealsByCategory(widget.category!));
    } else {
      context.read<DishesBloc>().add(const LoadRandomMeals(count: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DishesBloc, DishesState>(
      listener: (context, state) {
        if (state is DishesError || state is NoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state is DishesError
                  ? state.message
                  : 'No internet connection'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        // Update meals when we get new data
        if (state is RandomMealsLoaded ||
            state is MealsSearched ||
            state is MealsByCategoryLoaded) {

          if (state is RandomMealsLoaded) {
            _meals = state.meals.expand((mealResponse) => mealResponse.meals).toList();
          } else if (state is MealsSearched) {
            _meals = state.meals.expand((mealResponse) => mealResponse.meals).toList();
          } else if (state is MealsByCategoryLoaded) {
            _meals = state.meals.expand((mealResponse) => mealResponse.meals).toList();
          }
        }

        // Show loading indicator if we're loading and have no data
        if (state is DishesLoading && _meals.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if we have an error and no data
        if ((state is DishesError || state is NoInternetState) && _meals.isEmpty) {
          return Center(
            child: error_widget.ErrorWidget(
              message: state is DishesError ? state.message : 'No internet connection',
              onRetry: _loadMeals,
            ),
          );
        }

        // Show empty message if we have no data
        if ((state is DishesEmpty || _meals.isEmpty) && state is! DishesLoading) {
          return Center(
            child: error_widget.ErrorWidget(
              message: state is DishesEmpty ? state.message : 'No meals found',
              onRetry: _loadMeals,
            ),
          );
        }

        // Show the list of meals
        String? currentCategory;
        if (state is MealsByCategoryLoaded) {
          currentCategory = state.category;
        }

        return Column(
          children: [
            if (currentCategory != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Category: $currentCategory',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            if (state is DishesLoading)
              const LinearProgressIndicator(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: MealCard(meal: _meals[index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}