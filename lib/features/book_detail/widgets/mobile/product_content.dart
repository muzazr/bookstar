import 'package:flutter/material.dart';
import 'package:gcommerce/core/utils/image_helper.dart';
import 'package:gcommerce/core/utils/string_helper.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';
import 'package:gcommerce/core/constants/app_text_styles.dart';

import 'package:gcommerce/features/book_detail/controller/book_detail_controller.dart';
import 'package:gcommerce/features/book_detail/widgets/mobile/book_card_api.dart';
import 'package:gcommerce/features/book_detail/widgets/mobile/circle_icon_button.dart';

class ProductContent extends StatelessWidget {
  final BookDetailController controller;

  const ProductContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.md,
          top: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSpacing.md,
          ),
          Center(
            child: Text.rich(TextSpan(
                text: 'Home',
                style: AppTextStyles.title(context).copyWith(
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                      text: ' > ',
                      style: AppTextStyles.title(context).copyWith(
                          color: const Color.fromARGB(255, 194, 194, 194))),
                  TextSpan(
                      text: 'Shop',
                      style: AppTextStyles.title(context)
                          .copyWith(color: AppColors.textSecondary))
                ])),
          ),
          SizedBox(
            height: AppSpacing.md,
          ),

          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                ImageHelper.getImageUrl(controller.coverImageUrl),
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.border,
                  child: const Icon(Icons.block_outlined,
                      size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          Obx(() {
            return Wrap(
                runSpacing: AppSpacing.md,
                spacing: AppSpacing.md,
                children: controller.displayTags.map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                        color: Color(0XFFE0E0E0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      StringHelper.capitalizeEachWord(tag.name),
                      style:
                          AppTextStyles.title(context).copyWith(fontSize: 14),
                    ),
                  );
                }).toList());
          }),
          const SizedBox(height: AppSpacing.md),

          // Info produk
          Text(
            controller.title,
            style: AppTextStyles.headline(context)
                .copyWith(fontSize: 32, color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.xs),

          Text(
            controller.price,
            style: AppTextStyles.title(context).copyWith(fontSize: 24),
          ),
          const SizedBox(height: AppSpacing.xs),

          Text.rich(TextSpan(
              text: 'Availability : ',
              style: AppTextStyles.title(context)
                  .copyWith(color: AppColors.textSecondary),
              children: [
                TextSpan(
                    text: controller.availability,
                    style: TextStyle(color: AppColors.primary))
              ])),
          SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            controller.summary,
            style: AppTextStyles.body(context)
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),

          Text.rich(TextSpan(
              text: 'Pages: ',
              style: AppTextStyles.body(context).copyWith(
                  color: AppColors.textSecondary, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: controller.totalPages,
                    style: AppTextStyles.body(context))
              ])),
          Text.rich(TextSpan(
              text: 'Publisher: ',
              style: AppTextStyles.body(context).copyWith(
                  color: AppColors.textSecondary, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: controller.publisher,
                    style: AppTextStyles.body(context))
              ])),
          Text.rich(TextSpan(
              text: 'ISBN: ',
              style: AppTextStyles.body(context).copyWith(
                  color: AppColors.textSecondary, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: controller.isbn, style: AppTextStyles.body(context))
              ])),
          Text.rich(TextSpan(
              text: 'Published: ',
              style: AppTextStyles.body(context).copyWith(
                  color: AppColors.textSecondary, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: controller.publishedDate,
                    style: AppTextStyles.body(context))
              ])),

          SizedBox(
            height: AppSpacing.lg,
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            width: double.infinity,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: AppColors.primary,
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text('Buy Now',
                          style: AppTextStyles.title(context).copyWith(
                              color: AppColors.background, fontSize: 14)),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppSpacing.md,
                ),
                CircleIconButton(
                    icon: Icons.favorite_border, onPressed: () {}),
                SizedBox(width: AppSpacing.md),
                CircleIconButton(
                    icon: Icons.shopping_cart_outlined, onPressed: () {}),
                SizedBox(
                  width: AppSpacing.md,
                ),
                CircleIconButton(
                    icon: Icons.remove_red_eye_sharp, onPressed: () {})
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          Text(
            'Your Reading List',
            style: AppTextStyles.headline(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          Divider(
            color: AppColors.border,
          ),
          const SizedBox(height: AppSpacing.md),

          Obx(() {
            if (controller.isLoadingReadingList.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.readingList.isEmpty) {
              return const Text('No recommendations available');
            }

            return SizedBox(
              height: 362,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(
                  width: AppSpacing.md,
                ),
                itemCount: controller.readingList.length,
                itemBuilder: (context, index) {
                  final book = controller.readingList[index];
                  return BookCardAPI(book: book);
                },
              ),
            );
          }),

          const SizedBox(height: AppSpacing.xl),

          Text(
            'Books For You',
            style: AppTextStyles.headline(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          Divider(
            color: AppColors.border,
          ),
          const SizedBox(height: AppSpacing.md),
          Obx(
            () {
              if (controller.isLoadingBooksForYou.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.booksForYou.isEmpty) {
                return const Text('No recommendations available');
              }

              return SizedBox(
                height: 362,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: AppSpacing.md,
                  ),
                  itemCount: controller.booksForYou.length,
                  itemBuilder: (context, index) {
                    final book = controller.booksForYou[index];
                    return BookCardAPI(book: book);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}