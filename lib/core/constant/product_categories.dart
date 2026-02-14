class ProductCategory {
  final String label;
  final String slug;

  const ProductCategory(this.label, this.slug);
}

const productCategories = [
  ProductCategory('Semua', ''),
  ProductCategory('Fashion', 'fashion'),
  ProductCategory('Makanan', 'makanan'),
  ProductCategory('Herbal', 'herbal'),
  ProductCategory('Kecantikan', 'kecantikan'),
  ProductCategory('Alat Tulis', 'alat-tulis'),
  ProductCategory('Elektronik', 'elektronik'),
];
