// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_app/widgets/account_setting_item.dart';
import 'package:mini_app/widgets/setting_toggle_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF1B1B1F);
    const milk = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Orange header with curved accents ───────────────────────────
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  // gradient header
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFF8A3D), Color(0xFFFF5A3D)],
                      ),
                    ),
                  ),
                  // decorative soft circles
                  Positioned(
                    right: -40,
                    top: -40,
                    child: _softCircle(160, Colors.white.withOpacity(.07)),
                  ),
                  Positioned(
                    right: -10,
                    top: 50,
                    child: _softCircle(120, Colors.white.withOpacity(.06)),
                  ),

                  // header content
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title row
                          Row(
                            children: [
                              const Text(
                                'Account',
                                style: TextStyle(
                                  color: milk,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.18),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // profile row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // avatar
                              Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(.25),
                                    width: 2,
                                  ),
                                  color: Colors.white.withOpacity(.15),
                                ),
                                child: const Center(
                                  child: Text(
                                    'I',
                                    style: TextStyle(
                                      color: milk,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // name + email
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Innocent Dive',
                                      style: TextStyle(
                                        color: milk,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'kymaatech@gmail.com',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // edit chip
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.18),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.edit_note_outlined,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // rounded dark sheet overlap at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 26,
                      decoration: const BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Section title ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12,
                ),
                child: Row(
                  children: const [
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        color: milk,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Spacer(),
                    Text('View all', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),

            // ── Settings items (reusable widget) ────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              sliver: SliverList.separated(
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  switch (i) {
                    case 0:
                      return const AccountSettingItem(
                        icon: Icons.place_outlined,
                        title: 'My Address',
                        subtitle: 'Set delivery address',
                      );
                    case 1:
                      return const AccountSettingItem(
                        icon: Icons.shopping_cart_outlined,
                        title: 'My Cart',
                        subtitle: 'Add, remove products and save to checkout',
                      );
                    case 2:
                      return const AccountSettingItem(
                        icon: Icons.receipt_long_outlined,
                        title: 'My Orders',
                        subtitle: 'View all completed and incomplete orders',
                      );
                    case 3:
                      return const AccountSettingItem(
                        icon: Icons.account_balance_outlined,
                        title: 'Bank Account',
                        subtitle: 'Withdraw balance to registered bank account',
                      );
                    case 4:
                      return const AccountSettingItem(
                        icon: Icons.local_activity_outlined,
                        title: 'My Coupon',
                        subtitle: 'List of all discounted coupons',
                      );
                    default:
                      return const AccountSettingItem(
                        icon: Icons.notifications_none_rounded,
                        title: 'Notifications',
                        subtitle: 'See all notification messages',
                      );
                  }
                },
              ),
            ),

            // ── App Settings (NEW) ──────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Row(
                  children: const [
                    Text(
                      'App Settings',
                      style: TextStyle(
                        color: milk,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Spacer(),
                    Text('View all', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              sliver: SliverList.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: 4,
                itemBuilder: (_, i) {
                  switch (i) {
                    // Load Data (non-toggle)
                    case 0:
                      return const AccountSettingItem(
                        icon: Icons.cloud_upload_outlined,
                        title: 'Load Data',
                        subtitle: 'Upload Data to cloud storage',
                      );

                    // GeoLocation (toggle ON)
                    case 1:
                      return const SettingToggleItem(
                        icon: Icons.place_outlined,
                        title: 'GeoLocation',
                        subtitle: 'Products recommended based on location',
                        initialValue: true,
                        // onChanged: (v) => save...
                      );

                    // Safe Mode (toggle OFF)
                    case 2:
                      return const SettingToggleItem(
                        icon: Icons.verified_user_outlined,
                        title: 'Safe Mode',
                        subtitle: 'Safe search for all users',
                        initialValue: false,
                      );

                    // HD Image quality (toggle OFF)
                    default:
                      return const SettingToggleItem(
                        icon: Icons.image_outlined,
                        title: 'HD Image quality',
                        subtitle: 'Set image quality',
                        initialValue: false,
                      );
                  }
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  static Widget _softCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
