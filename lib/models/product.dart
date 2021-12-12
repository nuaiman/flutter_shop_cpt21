class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String productCategoryName;
  final String brand;
  final int quantity;
  final bool isFavorite;
  final bool isPopular;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.description,
    required this.imageUrl,
    required this.isFavorite,
    required this.isPopular,
    required this.price,
    required this.productCategoryName,
    required this.quantity,
  });
}
