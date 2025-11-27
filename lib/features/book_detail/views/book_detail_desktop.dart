import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';

import 'package:gcommerce/features/book_detail/controller/book_detail_controller.dart';
import 'package:gcommerce/features/book_detail/widgets/desktop/product_content_desktop.dart';

class ProductDetailDesktop extends StatelessWidget {
  ProductDetailDesktop({
    super.key,
  });

  late final BookDetailController bookDetailController = Get.put(
      BookDetailController(),
      tag: DateTime.now().millisecondsSinceEpoch.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
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
                  Text(bookDetailController.errorMessage. value),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          bookDetailController. fetchBookDetail(),
                      child: const Text('Retry'))
                ],
              ),
            );
          }

          // no data
          if (bookDetailController. currentBook.value == null) {
            return const Center(
              child: Text('No book data'),
            );
          }

          // success
          return ProductContentDesktop(
            controller: bookDetailController,
          );
        }),
      ),
    );
  }
}