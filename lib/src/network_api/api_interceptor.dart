import 'package:dio/dio.dart';

import '../shared_prefs/prefs_keys.dart';
import '../shared_prefs/prefs_service.dart';
import '../utils/logger_utils.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Inject auth token
    final token = PrefsService.instance.getString(PrefsKeys.authToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    AppLogger.info('➡️ [${options.method}] ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info(
      '✅ [${response.statusCode}] ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.error(
      '❌ [${err.response?.statusCode}] ${err.requestOptions.path}: ${err.message}',
    );

    // Handle 401 - Token Refresh
    if (err.response?.statusCode == 401) {
      // unawaited(tokenProvider.clearToken());
      // TODO: Implement token refresh logic here
      AppLogger.warning('⚠️ Unauthorized - Token may be expired');
    }

    handler.next(err);
  }
}
