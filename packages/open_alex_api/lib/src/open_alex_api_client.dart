import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:open_alex_api/open_alex_api.dart';

class WorkRequestFailure implements Exception {}

class WorkNotFoundFailure implements Exception {}

class AuthorRequestFailure {}

class AuthorNotFoundFailure {}

class VenueRequestFailure implements Exception {}

class VenueNotFoundFailure implements Exception {}

class InstitutionRequestFailure implements Exception {}

class InstitutionNotFoundFailure implements Exception {}

class ConceptRequestFailure implements Exception {}

class ConceptNotFoundFailure implements Exception {}

class OpenAlexApiClient {
  OpenAlexApiClient({http.Client? httpClient, this.mail})
      : _httpClient = httpClient ?? http.Client();

  final String? mail;
  final http.Client _httpClient;

  // TODO: change id to url parameter only
  static const String _baseUrl = 'api.openalex.org';

  Future<http.Response> _get(Uri url, {Map<String, String>? headers}) async {
    headers ??= {};
    if (mail != null) {
      headers['User-Agent'] = mail!;
    } else {
      log('OpenAlex has 2 pools for clients. '
          'Please be nice and supply your email as the first argument '
          'when calling this class to get into the polite pool. This way '
          'OpenAlex can contact you if needed.');
    }
    final response = await _httpClient.get(url, headers: headers);
    return response;
  }

  /// Fetches a [Work] by its OpenAlex ID.
  Future<Work> getWork(String id) async {
    final workResponse = await _get(Uri.https(_baseUrl, 'works/$id'));
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
    final authorResponse = await _get(Uri.https(_baseUrl, 'authors/$id'));
    if (authorResponse.statusCode == 200) {
      return Author.fromJson(jsonDecode(authorResponse.body));
    } else if (authorResponse.statusCode == 404) {
      throw AuthorNotFoundFailure();
    } else {
      throw AuthorRequestFailure();
    }
  }

  /// Fetches a [Source] by its OpenAlex ID.
  Future<Source> getVenue(String id) async {
    final venueResponse = await _get(Uri.https(_baseUrl, 'venues/$id'));
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
    final institutionResponse =
        await _get(Uri.https(_baseUrl, 'institutions/$id'));
    if (institutionResponse.statusCode == 200) {
      return Institution.fromJson(jsonDecode(institutionResponse.body));
    } else if (institutionResponse.statusCode == 404) {
      throw InstitutionNotFoundFailure();
    } else {
      throw InstitutionRequestFailure();
    }
  }

  /// Fetches a [Concept] by its OpenAlex ID.
  Future<Concept> getConcept(String id) async {
    final conceptResponse = await _get(Uri.https(_baseUrl, 'concepts/$id'));
    if (conceptResponse.statusCode == 200) {
      return Concept.fromJson(jsonDecode(conceptResponse.body));
    } else if (conceptResponse.statusCode == 404) {
      throw ConceptNotFoundFailure();
    } else {
      throw ConceptRequestFailure();
    }
  }

  /// Searches for [Work]s by a query.
  Future<List<Work>> searchWorks(String query, {required int page, required int itemsPerPage}) async {
    final searchResponse = await _get(Uri.https(
        _baseUrl, 'works', {'search': query, 'page': page.toString(), 'per-page': itemsPerPage.toString()}));
    if (searchResponse.statusCode == 200) {
      final searchResults = jsonDecode(searchResponse.body);
      final List<Work> works = [];
      for (final result in searchResults['results']) {
        works.add(Work.fromJson(result));
      }
      return works;
    } else {
      throw WorkRequestFailure();
    }
  }
}
