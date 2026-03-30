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
  ProductCategory(
    'Ibu & Anak',
    'ibu-anak',
    'assets/svg/category_logo/Ibu&Anak.svg',
  ),
  ProductCategory('Herbal', 'herbal', 'assets/svg/category_logo/Herbal.svg'),
  ProductCategory(
    'Kecantikan',
    'kecantikan',
    'assets/svg/category_logo/Kecantikan.svg',
  ),
  ProductCategory(
    'Kebersihan',
    'kebersihan',
    'assets/svg/category_logo/Kebersihan.svg',
  ),
  ProductCategory(
    'Kantor',
    'perlengkapan-sekolah-kantor',
    'assets/svg/category_logo/Alat Tulis.svg',
  ),
  ProductCategory('Hobi', 'hobi', 'assets/svg/category_logo/Hobi.svg'),
  ProductCategory(
    'Kesehatan',
    'kesehatan',
    'assets/svg/category_logo/Kesehatan.svg',
  ),
  ProductCategory(
    'Rumah Tangga',
    'rumah-tangga',
    'assets/svg/category_logo/RumahTangga.svg',
  ),
];
