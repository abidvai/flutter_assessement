import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_assessment_task/core/constant/api_constant.dart';
import 'package:flutter_assessment_task/core/network/connectivity_interceptor.dart';
import 'package:flutter_assessment_task/core/network/network_info.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(ConnectivityInterceptor(NetworkInfo(Connectivity())));

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: false,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    return dio;
  }
}
