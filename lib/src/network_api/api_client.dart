import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/logger_utils.dart';
import 'api_interceptor.dart';
import 'api_response.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  late Dio _dio;
  bool _initialized = false;

  void initialize({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(seconds: 30),
    Map<String, dynamic>? extraHeaders,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        headers: extraHeaders,
      ),
    );

    _dio.interceptors.add(ApiInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }
    _initialized = true;
    AppLogger.info('✅ ApiClient initialized: $baseUrl');
  }

  Dio get dio {
    if (!_initialized) throw Exception('ApiClient not initialized!');
    return _dio;
  }

  // ─── GET ──────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.get(endpoint, queryParameters: queryParams);
      final data = fromJson != null ? fromJson(response.data) : response.data;
      return ApiResponse.success(data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(
        message: _parseError(e),
        statusCode: e.response?.statusCode,
        // errors: e.response?.data,
      );
    }
  }

  // ─── POST ─────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: body,
        queryParameters: queryParams,
      );
      final data = fromJson != null ? fromJson(response.data) : response.data;
      return ApiResponse.success(data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(
        message: _parseError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  // ─── PUT ──────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic body,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.put(endpoint, data: body);
      final data = fromJson != null ? fromJson(response.data) : response.data;
      return ApiResponse.success(data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(
        message: _parseError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  // ─── PATCH ────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    dynamic body,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.patch(endpoint, data: body);
      final data = fromJson != null ? fromJson(response.data) : response.data;
      return ApiResponse.success(data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(
        message: _parseError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  // ─── DELETE ───────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.delete(endpoint);
      final data = fromJson != null ? fromJson(response.data) : response.data;
      return ApiResponse.success(data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(
        message: _parseError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  // ─── Upload ───────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> upload<T>(
    String endpoint, {
    required FormData formData,
    Function(int, int)? onSendProgress,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );
      final data = fromJson != null ? fromJson(response.data) : response.data;
      return ApiResponse.success(data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return ApiResponse.error(
        message: _parseError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  // ─── Error Parser ─────────────────────────────────────────────────────────

  String _parseError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timed out. Please check your internet.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Server is taking too long to respond.';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection.';
    }
    final data = e.response?.data;
    if (data is Map) {
      return data['message'] ?? data['error'] ?? 'Something went wrong.';
    }
    return e.message ?? 'Something went wrong.';
  }
}
