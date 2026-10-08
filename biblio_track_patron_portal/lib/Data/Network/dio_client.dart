import 'dart:io';

import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Network/api_error_interceptor.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class DioClient
{
  DioClient._();

  // Android emulator: 10.0.2.2 | iOS simulator / web / desktop: localhost | physical device: your LAN IP
  static const String _baseUrl = 'http://10.0.2.2:5224/api';

  static Dio? _instance;

  static Dio get instance
  {
    _instance ??= _buildDio();
    return _instance!;
  }

  static Dio _buildDio()
  {
    final dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(ApiErrorInterceptor());

    // DEV ONLY — accept the ASP.NET Core self-signed dev certificate.
    // Never ship this in a release build.
    if (kDebugMode)
    {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = ()
      {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }


    return dio;
  }
}