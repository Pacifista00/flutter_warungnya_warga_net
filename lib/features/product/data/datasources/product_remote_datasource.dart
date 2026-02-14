import 'package:dio/dio.dart';
import 'package:flutter_warungnya_warga_net/core/network/dio.dart';
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
        if (category.isNotEmpty) 'category': category, // 👈 SLUG
        'sort': sort.apiValue,
      },
    );

    return ProductPagination(
      products:
          (response.data['data'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
      currentPage: response.data['meta']['current_page'],
      lastPage: response.data['meta']['last_page'],
    );
  }

  // PRODUCT DETAIL
  Future<ProductModel> getProductById(String id) async {
    final response = await dio.get('/product/$id');

    return ProductModel.fromJson(response.data['data']);
  }
}
