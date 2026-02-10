import 'product_model.dart';

class ProductPagination {
  final List<ProductModel> products;
  final int currentPage;
  final int lastPage;

  ProductPagination({
    required this.products,
    required this.currentPage,
    required this.lastPage,
  });
}
