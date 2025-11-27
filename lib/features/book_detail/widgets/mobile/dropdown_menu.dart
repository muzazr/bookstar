import 'package:flutter/material.dart';
import 'package:gcommerce/features/shop_page/pages/shop_page.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';
import 'package:gcommerce/core/constants/app_text_styles.dart';

import 'package:gcommerce/features/book_detail/controller/nav_menu_controller.dart';

Widget buildDropdownMenu(
    BuildContext context, NavMenuController navMenuController) {
  return Column(
    children: [
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _MenuItem(label: 'Home', onTap: () {}, isActive: true),
            _MenuItem(
                label: 'Shop',
                onTap: () {
                  Get.offAll(() => ShopPage());
                },
                isActive: true),
            _MenuItem(label: 'About', onTap: () {}, isActive: true),
            _MenuItem(label: 'Blog', onTap: () {}, isActive: true),
            _MenuItem(label: 'Contact', onTap: () {}, isActive: true),
            _MenuItem(label: 'Pages', onTap: () {}, isActive: true),
            SizedBox(height: AppSpacing.md),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline_outlined,
                    color: AppColors.primary,
                  ),
                  Text(
                    'Login / Register',
                    style: AppTextStyles.caption(context)
                        .copyWith(fontSize: 18, color: AppColors.primary),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSpacing.sm,
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              height: AppSpacing.sm,
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              height: AppSpacing.sm,
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.favorite_border_outlined,
                color: AppColors.primary,
              ),
            )
          ],
        ),
      )
    ],
  );
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final style =
        AppTextStyles.caption(context).copyWith(
            color: AppColors.textSecondary,
            fontSize: 18);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Text(
          label,
          style: style,
        ),
      ),
    );
  }
}
