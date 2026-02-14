import '../widgets/product_filter_sheet.dart';

extension SortTypeMapper on SortType {
  String get apiValue {
    switch (this) {
      case SortType.terbaru:
        return 'latest';
      case SortType.hargaTermurah:
        return 'price_low';
      case SortType.hargaTermahal:
        return 'price_high';
      case SortType.namaAZ:
        return 'name_asc';
    }
  }
}
