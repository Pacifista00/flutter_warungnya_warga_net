import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/core/network/dio_client.dart';
import '../models/voucher_model.dart';

class VoucherRemoteDatasource {
  final Dio dio = DioClient.create();

  Future<List<VoucherModel>> getVouchers({int page = 1}) async {
    final response = await dio.get(
      '/vouchers',
      queryParameters: {'page': page},
    );

    final List data = response.data['data'];
    return data.map((e) => VoucherModel.fromJson(e)).toList();
  }

  Future<VoucherModel> getVoucherById(String id) async {
    final response = await dio.get('/voucher/$id');

    final data = response.data['data'];
    return VoucherModel.fromJson(data);
  }
}
