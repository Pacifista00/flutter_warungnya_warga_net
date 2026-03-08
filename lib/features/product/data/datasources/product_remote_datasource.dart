import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/core/network/dio_client.dart';
import 'package:flutter_warungnya_warga_net/features/product/enums/product_sort_mapper.dart';
import 'package:flutter_warungnya_warga_net/features/product/models/product_model.dart';
import 'package:flutter_warungnya_warga_net/features/product/models/product_pagination.dart';
import 'package:flutter_warungnya_warga_net/features/product/widgets/product_filter_sheet.dart';

class ProductRemoteDatasource {
  final Dio dio = DioClient.create();

  /// PRODUCT LIST
  Future<ProductPagination> getProducts({
    int page = 1,
    String search = '',
    String category = '',
    SortType sort = SortType.terbaru,
  }) async {
    final response = await dio.get(
      '/products',
      queryParameters: {
        'page': page,
        if (search.isNotEmpty) 'search': search,
        if (category.isNotEmpty) 'category': category,
        'sort': sort.apiValue,
      },
    );

    final List listData = response.data['data'] ?? [];

    return ProductPagination(
      products: listData.map((e) => ProductModel.fromJson(e)).toList(),
      currentPage: response.data['meta']?['current_page'] ?? 1,
      lastPage: response.data['meta']?['last_page'] ?? 1,
    );
  }

  // PRODUCT DETAIL
  Future<ProductModel> getProductById(String id) async {
    final response = await dio.get('/product/$id');

    return ProductModel.fromJson(response.data['data']);
  }
}
