import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiRepository {
  ApiRepository(this.getToken) {
    final options = BaseOptions(
      validateStatus: (status) => (status ?? 500) < 400,
      contentType: Headers.jsonContentType,
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
    dio.transformer = BackgroundTransformer();
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        client.badCertificateCallback = (
          X509Certificate cert,
          String host,
          int port,
        ) =>
            true;
        return client;
      },
    );

    if (kDebugMode) dio.interceptors.add(logger);
  }

  late Dio dio;

  Future<String?> Function()? getToken;

  static String appVersion = '';

  set url(String url) {
    dio.options.baseUrl = url;
  }

  String get url => dio.options.baseUrl;

  Response noInternet(RequestOptions options) => Response(
        requestOptions: options,
        statusCode: 500,
        statusMessage: 'No Internet',
      );

  final logger = PrettyDioLogger(
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  );
}
