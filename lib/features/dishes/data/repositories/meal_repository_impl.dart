import 'package:ai_home/core/error/exceptions.dart';
import 'package:ai_home/core/error/failures.dart';
import 'package:ai_home/core/network/network_info.dart';
import 'package:ai_home/features/dishes/data/api/meal_api_service.dart';
import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';
import 'package:ai_home/features/dishes/domain/repositories/meal_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MealRepository)
class MealRepositoryImpl implements MealRepository {
  final MealApiService apiService;
  final NetworkInfo networkInfo;

  MealRepositoryImpl({
    required this.apiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MealResponseModel>>> searchMeals(String query) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NoInternetFailure());
      }

      if (query.isEmpty) {
        return const Left(InvalidInputFailure('Search query cannot be empty'));
      }

      final result = await apiService.searchMeals(query);
      return Right(result);
    } on NetworkException {
      return const Left(NoInternetFailure());
    } on ParseException catch (e) {
      return Left(ServerFailure('Failed to parse server response: ${e.message}'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MealResponseModel?>> getMealById(String id) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NoInternetFailure());
      }

      if (id.isEmpty) {
        return const Left(InvalidInputFailure('Meal ID cannot be empty'));
      }

      final result = await apiService.getMealById(id);
      return Right(result);
    } on NetworkException {
      return const Left(NoInternetFailure());
    } on ParseException catch (e) {
      return Left(ServerFailure('Failed to parse server response: ${e.message}'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealResponseModel>>> getRandomMeals({
    int count = 10,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NoInternetFailure());
      }

      if (count <= 0) {
        return const Left(InvalidInputFailure('Count must be greater than 0'));
      }

      final result = await apiService.getRandomMeals(count: count);
      return Right(result);
    } on NetworkException {
      return const Left(NoInternetFailure());
    } on ParseException catch (e) {
      return Left(ServerFailure('Failed to parse server response: ${e.message}'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealResponseModel>>> getMealsByCategory(
    String category,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NoInternetFailure());
      }

      if (category.isEmpty) {
        return const Left(InvalidInputFailure('Category cannot be empty'));
      }

      final result = await apiService.getMealsByCategory(category);
      return Right(result);
    } on NetworkException {
      return const Left(NoInternetFailure());
    } on ParseException catch (e) {
      return Left(ServerFailure('Failed to parse server response: ${e.message}'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
