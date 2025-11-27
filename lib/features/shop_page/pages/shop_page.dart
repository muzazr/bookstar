import 'package:flutter/material.dart';
import 'package:gcommerce/core/utils/responsive.dart';
import 'package:gcommerce/features/shop_page/views/shop_page_desktop.dart';
import 'package:gcommerce/features/shop_page/views/shop_page_mobile.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return ShopPageDesktop();
    } else {
      return ShopPageMobile();
    }
  }
}
