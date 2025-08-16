// lib/pages/store_page.dart
// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:mini_app/data/sample/demo_data.dart';
// Use the same casing as your actual folder name:
import 'package:mini_app/widgets/brand_pill.dart';
import 'package:mini_app/data/models/product_list.dart'; // Product, Category, demoCategories
import 'package:mini_app/widgets/product_card.dart';
import 'package:mini_app/widgets/search_bar_widget.dart';

/// ------------------------------
/// Store Page
/// ------------------------------
class StorePage extends StatelessWidget {
  final List<Category> categories;

  const StorePage({super.key, this.categories = const []});

  List<Category> _effectiveCategories() =>
      categories.isNotEmpty ? categories : demoCategories;

  @override
  Widget build(BuildContext context) {
    final cats = _effectiveCategories();

    // Colors to match your dark style
    const bg = Color(0xFF1B1B1F); // near-pure black with slight warmth
    const card = Color(0xFF2C2C2C);
    const milk = Color(0xFFF5F5F5);

    return DefaultTabController(
      length: cats.length,
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: Column(
            children: [
              // Header Row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                child: Row(
                  children: [
                    const Text(
                      'Store',
                      style: TextStyle(
                        color: milk,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: card,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          right: 4,
                          top: 2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.deepOrange,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: SearchBarWidget(
                  hintTexts: [
                    "Search in Market",
                    "Find your favorite products",
                    "Discover amazing deals",
                  ],
                ),
              ),

              // Featured Brands
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
                child: Row(
                  children: [
                    const Text(
                      'Featured Brands',
                      style: TextStyle(
                        color: milk,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View all',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              // Featured Brands (2 per row)
              // In store_page.dart (Featured Brands grid)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3.4, // try 3.2–3.6 to avoid overflow
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    BrandPill(
                      name: 'Adidas',
                      count: 100,
                      imageUrl: 'https://logo.clearbit.com/adidas.com',
                    ),
                    BrandPill(
                      name: 'Nike',
                      count: 50,
                      imageUrl: 'https://logo.clearbit.com/nike.com',
                    ),
                    BrandPill(
                      name: 'Dell',
                      count: 20,
                      imageUrl: 'https://logo.clearbit.com/dell.com',
                    ),
                    BrandPill(
                      name: 'IKEA',
                      count: 60,
                      imageUrl: 'https://logo.clearbit.com/ikea.com',
                    ),
                    BrandPill(
                      name: 'Apple',
                      count: 30,
                      imageUrl: 'https://logo.clearbit.com/apple.com',
                    ),
                  ],
                ),
              ),

              // Category Tabs
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.deepOrange,
                  labelColor: milk,
                  unselectedLabelColor: Colors.white70,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  tabs: [for (final c in cats) Tab(text: c.name)],
                ),
              ),

              // Products Grid for Selected Category
              Expanded(
                child: TabBarView(
                  children: [
                    for (final c in cats)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: c.products.length,
                          itemBuilder: (context, index) {
                            final p = c.products[index];
                            return ProductCard(product: p); // ✅ unified call
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
