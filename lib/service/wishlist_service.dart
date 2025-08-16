// lib/services/wishlist_service.dart
import 'package:flutter/foundation.dart';
import 'package:mini_app/data/models/product_list.dart'; // Product model

class WishlistService {
  WishlistService._();
  static final WishlistService instance = WishlistService._();

  /// key = product id, value = product
  final ValueNotifier<Map<String, Product>> _items =
      ValueNotifier<Map<String, Product>>({});

  ValueListenable<Map<String, Product>> get listenable => _items;

  List<Product> get items => _items.value.values.toList(growable: false);

  bool contains(String productId) => _items.value.containsKey(productId);

  void toggle(Product product) {
    final next = Map<String, Product>.from(_items.value);
    if (next.containsKey(product.id)) {
      next.remove(product.id);
    } else {
      next[product.id] = product;
    }
    _items.value = next;
  }

  void remove(String productId) {
    if (!_items.value.containsKey(productId)) return;
    final next = Map<String, Product>.from(_items.value)..remove(productId);
    _items.value = next;
  }

  void clear() {
    _items.value = {};
  }
}
