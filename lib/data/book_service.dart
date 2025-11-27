import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book_models.dart';

class BookService {
  static const String baseUrl =
      'https://bukuacak-9bdcb4ef2605.herokuapp.com/api/v1';

  Future<BookResponse> getBooks(
      {String? sort,
      int? page,
      int? year,
      String? genre,
      String? keyword}) async {
    try {
      Map<String, String> queryParams = {};
      if (sort != null) queryParams['sort'] = sort;
      if (page != null) queryParams['page'] = page.toString();
      if (year != null) queryParams['year'] = year.toString();
      if (genre != null) queryParams['genre'] = genre;
      if (keyword != null) queryParams['keyword'] = keyword;

      final uri = Uri.parse('$baseUrl/book')
          .replace(queryParameters: queryParams.isEmpty ? null : queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return BookResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load books. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getBooks: $e');
      rethrow;
    }
  }
}
