import 'package:flutter/material.dart';
import 'package:gcommerce/core/utils/image_helper.dart';
import 'package:gcommerce/core/utils/string_helper.dart';
import 'package:gcommerce/data/book_models.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';
import 'package:gcommerce/core/constants/app_text_styles.dart';

import 'package:gcommerce/features/book_detail/pages/book_detail_page.dart';
import 'package:gcommerce/features/book_detail/controller/book_detail_controller.dart';

class BookCardAPI extends StatelessWidget {
  const BookCardAPI({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.appBarBackground,
      child: InkWell(
        onTap: () {
          Get.delete<BookDetailController>(force: true);
          Get.offAll(() => ProductDetailPage(), arguments: book);
        },
        splashColor: AppColors.primary.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(color: AppColors.appBarBackground),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ImageHelper.getImageUrl(book.coverImage),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.border,
                      child: const Icon(Icons.block_outlined,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSpacing.sm,
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.title(context),
                    ),
                    const SizedBox(
                      height: AppSpacing.xs,
                    ),
                    Text(
                      StringHelper.capitalizeEachWord(book.category.name),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body(context)
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(
                      height: AppSpacing.xs,
                    ),
                    Text(book.details.price,
                        style: AppTextStyles.body(context)
                            .copyWith(color: AppColors.accent))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}