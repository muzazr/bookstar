import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../views/book_detail_mobile.dart';
import '../views/book_detail_desktop.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return ProductDetailDesktop();
    } else {
      return ProductDetailMobile();
    }
  }
}