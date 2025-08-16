// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final List<String> hintTexts; // Multiple hints can be cycled
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.hintTexts = const ["Search in Market"],
    this.onChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  late String _displayedText;
  int _hintIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _displayedText = "";
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      String currentHint = widget.hintTexts[_hintIndex];

      setState(() {
        if (!_isDeleting) {
          // Typing forward
          if (_charIndex < currentHint.length) {
            _displayedText = currentHint.substring(0, _charIndex + 1);
            _charIndex++;
          } else {
            _isDeleting = true;
          }
        } else {
          // Deleting backwards
          if (_charIndex > 0) {
            _displayedText = currentHint.substring(0, _charIndex - 1);
            _charIndex--;
          } else {
            _isDeleting = false;
            _hintIndex = (_hintIndex + 1) % widget.hintTexts.length;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        focusNode: _focusNode,
        style: const TextStyle(color: Colors.white),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: _displayedText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
