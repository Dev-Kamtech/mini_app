/// ------------------------------
/// Data Models
/// ------------------------------
class Product {
  final String id;
  final String name;
  final String company;
  final String imagePath; // now using NETWORK URLs
  final double oldPrice;
  final double newPrice;

  const Product({
    required this.id,
    required this.name,
    required this.company,
    required this.imagePath,
    required this.oldPrice,
    required this.newPrice,
  });

  String get discountLabel {
    if (oldPrice <= 0 || newPrice >= oldPrice) return '';
    final pct = ((1 - (newPrice / oldPrice)) * 100).round();
    return '- $pct%';
  }

  String get oldPriceLabel => '\$${oldPrice.toStringAsFixed(0)}';
  String get newPriceLabel => '\$${newPrice.toStringAsFixed(0)}';
}

class Category {
  final String name;
  final List<Product> products;
  const Category({required this.name, required this.products});
}

/// ------------------------------
/// Sample In-Memory Store Data
/// All imagePath values are NETWORK images
/// ------------------------------
