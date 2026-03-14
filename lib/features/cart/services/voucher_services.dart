import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/core/network/dio_client.dart';

class VoucherService {
  final Dio _dio = DioClient.create();

  Future<Map<String, dynamic>> previewVoucher(String code) async {
    final response = await _dio.post("/voucher/preview", data: {"code": code});

    return response.data;
  }
}
