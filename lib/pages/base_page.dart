// lib/pages/base_page.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mini_app/pages/profile_page.dart';
import 'package:mini_app/pages/store_page.dart';
import 'package:mini_app/pages/wishlist_page.dart';
import 'package:mini_app/service/wishlist_service.dart'; // ✅ import wishlist
import 'package:mini_app/pages/home_page.dart';

class BasePage extends StatefulWidget {
  final int initialIndex;
  const BasePage({super.key, this.initialIndex = 0});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _currentIndex;

  final List<Widget> _pages = [
    HomePage(),
    StorePage(),
    WishlistPage(),
    ProfilePage(), // Assuming you have a ProfilePage
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.store,
    Icons.favorite_border,
    Icons.person_outline,
  ];

  final List<String> _labels = ["Home", "Store", "Wishlist", "Profile"];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistService.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        color: const Color(0xFF1E1E1E),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            bool isSelected = _currentIndex == index;

            // Wrap Wishlist tab with ValueListenableBuilder
            if (_labels[index] == "Wishlist") {
              return ValueListenableBuilder(
                valueListenable: wishlist.listenable,
                builder: (context, map, _) {
                  final count = map.length;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: isSelected ? 16 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.deepOrange.shade400
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                _icons[index],
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                              if (count > 0)
                                Positioned(
                                  right: -6,
                                  top: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Colors.deepOrange,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "$count",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 8),
                            AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                _labels[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            // Normal tabs (Home, Store, Profile)
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: isSelected ? 16 : 0,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.deepOrange.shade400
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      _icons[index],
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          _labels[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
