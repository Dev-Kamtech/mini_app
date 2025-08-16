import 'package:flutter/material.dart';

/// Reusable settings row:
/// - leading icon in a soft capsule
/// - title + subtitle
/// - trailing Switch styled for dark UI
class SettingToggleItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  /// Local state default. Pass `onChanged` if you want to persist externally.
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  /// Optional theming overrides
  final Color iconColor;
  final Color bgColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color activeTrackColor; // switch track when ON
  final Color inactiveTrackColor; // switch track when OFF
  final Color thumbColor; // switch thumb color

  const SettingToggleItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.initialValue = false,
    this.onChanged,
    this.iconColor = const Color(0xFFFF6A3D), // deep orange vibe
    this.bgColor = const Color(0xFF2C2C2C), // tile background
    this.titleColor = Colors.white,
    this.subtitleColor = const Color(0xFFB8B8B8),
    this.activeTrackColor = const Color(0xFF7B61FF), // purple like screenshot
    this.inactiveTrackColor = const Color(0xFF484848),
    this.thumbColor = Colors.white,
  });

  @override
  State<SettingToggleItem> createState() => _SettingToggleItemState();
}

class _SettingToggleItemState extends State<SettingToggleItem> {
  late bool _value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // leading icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: widget.iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.iconColor.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Icon(widget.icon, color: widget.iconColor, size: 22),
          ),
          const SizedBox(width: 12),

          // texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.subtitleColor,
                    fontSize: 12.5,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // toggle
          Switch(
            value: _value,
            onChanged: (v) {
              setState(() => _value = v);
              widget.onChanged?.call(v);
            },
            activeColor: widget.thumbColor, // thumb
            activeTrackColor: widget.activeTrackColor, // track ON
            inactiveThumbColor: widget.thumbColor.withValues(alpha: 0.85),
            inactiveTrackColor: widget.inactiveTrackColor, // track OFF
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
