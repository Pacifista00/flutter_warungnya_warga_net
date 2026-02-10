import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/config/env/dev_env.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: DevEnv.baseUrl,
        connectTimeout: const Duration(seconds: 15),
      ),
    );

    return dio;
  }
}
