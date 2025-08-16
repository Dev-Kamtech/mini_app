// lib/pages/wishlist_page.dart
import 'package:flutter/material.dart';
import 'package:mini_app/service/wishlist_service.dart';
import 'package:mini_app/data/models/product_list.dart';
import 'package:mini_app/widgets/product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistService.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1F),
        elevation: 0,
        title: const Text('Wishlist'),
        actions: [
          ValueListenableBuilder(
            valueListenable: wishlist.listenable,
            builder: (context, Map<String, Product> map, _) {
              return IconButton(
                tooltip: 'Clear all',
                onPressed: map.isEmpty ? null : wishlist.clear,
                icon: const Icon(Icons.delete_outline),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Map<String, Product>>(
        valueListenable: wishlist.listenable,
        builder: (context, map, _) {
          final items = map.values.toList();

          if (items.isEmpty) {
            return const Center(
              child: Text(
                'No items in your wishlist yet.\nTap the heart on any product.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          // Grid of saved cards (re-using ProductCard)
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (_, i) => ProductCard(product: items[i]),
            ),
          );
        },
      ),
    );
  }
}
