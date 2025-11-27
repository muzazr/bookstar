class Book {
  final String id;
  final String title;
  final String coverImage;
  final Author author;
  final Categories category;
  final String summary;
  final BookDetails details;
  final List<Tag> tags;
  final List<BuyLink> buyLinks;
  final String publisher;

  Book({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.author,
    required this.category,
    required this.summary,
    required this.details,
    required this.tags,
    required this.buyLinks,
    required this.publisher,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['_id'] ?? '',
        title: json['title'] ?? '',
        coverImage: json['cover_image'] ?? '',
        author: Author.fromJson(json['author'] ?? {}),
        category: Categories.fromJson(json['category'] ?? {}),
        summary: json['summary'] ?? '',
        details: BookDetails.fromJson(json['details'] ?? {}),
        tags: (json['tags'] as List<dynamic>?)?.map((tag) => Tag.fromJson(tag)).toList() ?? [],
        buyLinks: (json['buy_links'] as List<dynamic>?)?.map((link) => BuyLink.fromJson(link)).toList() ?? [],
        publisher: json['publisher'] ?? '');
  }
}

class Author {
  final String name;
  final String url;

  Author({required this.name, required this.url});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(name: json['name'] ?? '', url: json['url'] ?? '');
  }
}

class Categories {
  final String name;
  final String url;

  Categories({required this.name, required this.url});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(name: json['name'] ?? '', url: json['url'] ?? '');
  }
}

class BookDetails {
  final String noGm;
  final String isbn;
  final String price;
  final String totalPages;
  final String size;
  final String publishedDate;
  final String format;

  BookDetails({
    required this.noGm,
    required this.isbn,
    required this.price,
    required this.totalPages,
    required this.size,
    required this.publishedDate,
    required this.format,
  });

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
        noGm: json['no_gm'] ?? '',
        isbn: json['isbn'] ?? '',
        price: json['price'] ?? '',
        totalPages: json['total_pages'] ?? '',
        size: json['size'] ?? '',
        publishedDate: json['published_date'] ?? '',
        format: json['format'] ?? '');
  }
}

class Tag {
  final String name;
  final String url;

  Tag({required this.name, required this.url});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(name: json['name'] ?? '', url: json['url'] ?? '');
  }
}

//can delete this
class BuyLink {
  final String store;
  final String url;

  BuyLink({required this.store, required this.url});

  factory BuyLink.fromJson(Map<String, dynamic> json) {
    return BuyLink(
      store: json['store'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPrevPage;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalItems: json['totalItems'] ?? 0,
      itemsPerPage: json['itemsPerPage'] ?? 20,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }
}

class BookResponse {
  final List<Book> books;
  final Pagination pagination;

  BookResponse({required this.books, required this.pagination});

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
        books: (json['books'] as List<dynamic>?)
                ?.map((book) => Book.fromJson(book))
                .toList() ??
            [],
        pagination: Pagination.fromJson(json['pagination'] ?? {}));
  }
}
