// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mini_app/data/models/product_list.dart';
import 'package:mini_app/service/wishlist_service.dart';

/// ProductCard (overflow-safe) + YouTube-style shimmer + Wishlist toggle
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = WishlistService.instance;

    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE AREA
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  // Image
                  Positioned.fill(
                    child: _ProductImage(
                      path: product.imagePath,
                      placeholder: const _ShimmerSkeleton(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Discount tag (or NEW)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (product.discountLabel.isEmpty)
                            ? 'NEW'
                            : product.discountLabel,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  // Heart (wishlist)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: ValueListenableBuilder<Map<String, Product>>(
                      valueListenable: wishlist.listenable,
                      builder: (context, map, _) {
                        final isSaved = map.containsKey(product.id);
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => wishlist.toggle(product),
                          child: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            color: isSaved ? Colors.redAccent : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TEXTS
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              product.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              product.company,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),

          // PRICES + ADD BUTTON
          SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.oldPriceLabel,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.newPriceLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Image widget with shimmer
class _ProductImage extends StatelessWidget {
  final String path;
  final Widget placeholder;
  final BoxFit fit;

  const _ProductImage({
    required this.path,
    required this.placeholder,
    this.fit = BoxFit.cover,
  });

  bool get _isNetwork =>
      path.startsWith('http://') || path.startsWith('https://');

  Future<bool> _assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isNetwork) {
      return Image.network(
        path,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder;
        },
        errorBuilder: (context, _, __) => placeholder,
      );
    } else {
      return FutureBuilder<bool>(
        future: _assetExists(path),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return placeholder;
          }
          if (snapshot.data == true) {
            return Image.asset(path, fit: fit);
          }
          return placeholder;
        },
      );
    }
  }
}

/// Dependency-free dark shimmer (YouTube-style)
class _ShimmerSkeleton extends StatefulWidget {
  const _ShimmerSkeleton();

  @override
  State<_ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<_ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const Color _base = Color(0xFF232323);
  static const Color _highlight = Color(0xFF2E2E2E);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final dx = -1.0 + 2.0 * _controller.value;
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1.0 + dx, 0),
              end: Alignment(1.0 + dx, 0),
              colors: const [_base, _highlight, _base],
              stops: const [0.25, 0.5, 0.75],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: Container(color: _base),
        );
      },
    );
  }
}
