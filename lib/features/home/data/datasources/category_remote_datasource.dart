import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/core/network/dio_client.dart';
import 'package:flutter_warungnya_warga_net/features/home/data/models/category_model.dart';

class CategoryRemoteDatasource {
  final Dio dio = DioClient.create();

  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get('/categories');

    final List data = response.data['data'];

    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }
}
