import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_app/pages/profile_page.dart';
import 'package:mini_app/pages/store_page.dart';
import 'package:mini_app/pages/wishlist_page.dart';
import 'package:mini_app/pages/home_page.dart';
import 'package:mini_app/service/wishlist_service.dart';

import 'package:mini_app/cubit/nav_cubit.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  List<Widget> get _pages => const [
    HomePage(), // 0
    StorePage(), // 1
    WishlistPage(), // 2
    ProfilePage(), // 3
  ];

  List<IconData> get _icons => const [
    Icons.home,
    Icons.store,
    Icons.favorite_border,
    Icons.person_outline,
  ];

  List<String> get _labels => const ["Home", "Store", "Wishlist", "Profile"];

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistService.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      body: BlocBuilder<NavCubit, int>(
        builder: (context, currentIndex) {
          return IndexedStack(index: currentIndex, children: _pages);
        },
      ),

      // BOTTOM NAV: also driven by the same Cubit state
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        color: const Color(0xFF1E1E1E),
        child: BlocBuilder<NavCubit, int>(
          builder: (context, currentIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_icons.length, (index) {
                final isSelected = currentIndex == index;
                final isWishlist = _labels[index] == "Wishlist";

                void onTap() {
                  context.read<NavCubit>().selectTab(index);
                }

                if (isWishlist) {
                  // Wishlist tab shows live badge from WishlistService (ValueNotifier)
                  return ValueListenableBuilder(
                    valueListenable: wishlist.listenable,
                    builder: (context, map, _) {
                      final count = map.length;

                      return GestureDetector(
                        onTap: onTap,
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
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey,
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
                                      fontWeight: FontWeight.w600,
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

                // Other tabs (Home, Store, Profile)
                return GestureDetector(
                  onTap: onTap,
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
                          Text(
                            _labels[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
