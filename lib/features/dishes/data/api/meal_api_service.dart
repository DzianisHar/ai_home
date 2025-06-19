import 'dart:convert';

import 'package:injectable/injectable.dart';

import 'package:ai_home/core/error/exceptions.dart';
import 'package:ai_home/core/network/api_client.dart';
import 'package:ai_home/core/network/api_constants.dart';
import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';

@injectable
class MealApiService {
  final ApiClient _apiClient;

  MealApiService(this._apiClient);

  Future<List<MealResponseModel>> searchMeals(String query) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.searchMeals,
        queryParameters: {ApiConstants.paramSearch: query},
      );

      if (response is! Map<String, dynamic>) {
        throw ParseException(message: 'Invalid response format');
      }

      final meals = response['meals'] as List? ?? [];
      return meals
          .map((meal) => MealResponseModel.fromJson({
                'meals': [meal]
              }))
          .toList();
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      throw ServerException(
        message: 'Failed to search meals',
      );
    }
  }

  Future<MealResponseModel?> getMealById(String id) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.lookupMeal,
        queryParameters: {ApiConstants.paramMealId: id},
      );

      if (response is! Map<String, dynamic>) {
        throw ParseException(message: 'Invalid response format');
      }

      final meals = response['meals'] as List?;
      if (meals == null || meals.isEmpty) return null;

      return MealResponseModel.fromJson({
        'meals': [meals.first]
      });
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      throw ServerException(
        message: 'Failed to get meal by id: $id',
      );
    }
  }

  Future<List<MealResponseModel>> getRandomMeals({int count = 10}) async {
    try {
      final futures = List.generate(
        count,
        (_) => _apiClient.get(ApiConstants.randomMeal),
      );

      final results = await Future.wait(futures);

      return results
          .where(
              (meal) => meal is Map<String, dynamic> && meal['meals'] != null)
          .map((meal) =>
              MealResponseModel.fromJson(meal as Map<String, dynamic>))
          .toList();
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      throw ServerException(
        message: 'Failed to get random meals',
      );
    }
  }

  Future<List<MealResponseModel>> getMealsByCategory(String category) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.filterByCategory,
        queryParameters: {ApiConstants.paramCategory: category},
      );

      if (response is! Map<String, dynamic>) {
        throw ParseException(message: 'Invalid response format');
      }

      final meals = response['meals'] as List? ?? [];
      return meals
          .map((meal) => MealResponseModel.fromJson({
                'meals': [meal]
              }))
          .toList();
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      throw ServerException(
        message: 'Failed to get meals by category: $category',
      );
    }
  }
}
