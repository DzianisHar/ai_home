import 'dart:async';

import 'package:ai_home/core/network/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'package:ai_home/core/error/exceptions.dart';

typedef Json = Map<String, dynamic>;

@lazySingleton
class ApiClient {
  final Dio _dio;
  final Logger _logger;

  ApiClient(this._dio, this._logger) {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: ApiConstants.defaultHeaders,
    );
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Request failed with status: ${response.statusCode}',
          statusCode: response.statusCode,
          data: response.data,
          stackTrace: StackTrace.current,
        );
      }

      return response.data ?? {};
    } on DioException catch (e) {
      _logger.e('Dio error: ${e.message}', error: e, stackTrace: e.stackTrace);

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: 'Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'No internet connection');
      } else if (e.response != null) {
        throw ServerException(
          message: 'Server error: ${e.response?.statusCode}',
        );
      } else {
        throw ServerException(
          message: 'Network error: ${e.message}',
        );
      }
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error', error: e, stackTrace: stackTrace);
      throw ServerException(
        message: 'Unexpected error',
      );
    }
  }

  Future<List<dynamic>> getList(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Request failed with status: ${response.statusCode}',
        );
      }

      return response.data ?? [];
    } on DioException catch (e) {
      _logger.e('Dio error: ${e.message}', error: e, stackTrace: e.stackTrace);

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(message: 'Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'No internet connection');
      } else if (e.response != null) {
        throw ServerException(
          message: 'Server error: ${e.response?.statusCode}',
        );
      } else {
        throw ServerException(
          message: 'Network error: ${e.message}',
        );
      }
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      _logger.e('Unexpected error', error: e, stackTrace: stackTrace);
      throw ServerException(
        message: 'Unexpected error',
      );
    }
  }
}
