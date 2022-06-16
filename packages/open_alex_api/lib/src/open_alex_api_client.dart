import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_alex_api/open_alex_api.dart';

class WorkRequestFailure implements Exception {}

class WorkNotFoundFailure implements Exception {}

class OpenAlexApiClient {
  OpenAlexApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  static const String _baseUrl = 'api.openalex.org/';

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
}
