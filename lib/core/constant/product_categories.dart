class ProductCategory {
  final String label;
  final String slug;
  final String icon;

  const ProductCategory(this.label, this.slug, this.icon);
}

const productCategories = [
  // ProductCategory('Semua', '', ''),
  ProductCategory('Makanan', 'makanan', 'assets/svg/category_logo/Makanan.svg'),
  ProductCategory('Fashion', 'fashion', 'assets/svg/category_logo/Fashion.svg'),
  ProductCategory(
    'Elektronik',
    'elektronik',
    'assets/svg/category_logo/Elektronik.svg',
  ),
  ProductCategory('Minuman', 'minuman', 'assets/svg/category_logo/Minuman.svg'),
  ProductCategory('Herbal', 'herbal', 'assets/svg/category_logo/Herbal.svg'),
  ProductCategory(
    'Kecantikan',
    'kecantikan',
    'assets/svg/category_logo/Kecantikan.svg',
  ),
  ProductCategory(
    'Olahraga',
    'olahraga',
    'assets/svg/category_logo/Olahraga.svg',
  ),
  ProductCategory('Buku', 'buku', 'assets/svg/category_logo/Buku.svg'),
  ProductCategory('Hobi', 'hobi', 'assets/svg/category_logo/Hobi.svg'),
  ProductCategory(
    'Kesehatan',
    'kesehatan',
    'assets/svg/category_logo/Kesehatan.svg',
  ),
  ProductCategory(
    'Alat Tulis',
    'alat-tulis',
    'assets/svg/category_logo/Alat Tulis.svg',
  ),
];
