import 'package:open_alex_api/open_alex_api.dart'
    show OpenAlexApiClient, defaultListPageSize;
import 'package:research_assistant/catalog_repository/src/model/model.dart';

class CatalogRepository {
  CatalogRepository({OpenAlexApiClient? openAlex})
    : _openAlex = openAlex ?? OpenAlexApiClient();

  final OpenAlexApiClient _openAlex;

  // Decode only the metadata used by search and publication details. In
  // particular, unresolved author/source IDs and institution metadata must not
  // prevent a publication from being displayed.
  Work workFromJson(Map<String, dynamic> json, {bool summary = false}) {
    final primary = json['primary_location'] as Map?;
    final source = primary?['source'] as Map?;
    final bestOa = json['best_oa_location'] as Map?;
    final access = json['open_access'] as Map?;
    final ids = json['ids'] as Map?;
    final topics = _names(json['topics']);
    final date = json['publication_date'] as String?;
    return Work(
      isSummary: summary,
      id: _text(json['id']),
      referencedWorkIds: (json['referenced_works'] as List? ?? const [])
          .whereType<String>()
          .map((id) => id.trim())
          .where((id) => id.isNotEmpty)
          .toList(),
      title:
          _text(json['title']) ?? _text(json['display_name']) ?? 'Sans titre',
      authors: _objects(json['authorships']).map((authorship) {
        final author = authorship['author'] as Map?;
        return _text(author?['display_name']) ??
            _text(authorship['raw_author_name']) ??
            'Auteur inconnu';
      }).toList(),
      abstract: _abstract(json['abstract_inverted_index'] as Map?),
      primaryLocation: _text(source?['display_name']) ?? '',
      citedByCount: (json['cited_by_count'] as num?)?.toInt(),
      publicationYear: (json['publication_year'] as num?)?.toInt(),
      publicationDate: date == null ? null : DateTime.tryParse(date),
      isOpenAccess: access?['is_oa'] as bool?,
      doiUrl: _doiUrl(_text(ids?['doi']) ?? _text(json['doi'])),
      conceptsNames: topics.isNotEmpty ? topics : _names(json['concepts']),
      bestOaUrl:
          _url(bestOa?['pdf_url']) ??
          _url(bestOa?['landing_page_url']) ??
          _url(access?['oa_url']),
      citationsCountByYear: _objects(json['counts_by_year'])
          .map((entry) => (entry['cited_by_count'] as num?)?.toInt())
          .whereType<int>()
          .toList(),
    );
  }

  static Iterable<Map> _objects(Object? value) =>
      (value as List? ?? const []).where((entry) => entry != null).cast<Map>();

  static String? _text(Object? value) {
    final text = (value as String?)?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  static List<String> _names(Object? value) => _objects(
    value,
  ).map((entry) => _text(entry['display_name'])).whereType<String>().toList();

  static Uri? _url(Object? value) {
    final text = _text(value);
    if (text == null) return null;
    final uri = Uri.tryParse(text);
    return uri != null &&
            (uri.scheme == 'https' || uri.scheme == 'http') &&
            uri.host.isNotEmpty
        ? uri
        : null;
  }

  static Uri? _doiUrl(String? value) => value == null
      ? null
      : _url(value.startsWith('http') ? value : 'https://doi.org/$value');

  static String _abstract(Map? index) {
    if (index == null) return '';
    final words = <int, String>{};
    for (final entry in index.entries) {
      for (final position in entry.value as List? ?? const []) {
        if (position == null) continue;
        final offset = (position as num).toInt();
        if (offset >= 0) words[offset] = entry.key as String;
      }
    }
    if (words.isEmpty) return '';
    final positions = words.keys.toList()..sort();
    // Preserve order without allocating up to an untrusted maximum position.
    return positions.map((position) => words[position]!).join(' ');
  }

  Future<List<Work>> searchWork(
    String query, {
    int page = 1,
    int itemsPerPage = defaultListPageSize,
  }) async {
    final works = await _openAlex.searchWorksData(
      query,
      page: page,
      itemsPerPage: itemsPerPage,
    );
    return works.map(workFromJson).toList();
  }

  Future<CitationNeighborhood> getCitationNeighborhood(
    Work work, {
    int page = 1,
    int pageSize = defaultListPageSize,
  }) async {
    final id = work.id;
    if (id == null || id.isEmpty) {
      throw ArgumentError('Article sans identifiant OpenAlex');
    }
    if (page < 1 || pageSize < 1 || pageSize > 100) {
      throw ArgumentError('Pagination invalide');
    }
    final start = (page - 1) * pageSize;
    final references = work.referencedWorkIds
        .skip(start)
        .take(pageSize)
        .toList();
    final responses = await Future.wait([
      if (page * pageSize <= 10000)
        _openAlex.getFilteredWorksData(
          'cites:${id.split('/').last}',
          page: page,
          itemsPerPage: pageSize,
        )
      else
        Future.value(<String, dynamic>{
          'results': <dynamic>[],
          'meta': {'count': 0},
        }),
      if (references.isNotEmpty)
        _openAlex.getFilteredWorksData(
          'openalex:${references.map((id) => id.split('/').last).join('|')}',
          itemsPerPage: pageSize,
        ),
    ]);
    final incoming = responses.first;
    final works = <Work>[
      // The cites filter already proves this edge. Do not download each
      // citing article's entire bibliography just to rediscover it.
      ..._objects(incoming['results']).map(
        (json) => workFromJson({
          ...Map<String, dynamic>.from(json),
          'referenced_works': [id],
        }, summary: true),
      ),
      if (responses.length > 1)
        ..._objects(responses[1]['results']).map(
          (json) =>
              workFromJson(Map<String, dynamic>.from(json), summary: true),
        ),
    ];
    final total = (incoming['meta'] as Map?)?['count'] as int? ?? 0;
    return CitationNeighborhood(
      works: works,
      hasMore:
          page * pageSize < work.referencedWorkIds.length ||
          page * pageSize < total && (page + 1) * pageSize <= 10000,
    );
  }

  Future<Work> getWork(String id) async =>
      workFromJson(await _openAlex.getWorkData(id));
}

class CitationNeighborhood {
  const CitationNeighborhood({required this.works, required this.hasMore});
  final List<Work> works;
  final bool hasMore;
}
