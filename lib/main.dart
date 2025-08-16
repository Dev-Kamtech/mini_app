// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:mini_app/pages/base_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const BasePage(initialIndex: 0),
    );
  }
}
