import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';
import 'package:gcommerce/core/constants/app_text_styles.dart';

import 'package:gcommerce/features/book_detail/controller/nav_menu_controller.dart';
import 'package:gcommerce/features/book_detail/controller/book_detail_controller.dart';
import 'package:gcommerce/features/book_detail/widgets/mobile/product_content.dart';
import 'package:gcommerce/features/book_detail/widgets/mobile/dropdown_menu.dart';

class ProductDetailMobile extends StatelessWidget {
  ProductDetailMobile({
    super.key,
  });

  late final BookDetailController bookDetailController = Get.put(
      BookDetailController(),
      tag: DateTime.now().millisecondsSinceEpoch.toString());
  final NavMenuController navMenuController = Get.put(NavMenuController());

  @override
  Widget build(BuildContext context) {
    navMenuController.isOpen.value = false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: Text(
          'Bookstar',
          style: AppTextStyles.headline(context).copyWith(fontSize: 24),
        ),
        actions: [
          IconButton(
              onPressed: () {
                navMenuController.toggle();
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (!navMenuController.isOpen.value)
                return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Container(
                    color: AppColors.appBarBackground,
                    child: buildDropdownMenu(context, navMenuController)),
              );
            }),
            Obx(() {
              // loading
              if (bookDetailController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // error
              if (bookDetailController.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(
                        height: AppSpacing.sm,
                      ),
                      Text(bookDetailController.errorMessage.value),
                      const SizedBox(
                        height: AppSpacing.sm,
                      ),
                      ElevatedButton(
                          onPressed: () =>
                              bookDetailController.fetchBookDetail(),
                          child: const Text('Retry'))
                    ],
                  ),
                );
              }

              // no data
              if (bookDetailController.currentBook.value == null) {
                return const Center(
                  child: Text('No book data'),
                );
              }

              // success
              return Expanded(
                child: ProductContent(
                  controller: bookDetailController,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}