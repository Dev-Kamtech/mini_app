// lib/widgets/brand_pill.dart
import 'package:flutter/material.dart';

class BrandPill extends StatelessWidget {
  final String name;
  final int count;
  final String imageUrl; // 👈 network logo

  const BrandPill({
    super.key,
    required this.name,
    required this.count,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // no fixed width so it can flex inside a Grid cell
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Circular network logo with shimmer fallback
          SizedBox(
            width: 36,
            height: 36,
            child: ClipOval(
              child: _LogoNetwork(
                url: imageUrl,
                placeholder: const _ShimmerSkeleton(),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Name + count (tight, overflow-safe)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min, // keep as small as possible
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.1, // tighter line height
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified,
                      size: 14,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 1.5),
                Text(
                  '$count products',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    height: 1.1, // tighter line height
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small network image with shimmer while loading / on error
class _LogoNetwork extends StatelessWidget {
  final String url;
  final Widget placeholder;
  final BoxFit fit;

  const _LogoNetwork({
    required this.url,
    required this.placeholder,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return placeholder;

    return Image.network(
      url,
      fit: fit,
      // shimmer while loading
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return placeholder;
      },
      // shimmer on failure
      errorBuilder: (context, _, __) => placeholder,
    );
  }
}

/// Minimal, dependency-free shimmer (dark YouTube-style)
class _ShimmerSkeleton extends StatefulWidget {
  const _ShimmerSkeleton();

  @override
  State<_ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<_ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  static const _base = Color(0xFF232323);
  static const _hi = Color(0xFF2E2E2E);

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final dx = -1.0 + 2.0 * _c.value;
        return ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment(-1 + dx, 0),
            end: Alignment(1 + dx, 0),
            colors: const [_base, _hi, _base],
            stops: const [0.25, 0.5, 0.75],
          ).createShader(rect),
          blendMode: BlendMode.srcATop,
          child: Container(color: _base),
        );
      },
    );
  }
}
