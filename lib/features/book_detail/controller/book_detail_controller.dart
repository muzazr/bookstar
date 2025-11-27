import 'package:get/get.dart';
import 'dart:math';

import '../../../data/book_models.dart';
import '../../../data/book_service.dart';

class BookDetailController extends GetxController {
  final BookService _bookService = BookService();

  final Rx<Book?> currentBook = Rx<Book?>(null);
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final readingList = <Book>[].obs;
  final isLoadingReadingList = false.obs;

  final booksForYou = <Book>[].obs;
  final isLoadingBooksForYou = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Book) {
      final passedBook = Get.arguments as Book;
      currentBook.value = passedBook;
      fetchRelatedContent();
    } else {
      fetchBookDetail();
    }
  }

  Future<void> fetchBookDetail({String? bookId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Ambil buku pertama sebagai contoh detail
      final response = await _bookService.getBooks(page: 1);

      if (response.books.isNotEmpty) {
        final random = Random();
        final randomIndex = random.nextInt(response.books.length);
        currentBook.value = response.books[randomIndex];

        // Auto fetch related content
        await fetchRelatedContent();
      } else {
        throw Exception('No books available');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load book details';
      print('Error fetching book detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRelatedContent() async {
    await Future.wait([fetchReadingList(), fetchBooksForYou()]);
  }

  Future<void> fetchReadingList() async {
    if (currentBook.value == null) return;

    try {
      isLoadingReadingList.value = true;

      final genre = currentBook.value!.category.name;

      // print('Fetching reading list for genre: $genre');

      final response = await _bookService.getBooks(
        genre: genre,
        page: 1,
      );

      // Exclude current book, take 5
      readingList.assignAll(
        response.books
            .where((b) => b.id != currentBook.value!.id)
            .take(5)
            .toList(),
      );

      // print('Reading List: ${readingList.length} books');
    } catch (e) {
      // print('Error fetching reading list: $e');
    } finally {
      isLoadingReadingList.value = false;
    }
  }

  Future<void> fetchBooksForYou() async {
    if (currentBook.value == null) return;

    try {
      isLoadingBooksForYou.value = true;

      final tagsToUse = currentBook.value!.tags.take(3).toList();

      if (tagsToUse.isEmpty) {
        // print('No tags available');
        booksForYou.clear();
      }

      List<Book> allRecommendations = [];

      for (var tag in tagsToUse) {
        try {
          final response = await _bookService.getBooks(
            keyword: tag.name,
            page: 1,
          );

          final booksFromTag = response.books
              .where((b) => b.id != currentBook.value!.id)
              .take(3)
              .toList();

          allRecommendations.addAll(booksFromTag);
        } catch (e) {
          print('Error fetching');
        }
      }

      final uniqueBooks = <String, Book>{};
      for (var book in allRecommendations) {
        uniqueBooks[book.id] = book;
      }

      booksForYou.assignAll(uniqueBooks.values.toList());
    } catch (e) {
      print('Error fetching books for you');
    } finally {
      isLoadingBooksForYou.value = false;
    }
  }

  // Helper
  List<Tag> get displayTags {
    if (currentBook.value == null) return [];
    return currentBook.value!.tags.take(3).toList();
  }

  /// Get availability (dummy karena tidak ada di API)
  String get availability => 'In Stock';

  /// Get cover image URL
  String get coverImageUrl {
    if (currentBook.value == null) return '';
    return currentBook.value!.coverImage;
  }

  /// Get formatted price
  String get price {
    if (currentBook.value == null) return '';
    return currentBook.value!.details.price;
  }

  /// Get total pages
  String get totalPages {
    if (currentBook.value == null) return '';
    return currentBook.value!.details.totalPages;
  }

  /// Get publisher
  String get publisher {
    if (currentBook.value == null) return '';
    return currentBook.value!.publisher;
  }

  /// Get ISBN
  String get isbn {
    if (currentBook.value == null) return '';
    return currentBook.value!.details.isbn;
  }

  /// Get published date
  String get publishedDate {
    if (currentBook.value == null) return '';
    return currentBook.value!.details.publishedDate;
  }

  /// Get summary
  String get summary {
    if (currentBook.value == null) return '';
    return currentBook.value!.summary;
  }

  /// Get title
  String get title {
    if (currentBook.value == null) return '';
    return currentBook.value!.title;
  }

  /// Get author name
  String get authorName {
    if (currentBook.value == null) return '';
    return currentBook.value!.author.name;
  }

  /// Get category name
  String get categoryName {
    if (currentBook.value == null) return '';
    return currentBook.value!.category.name;
  }
}
