import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_alex_api/open_alex_api.dart';

class WorkRequestFailure implements Exception {}

class WorkNotFoundFailure implements Exception {}

class AuthorRequestFailure {}

class AuthorNotFoundFailure {}

class OpenAlexApiClient {
  OpenAlexApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  // TODO: change id to url parameter only
  //  static const String _baseUrl = 'api.openalex.org/';

  /// Fetches a [Work] by its OpenAlex ID.
  Future<Work> getWork(String id) async {
    final workResponse = await _httpClient.get(Uri.parse(id));
    if (workResponse.statusCode == 200) {
      return Work.fromJson(jsonDecode(workResponse.body));
    } else if (workResponse.statusCode == 404) {
      throw WorkNotFoundFailure();
    } else {
      throw WorkRequestFailure();
    }
  }

  /// Fetches a [Author] by its OpenAlex ID.
  Future<Author> getAuthor(String id) async {
    final authorResponse = await _httpClient.get(Uri.parse(id));
    if (authorResponse.statusCode == 200) {
      return Author.fromJson(jsonDecode(authorResponse.body));
    } else if (authorResponse.statusCode == 404) {
      throw AuthorNotFoundFailure();
    } else {
      throw AuthorRequestFailure();
    }
  }
}
