import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../models/address_model.dart';

class AddressService {
  final Dio _dio = DioClient.create();

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _dio.get('/addresses');

      final List data = response.data['data'];

      return data.map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      await _dio.delete('/addresses/delete/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Gagal menghapus alamat");
    }
  }

  Future<void> createAddress(Map<String, dynamic> data) async {
    await _dio.post('/addresses/store', data: data);
  }

  Future<void> updateAddress({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _dio.put('/addresses/update/$id', data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Gagal update alamat');
    }
  }
}
