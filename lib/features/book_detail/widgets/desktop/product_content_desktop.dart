import 'package:flutter/material.dart';
import 'package:gcommerce/core/utils/image_helper.dart';
import 'package:gcommerce/core/utils/string_helper.dart';
import 'package:gcommerce/features/shop_page/pages/shop_page.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';
import 'package:gcommerce/core/constants/app_text_styles.dart';

import 'package:gcommerce/features/book_detail/controller/book_detail_controller.dart';
import 'package:gcommerce/features/book_detail/widgets/mobile/book_card_api.dart';
import 'package:gcommerce/features/book_detail/widgets/mobile/circle_icon_button.dart';

class ProductContentDesktop extends StatelessWidget {
  final BookDetailController controller;

  const ProductContentDesktop({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
      
    final screenWidth = MediaQuery.of(context).size. width; 

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: AppSpacing.xl * 4,
        right: AppSpacing.xl * 2,
        left: AppSpacing.xl * 2
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.appBarBackground
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Text(
                      '$screenWidth', //1536
                      style: AppTextStyles.headline(context)
                          .copyWith(fontSize: 24),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        _MenuItem(label: 'Home', onTap: () {}, isActive: true),
                        const SizedBox(width: AppSpacing.md),
                        _MenuItem(
                            label: 'Shop',
                            onTap: () {
                              Get.offAll(() => ShopPage());
                            },
                            isActive: true),
                            const SizedBox(width: AppSpacing.md),
                        _MenuItem(label: 'About', onTap: () {}, isActive: true),
                        const SizedBox(width: AppSpacing.md),
                        _MenuItem(label: 'Blog', onTap: () {}, isActive: true),
                        const SizedBox(width: AppSpacing.md),
                        _MenuItem(
                            label: 'Contact', onTap: () {}, isActive: true),
                            const SizedBox(width: AppSpacing.md),
                        _MenuItem(label: 'Pages', onTap: () {}, isActive: true),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
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
                                style: AppTextStyles.caption(context).copyWith(
                                    fontSize: 18, 
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600
                                    ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: AppSpacing.md,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.search_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          width: AppSpacing.md,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          width: AppSpacing.md,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text.rich(TextSpan(
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
              const SizedBox(height: AppSpacing.xl),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side - Image
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          ImageHelper.getImageUrl(controller.coverImageUrl),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.border,
                            child: const Icon(Icons.block_outlined,
                                size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.xl * 2),

                  // Right Side - Info
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tags
                        Obx(() {
                          return Wrap(
                              runSpacing: AppSpacing.md,
                              spacing: AppSpacing.md,
                              children: controller.displayTags.map((tag) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: AppSpacing.xs),
                                  decoration: BoxDecoration(
                                      color: const Color(0XFFE0E0E0),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    StringHelper.capitalizeEachWord(tag.name),
                                    style: AppTextStyles.title(context)
                                        .copyWith(fontSize: 14),
                                  ),
                                );
                              }).toList());
                        }),
                        const SizedBox(height: AppSpacing.lg),

                        // Title
                        Text(
                          controller.title,
                          style: AppTextStyles.headline(context).copyWith(
                              fontSize: 36, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Price
                        Text(
                          controller.price,
                          style: AppTextStyles.title(context)
                              .copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        // Availability
                        Text.rich(TextSpan(
                            text: 'Availability : ',
                            style: AppTextStyles.title(context)
                                .copyWith(color: AppColors.textSecondary),
                            children: [
                              TextSpan(
                                  text: controller.availability,
                                  style: TextStyle(color: AppColors.primary))
                            ])),
                        const SizedBox(height: AppSpacing.lg),

                        // Summary
                        Text(
                          controller.summary,
                          style: AppTextStyles.body(context)
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Book Details
                        _buildBookDetail(
                            'Pages', controller.totalPages, context),
                        _buildBookDetail(
                            'Publisher', controller.publisher, context),
                        _buildBookDetail('ISBN', controller.isbn, context),
                        _buildBookDetail(
                            'Published', controller.publishedDate, context),

                        const SizedBox(height: AppSpacing.xl),

                        // Action Buttons
                        Row(
                          children: [
                            InkWell(
                              splashColor: AppColors.primary,
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.lg,
                                    vertical: AppSpacing.md),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryDark,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text('Buy Now',
                                      style: AppTextStyles.title(context)
                                          .copyWith(
                                              color: AppColors.background,
                                              fontSize: 16)),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            CircleIconButton(
                                icon: Icons.favorite_border, onPressed: () {}),
                            const SizedBox(width: AppSpacing.md),
                            CircleIconButton(
                                icon: Icons.shopping_cart_outlined,
                                onPressed: () {}),
                            const SizedBox(width: AppSpacing.md),
                            CircleIconButton(
                                icon: Icons.remove_red_eye_sharp,
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl * 3),

              // Reading List Section
              Text(
                'Your Reading List',
                style: AppTextStyles.headline(context).copyWith(fontSize: 28),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.xl),

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
                  height: 380,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(
                      width: AppSpacing.lg,
                    ),
                    itemCount: controller.readingList.length,
                    itemBuilder: (context, index) {
                      final book = controller.readingList[index];
                      return BookCardAPI(book: book);
                    },
                  ),
                );
              }),

              const SizedBox(height: AppSpacing.xl * 2),

              // Books For You Section
              Text(
                'Books For You',
                style: AppTextStyles.headline(context).copyWith(fontSize: 28),
              ),
              const SizedBox(height: AppSpacing.sm),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.xl),

              Obx(() {
                if (controller.isLoadingBooksForYou.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.booksForYou.isEmpty) {
                  return const Text('No recommendations available');
                }

                return SizedBox(
                  height: 380,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(
                      width: AppSpacing.lg,
                    ),
                    itemCount: controller.booksForYou.length,
                    itemBuilder: (context, index) {
                      final book = controller.booksForYou[index];
                      return BookCardAPI(book: book);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookDetail(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text.rich(
        TextSpan(
          text: '$label: ',
          style: AppTextStyles.body(context).copyWith(
              color: AppColors.textSecondary, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value,
              style: AppTextStyles.body(context),
            )
          ],
        ),
      ),
    );
  }
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
    final style = AppTextStyles.caption(context)
        .copyWith(color: AppColors.textSecondary, fontSize: 18);

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
