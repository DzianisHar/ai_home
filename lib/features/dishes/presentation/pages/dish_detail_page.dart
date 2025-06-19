import 'package:ai_home/core/widgets/error_widget.dart' as error_widget;
import 'package:ai_home/core/widgets/loading_widget.dart';
import 'package:ai_home/features/dishes/data/models/meal_model.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DishDetailPage extends StatefulWidget {
  final String mealId;

  const DishDetailPage({
    super.key,
    required this.mealId,
  });

  @override
  State<DishDetailPage> createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load meal details when the page is first displayed
    context.read<DishesBloc>().add(LoadMealDetails(widget.mealId));
  }

  @override
  Widget build(BuildContext context) {
    // Use the existing BlocProvider from the widget tree
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Meal Details'),
      ),
      body: BlocBuilder<DishesBloc, DishesState>(
        builder: (context, state) {
            if (state is MealDetailsLoaded) {
              final MealModel meal = state.meal.meals.first;
              return _buildMealDetails(context, meal);
            } else if (state is DishesError) {
              return error_widget.ErrorWidget(
                message: state.message,
                onRetry: () => context.read<DishesBloc>().add(LoadMealDetails(widget.mealId)),
              );
            } else if (state is NoInternetState) {
              return error_widget.ErrorWidget(
                message: 'No internet connection',
                onRetry: () => context.read<DishesBloc>().add(LoadMealDetails(widget.mealId)),
              );
            } else if (state is DishesEmpty) {
              return error_widget.ErrorWidget(
                message: 'Meal not found',
                onRetry: () => context.read<DishesBloc>().add(LoadMealDetails(widget.mealId)),
              );
            }
            return  Center(child: LoadingWidget());
          },
        ),
      );
  }

  Widget _buildMealDetails(BuildContext context, MealModel meal) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: meal.strMealThumb ?? '',
              width: double.infinity,
              height: 250.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(height: 16.h),
          
          // Meal Name
          Text(
            meal.strMeal ?? 'No name',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          
          // Category & Area
          Row(
            children: [
              _buildInfoChip(meal.strCategory ?? 'Unknown'),
              SizedBox(width: 8.w),
              _buildInfoChip(meal.strArea ?? 'Unknown'),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Ingredients
          Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          _buildIngredientsList(meal.ingredientsWithMeasures),
          SizedBox(height: 16.h),
          
          // Instructions
          Text(
            'Instructions',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            meal.strInstructions ?? 'No instructions available',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 16.h),
          
          // Tags
          if (meal.strTags?.isNotEmpty ?? false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tags',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.0,
                  children: meal.strTags!
                      .split(',')
                      .map((tag) => _buildInfoChip(tag.trim()))
                      .toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.blue), 
      ),
    );
  }

  Widget _buildIngredientsList(Map<String, String> ingredients) {
    return Column(
      children: ingredients.entries
          .map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8.0),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        '${entry.key}${entry.value.isNotEmpty ? ' - ${entry.value}' : ''}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
