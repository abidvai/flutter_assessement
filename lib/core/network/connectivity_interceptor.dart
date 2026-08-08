import 'package:dio/dio.dart';
import 'package:flutter_assessment_task/core/error/exception.dart';
import 'package:flutter_assessment_task/core/network/network_info.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._networkInfo);

  final NetworkInfo _networkInfo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: NetworkException('No internet connection'),
          type: DioExceptionType.connectionError,
        ),
      );
    }
    return handler.next(options);
  }
}
