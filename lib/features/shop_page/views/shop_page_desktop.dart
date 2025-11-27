import 'package:flutter/material.dart';
import 'package:gcommerce/core/utils/image_helper.dart';
import 'package:get/get.dart';

import 'package:gcommerce/core/constants/app_colors.dart';
import 'package:gcommerce/core/constants/app_spacing.dart';
import 'package:gcommerce/core/constants/app_text_styles.dart';
import 'package:gcommerce/core/utils/string_helper.dart';

import 'package:gcommerce/features/shop_page/controller/shop_controller.dart';
import 'package:gcommerce/features/book_detail/pages/book_detail_page.dart';
import 'package:gcommerce/features/book_detail/controller/book_detail_controller.dart';
import 'package:gcommerce/data/book_models.dart';

class ShopPageDesktop extends StatelessWidget {
  ShopPageDesktop({super.key});

  final ShopController controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.accent,
        title: Text(
          'Bookstar',
          style: AppTextStyles.headline(context)
              .copyWith(fontSize: 24, color: AppColors.appBarBackground),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),

            // Book Grid (Scrollable)
            Expanded(
              child: Obx(() {
                // Loading State
                if (controller.isLoading.value && controller.books.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error State
                if (controller.errorMessage.isNotEmpty) {
                  return _buildErrorState();
                }

                // Empty State
                if (controller.books.isEmpty) {
                  return _buildEmptyState();
                }

                // Success State
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl * 4,
                    vertical: AppSpacing.xl,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1600),
                      child: Column(
                        children: [
                          // Book Grid
                          _buildBookGrid(context),

                          const SizedBox(height: AppSpacing.xl * 2),

                          // Pagination
                          _buildPagination(),

                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== SEARCH BAR ====================
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl * 4,
        vertical: AppSpacing.lg,
      ),
      color: AppColors.appBarBackground,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: TextField(
            onSubmitted: (query) => controller.search(query),
            decoration: InputDecoration(
              hintText: 'Search books...',
              hintStyle:
                  TextStyle(color: AppColors.textPrimary.withOpacity(0.5)),
              prefixIcon: const Icon(
                Icons.search,
                color: Color.fromARGB(123, 37, 43, 66),
              ),
              suffixIcon: Obx(() {
                if (controller.searchQuery.isEmpty)
                  return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearSearch,
                );
              }),
              filled: true,
              fillColor: AppColors.accent.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==================== BOOK GRID ====================
  Widget _buildBookGrid(BuildContext context) {
    return Obx(() {
      final screenWidth = MediaQuery.of(context).size.width;

      // Responsive: 4-5 columns based on screen width
      int crossAxisCount;
      double childAspectRatio;

      if (screenWidth >= 1500) {
        crossAxisCount = 5; // 5 books
        childAspectRatio = 0.68;
      } else if (screenWidth >= 1200) {
        crossAxisCount = 4; // 4 books
        childAspectRatio = 0.70;
      } else if (screenWidth >= 900) {
        crossAxisCount = 3; // 3 books
        childAspectRatio = 0.72;
      } else {
        crossAxisCount = 2; // 2 books
        childAspectRatio = 0.75;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.lg,
          mainAxisSpacing: AppSpacing.lg,
          childAspectRatio: childAspectRatio, // Slightly taller cards
        ),
        itemCount: controller.books.length,
        itemBuilder: (context, index) {
          return _BookCard(book: controller.books[index]);
        },
      );
    });
  }

  // ==================== PAGINATION ====================
  Widget _buildPagination() {
    return Obx(() {
      final currentPage = controller.currentPage.value;
      final totalPages = controller.totalPages.value;

      if (totalPages <= 1) return const SizedBox.shrink();

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous Button
          IconButton(
            onPressed: currentPage > 1 ? controller.previousPage : null,
            icon: const Icon(Icons.chevron_left),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
          ),

          // Page Numbers
          ..._buildPageNumbers(currentPage, totalPages),

          // Next Button
          IconButton(
            onPressed: currentPage < totalPages ? controller.nextPage : null,
            icon: const Icon(Icons.chevron_right),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
          ),
        ],
      );
    });
  }

  List<Widget> _buildPageNumbers(int currentPage, int totalPages) {
    List<Widget> pages = [];

    // Always show first page
    pages.add(_buildPageButton(1, currentPage == 1));

    // Show dots if needed
    if (currentPage > 3) {
      pages.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          '...',
          style: TextStyle(fontSize: 12),
        ),
      ));
    }

    // Show current page and neighbors
    for (int i = currentPage - 1; i <= currentPage + 1; i++) {
      if (i > 1 && i < totalPages) {
        pages.add(_buildPageButton(i, i == currentPage));
      }
    }

    // Show dots if needed
    if (currentPage < totalPages - 2) {
      pages.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: Text(
          '...',
          style: TextStyle(fontSize: 12),
        ),
      ));
    }

    // Always show last page
    if (totalPages > 1) {
      pages.add(_buildPageButton(totalPages, currentPage == totalPages));
    }

    return pages;
  }

  Widget _buildPageButton(int page, bool isActive) {
    return InkWell(
      onTap: () => controller.goToPage(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textPrimary,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ==================== ERROR STATE ====================
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppColors.error),
          const SizedBox(height: AppSpacing.md),
          Text(controller.errorMessage.value),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(
            onPressed: () => controller.fetchBooks(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // ==================== EMPTY STATE ====================
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.block_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No books found',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          if (controller.searchQuery.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: controller.clearSearch,
              child: const Text('Clear search'),
            ),
          ],
        ],
      ),
    );
  }
}

// ==================== BOOK CARD ====================
class _BookCard extends StatelessWidget {
  const _BookCard({required this.book});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Expanded(
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(
                  ImageHelper.getImageUrl(book.coverImage),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.border,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.border,
                    child: const Icon(Icons.block_outlined,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Info
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: AppTextStyles.title(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    StringHelper.capitalizeEachWord(book.category.name),
                    style: AppTextStyles.body(context)
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    book.details.price,
                    style: AppTextStyles.body(context)
                        .copyWith(color: AppColors.accent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
