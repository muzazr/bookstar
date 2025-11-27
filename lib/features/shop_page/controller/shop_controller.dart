import 'package:get/get.dart';
import '../../../data/book_models.dart';
import '../../../data/book_service.dart';

class ShopController extends GetxController {
  final BookService _bookService = BookService();

  // state
  final books = <Book>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;

  // Search and Filter Genre
  final searchQuery = ''.obs;
  // final selectedGenre = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  Future<void> fetchBooks({int? page}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final pageToFetch = page ?? currentPage.value;

      final response = await _bookService.getBooks(
          page: pageToFetch,
          keyword: searchQuery.value.isEmpty ? null : searchQuery.value,
          // genre: selectedGenre.value
          );

      books.assignAll(response.books);
      currentPage.value = response.pagination.currentPage;
      totalPages.value = response.pagination.totalPages;
      totalItems.value = response.pagination.totalItems;
    } catch (e) {
      errorMessage.value = 'Failed to load books';
    } finally {
      isLoading.value = false;
    }
  }

  // go to specific page
  void goToPage(int page) {
    if (page < 1 || page > totalPages.value) return;
    currentPage.value = page;
    fetchBooks(page: page);
  }

  // go to next page
  void nextPage() {
    if (currentPage.value < totalPages.value) {
      goToPage(currentPage.value + 1);
    }
  }

  // go to previous page
  void previousPage() {
    if (currentPage.value > 1) {
      goToPage(currentPage.value - 1);
    }
  }

  // search books
  void search(String query) {
    searchQuery.value = query;
    currentPage.value = 1;
    fetchBooks();
  }

  void clearSearch() {
    searchQuery.value = '';
    currentPage.value = 1;
    fetchBooks();
  }

  // filter by genre
  void filterByGenre(String? genre) {
    // selectedGenre.value = genre;
    currentPage.value = 1;
    fetchBooks();
  }
}
