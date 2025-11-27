import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gcommerce/features/shop_page/pages/shop_page.dart';

void main() {
  runApp(const GCommerceApp());
}

class GCommerceApp extends StatelessWidget {
  const GCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookstar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShopPage(),
    );
  }
}