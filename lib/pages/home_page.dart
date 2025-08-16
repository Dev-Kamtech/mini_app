// ignore_for_file: always_use_package_imports, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mini_app/data/sample/demo_data.dart';
import 'package:mini_app/widgets/image_slider.dart';
import 'package:mini_app/widgets/category_item.dart';
import 'package:mini_app/widgets/product_card.dart';
import 'package:mini_app/widgets/search_bar_widget.dart';
import 'package:mini_app/data/models/product_list.dart'; // Product, Category, demoCategories

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> carouselImages1 = const [
    'assets/images/clothes.jpg',
    'assets/images/dog.jpg',
    'assets/images/smart_watch.jpg',
  ];
  final List<String> carouselImages2 = const [
    'assets/images/clothes.jpg',
    'assets/images/dog.jpg',
    'assets/images/smart_watch.jpg',
  ];

  /// Get 4 random products from all categories
  List<Product> getRandomProducts() {
    final allProducts = demoCategories.expand((c) => c.products).toList();
    allProducts.shuffle(Random());
    return allProducts.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    final randomProducts = getRandomProducts();

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Shopping made easy today",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              "Felix Divine",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                const SearchBarWidget(
                  hintTexts: [
                    "Search in Market",
                    "Find your favorite products",
                    "Discover amazing deals",
                  ],
                ),

                const SizedBox(height: 40),

                // Carousel Slider
                ImageSlider(images: carouselImages1, isAsset: true),
                const SizedBox(height: 30),

                // Popular Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Popular Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("View all", style: TextStyle(color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 40),

                // Categories Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CategoryItem(icon: Icons.emoji_events, label: "Sports"),
                      CategoryItem(icon: Icons.diamond, label: "Jewelry"),
                      CategoryItem(icon: Icons.laptop, label: "Electronics"),
                      CategoryItem(icon: Icons.checkroom, label: "Clothes"),
                      CategoryItem(icon: Icons.pets, label: "Animals"),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Popular Products
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Popular Products",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("View all", style: TextStyle(color: Colors.blue)),
                  ],
                ),
                const SizedBox(height: 20),

                // Products Grid (random 4) - updated call
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: randomProducts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final p = randomProducts[index];
                    return ProductCard(product: p); // ✅ updated
                  },
                ),
                const SizedBox(height: 40),

                // Another Carousel Slider
                ImageSlider(images: carouselImages2, isAsset: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
