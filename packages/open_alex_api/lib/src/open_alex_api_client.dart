import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_alex_api/open_alex_api.dart';

class WorkRequestFailure implements Exception {}

class WorkNotFoundFailure implements Exception {}

class AuthorRequestFailure implements Exception {}

class AuthorNotFoundFailure implements Exception {}

class VenueRequestFailure implements Exception {}

class VenueNotFoundFailure implements Exception {}

class InstitutionRequestFailure implements Exception {}

class InstitutionNotFoundFailure implements Exception {}

class ConceptRequestFailure implements Exception {}

class ConceptNotFoundFailure implements Exception {}

class TopicRequestFailure implements Exception {}

class TopicNotFoundFailure implements Exception {}

class OpenAlexApiClient {
  OpenAlexApiClient({
    http.Client? httpClient,
    this.mail,
    this.apiKey = const String.fromEnvironment('OPENALEX_API_KEY'),
    this.maxRetries = 2,
    this.retryDelay = const Duration(seconds: 1),
    this.requestTimeout = const Duration(seconds: 30),
  }) : _httpClient = httpClient ?? http.Client() {
    if (maxRetries < 0) throw ArgumentError.value(maxRetries, 'maxRetries');
  }

  /// Optional contact information; API keys now determine the usage budget.
  final String? mail;
  final String? apiKey;
  final int maxRetries;
  final Duration retryDelay;
  final Duration requestTimeout;
  final http.Client _httpClient;

  static const String _baseUrl = 'api.openalex.org';

  // API responses contain full OpenAlex URLs; endpoints also accept short IDs.
  static String _entityId(String id) {
    final uri = Uri.tryParse(id);
    if (uri != null && uri.host == 'openalex.org') {
      return uri.pathSegments.last;
    }
    return id;
  }

  Future<http.Response> _get(Uri url) async {
    final headers = <String, String>{
      if (mail != null) 'User-Agent': mail!,
      if (apiKey != null && apiKey!.isNotEmpty)
        'Authorization': 'Bearer $apiKey',
    };
    for (var attempt = 0; ; attempt++) {
      final response = await _httpClient
          .get(url, headers: headers)
          .timeout(requestTimeout);
      final retryable =
          response.statusCode == 429 ||
          response.statusCode >= 500 && response.statusCode <= 599;
      if (!retryable || attempt >= maxRetries) return response;
      final retryAfter = int.tryParse(response.headers['retry-after'] ?? '');
      // Bound waits even when the upstream server sends a long Retry-After.
      final delay = retryAfter != null && retryAfter >= 0
          ? Duration(seconds: retryAfter > 30 ? 30 : retryAfter)
          : retryDelay * (1 << attempt);
      await Future<void>.delayed(delay);
    }
  }

  void close() => _httpClient.close();

  /// Fetches a [Work] by its OpenAlex ID.
  Future<Work> getWork(String id) async {
    return Work.fromJson(await getWorkData(id));
  }

  /// Raw work data for consumers that only need a subset of the full model.
  Future<Map<String, dynamic>> getWorkData(String id) async {
    final workResponse = await _get(
      Uri.https(_baseUrl, 'works/${_entityId(id)}'),
    );
    if (workResponse.statusCode == 200) {
      return jsonDecode(workResponse.body) as Map<String, dynamic>;
    } else if (workResponse.statusCode == 404) {
      throw WorkNotFoundFailure();
    } else {
      throw WorkRequestFailure();
    }
  }

  /// Fetches a [Author] by its OpenAlex ID.
  Future<Author> getAuthor(String id) async {
    final authorResponse = await _get(
      Uri.https(_baseUrl, 'authors/${_entityId(id)}'),
    );
    if (authorResponse.statusCode == 200) {
      return Author.fromJson(jsonDecode(authorResponse.body));
    } else if (authorResponse.statusCode == 404) {
      throw AuthorNotFoundFailure();
    } else {
      throw AuthorRequestFailure();
    }
  }

  /// Fetches a [Source] by its OpenAlex ID.
  @Deprecated('Use getSource instead. Venues have been replaced by sources.')
  Future<Source> getVenue(String id) => getSource(id);

  Future<Source> getSource(String id) async {
    final venueResponse = await _get(
      Uri.https(_baseUrl, 'sources/${_entityId(id)}'),
    );
    if (venueResponse.statusCode == 200) {
      return Source.fromJson(jsonDecode(venueResponse.body));
    } else if (venueResponse.statusCode == 404) {
      throw VenueNotFoundFailure();
    } else {
      throw VenueRequestFailure();
    }
  }

  /// Fetches a [Institution] by its OpenAlex ID.
  Future<Institution> getInstitution(String id) async {
    final institutionResponse = await _get(
      Uri.https(_baseUrl, 'institutions/${_entityId(id)}'),
    );
    if (institutionResponse.statusCode == 200) {
      return Institution.fromJson(jsonDecode(institutionResponse.body));
    } else if (institutionResponse.statusCode == 404) {
      throw InstitutionNotFoundFailure();
    } else {
      throw InstitutionRequestFailure();
    }
  }

  Future<Topic> getTopic(String id) async {
    final response = await _get(Uri.https(_baseUrl, 'topics/${_entityId(id)}'));
    if (response.statusCode == 200) {
      return Topic.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw TopicNotFoundFailure();
    }
    throw TopicRequestFailure();
  }

  /// Fetches a [Concept] by its OpenAlex ID.
  Future<Concept> getConcept(String id) async {
    final conceptResponse = await _get(
      Uri.https(_baseUrl, 'concepts/${_entityId(id)}'),
    );
    if (conceptResponse.statusCode == 200) {
      return Concept.fromJson(jsonDecode(conceptResponse.body));
    } else if (conceptResponse.statusCode == 404) {
      throw ConceptNotFoundFailure();
    } else {
      throw ConceptRequestFailure();
    }
  }

  /// Searches for [Work]s by a query.
  Future<List<Work>> searchWorks(
    String query, {
    required int page,
    required int itemsPerPage,
  }) async {
    final results = await searchWorksData(
      query,
      page: page,
      itemsPerPage: itemsPerPage,
    );
    return results.map(Work.fromJson).toList();
  }

  /// Raw results let consumers avoid decoding unrelated nested metadata.
  Future<List<Map<String, dynamic>>> searchWorksData(
    String query, {
    required int page,
    required int itemsPerPage,
  }) async {
    if (page < 1 || page * itemsPerPage > 10000) {
      throw ArgumentError.value(
        page,
        'page',
        'Must stay within the first 10000 results',
      );
    }
    if (itemsPerPage < 1 || itemsPerPage > 100) {
      throw ArgumentError.value(
        itemsPerPage,
        'itemsPerPage',
        'Must be between 1 and 100',
      );
    }
    final searchResponse = await _get(
      Uri.https(_baseUrl, 'works', {
        'search': query,
        'page': page.toString(),
        'per_page': itemsPerPage.toString(),
      }),
    );
    if (searchResponse.statusCode == 200) {
      final searchResults = jsonDecode(searchResponse.body);
      return (searchResults['results'] as List)
          .map((result) => result as Map<String, dynamic>)
          .toList();
    } else {
      throw WorkRequestFailure();
    }
  }
}
