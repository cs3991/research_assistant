library openalex;

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openalex/models/author/meta_authors.dart';
import 'package:openalex/models/models.dart';

class OpenAlex {
  static final OpenAlex _openAlex = OpenAlex._internal();

  factory OpenAlex() => _openAlex;

  OpenAlex._internal();

  String? email;

  // set email
  void setEmail(String email) {
    this.email = email;
  }

  final String _url = 'https://api.openalex.org';

  /// https://docs.openalex.org/api-entities/works/get-a-single-work
  Future<Work?> getWork(String id,
      {List<String>? select, EntitySort? sort, bool ascending = true}) async {
    String queryString = '';

    if (select != null || sort != null) {
      queryString += '?';
      if (sort != null) queryString += 'sort=${sort.name}';
      if (select != null) {
        queryString += 'select=${select.join(',')}';

        if (!ascending) queryString += ':desc';
      }
    }

    http.Response response =
        await http.get(Uri.parse('$_url/works/$id$queryString'));

    if (response.statusCode == 200) {
      return Work.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  /// The best way to search for works is to use the search query parameter, which searches across titles, abstracts, and fulltext. Example:
  /// Get works with search term "dna" in the title, abstract, or fulltext:
  /// https://api.openalex.org/works?search=dna
  /// Fulltext search is powered by an index of word sequences called n-grams - see Get N-grams for more details.
  /// You can page through works and change the default number of results returned with the page and per-page parameters
  /// https://docs.openalex.org/api-entities/works/get-lists-of-works#page-and-sort-works
  Future<MetaWorks?> getWorks({
    String? query,
    int? page,
    int? perPage,
    List<String>? select,
    Map<WorkFilter, String>? queryFilter,
  }) async {
    debugPrint('Getting works');
    String queryString = '';
    if (page != null ||
        perPage != null ||
        select != null ||
        queryFilter != null ||
        query != null) {
      queryString += '?';
      if (queryFilter != null) {
        queryFilter.forEach((key, value) {
          queryString += 'filter=${key.name}:$value&';
        });
      } else if (query != null) {
        queryString += 'search=$query&';
      }

      if (query != null) queryString += 'q=$query&';
      if (page != null) queryString += 'page=$page&';
      if (perPage != null) queryString += 'per-page=$perPage&';
      if (select != null) queryString += 'select=${select.join(',')}&';

      debugPrint('URL: $_url/works$queryString'.toString());
    }
    http.Response response =
        await http.get(Uri.parse('$_url/works$queryString'));
    if (response.statusCode == 200) {
      try {
        return MetaWorks.fromJson(jsonDecode(response.body));
      } catch (e) {
        debugPrint('Error: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  Future<MetaWorks?> getWorksById({
    required List<String> ids,
    int? perPage = 5,
  }) async {
    debugPrint('Getting works');
    String queryString = '?filter=ids.openalex:';

    for (var element in ids) {
      queryString += '$element|';
    }

    // remove trailing |
    queryString = queryString.substring(0, queryString.length - 1);

    // add per page
    queryString += '&per-page=$perPage';

    http.Response response =
        await http.get(Uri.parse('$_url/works$queryString'));

    debugPrint('response: ${response.body}');
    if (response.statusCode == 200) {
      try {
        return MetaWorks.fromJson(jsonDecode(response.body));
      } catch (e) {
        debugPrint('Error: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  /// N-grams list the words and phrases that occur in the full text of a Work. We obtain them from Internet Archive's publicly (and generously )
  /// available General Index and use them to enable fulltext searches on the Works that have them, through both the fulltext.search filter, and as an element of the more holistic search parameter.
  /// Note that while n-grams are derived from the fulltext of a Work, the presence of n-grams for a given Work doesn't imply that the fulltext is available to you, the reader.
  /// It only means the fulltext was available to Internet Archive for indexing. Work.open_access is the place to go for information on public fulltext availability.
  Future<List<NGram>> getWorkNGrams(String id) async {
    http.Response response =
        await http.get(Uri.parse('$_url/works/$id/ngrams'));

    if (response.statusCode == 200) {
      List<dynamic> ngrams = jsonDecode(response.body);
      return ngrams.map((e) => NGram.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  /// You can use sample to get a random batch of works.
  Future<List<Work>> getRandomWorks({int? count = 20}) async {
    http.Response response =
        await http.get(Uri.parse('$_url/works?sample=$count'));

    if (response.statusCode == 200) {
      List<dynamic> works = jsonDecode(response.body);
      return works.map((e) => Work.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Work>> searchWorks(
    String query, {
    WorkFilter? filter,
  }) async {
    http.Response response = await http.get(Uri.parse(
        '$_url/works?${filter != null ? 'filter=${filter.name}.' : ''}search=$query'));

    if (response.statusCode == 200) {
      List<dynamic> works = jsonDecode(response.body);
      return works.map((e) => Work.fromJson(e)).toList();
    } else {
      throw Exception("${response.statusCode} : ${response.body}");
    }
  }

  /// You can autocomplete works to create a very fast type-ahead style search function:
  /// Autocomplete works with "tigers" in the title:
  ///  https://api.openalex.org/autocomplete/works?q=tigers
  /// This returns a list of works titles with the author of each work set as the hint:
  Future<List<AutocompleteWork>> autocompleteWorks(String query) async {
    http.Response response =
        await http.get(Uri.parse('$_url/autocomplete/works?q=$query'));

    if (response.statusCode == 200) {
      List<dynamic> works = jsonDecode(response.body);
      return works.map((e) => AutocompleteWork.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<Author?> getAuthor(String id, {List<String>? select}) async {
    String queryString = '';

    if (select != null) {
      queryString += '?';
      queryString += 'select=${select.join(',')}';
    }

    http.Response response =
        await http.get(Uri.parse('$_url/authors/$id$queryString'));

    if (response.statusCode == 200) {
      return Author.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<MetaAuthors?> getAuthors({
    String? query,
    int? page,
    int? perPage,
    List<String>? select,
    Map<AuthorFilter, String>? queryFilter,
  }) async {
    String queryString = '';
    if (page != null ||
        perPage != null ||
        select != null ||
        queryFilter != null ||
        query != null) {
      queryString += '?';
      if (queryFilter != null) {
        queryFilter.forEach((key, value) {
          queryString += 'filter=${key.name}:$value&';
        });
      } else if (query != null) {
        queryString += 'search=$query&';
      }

      if (query != null) queryString += 'q=$query&';
      if (page != null) queryString += 'page=$page&';
      if (perPage != null) queryString += 'per-page=$perPage&';
      if (select != null) queryString += 'select=${select.join(',')}&';
    }
    http.Response response =
        await http.get(Uri.parse('$_url/authors$queryString'));
    if (response.statusCode == 200) {
      try {
        return MetaAuthors.fromJson(jsonDecode(response.body));
      } catch (e) {
        debugPrint('Error: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Concept?> getConcept(String id, {List<String>? select}) async {
    String queryString = '';

    if (select != null) {
      queryString += '?';
      queryString += 'select=${select.join(',')}';
    }

    http.Response response =
        await http.get(Uri.parse('$_url/concepts/$id$queryString'));

    if (response.statusCode == 200) {
      return Concept.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<MetaConcepts> getConcepts(
      {String? query,
      List<String>? select,
      int? page,
      int? perPage,
      EntitySort? sort,
      ConceptFilter? queryFilter}) async {
    debugPrint('Getting concepts');
    String queryString = '';
    if (page != null ||
        perPage != null ||
        select != null ||
        queryFilter != null ||
        query != null) {
      queryString += '?';
      if (queryFilter != null && query != null) {
        queryString += 'filter=${queryFilter.name}.search:$query&';
      } else if (query != null) {
        queryString += 'search=$query&';
      }

      if (query != null) queryString += 'q=$query&';
      if (page != null) queryString += 'page=$page&';
      if (perPage != null) queryString += 'per-page=$perPage&';
      if (select != null) queryString += 'select=${select.join(',')}&';
    }
    http.Response response =
        await http.get(Uri.parse('$_url/concepts$queryString'));

    if (response.statusCode == 200) {
      return MetaConcepts.fromJson(jsonDecode(response.body));
    } else {
      return MetaConcepts();
    }
  }

  Future<Institution?> getInstitution(String id, {List<String>? select}) async {
    String queryString = '';

    if (select != null) {
      queryString += '?';
      queryString += 'select=${select.join(',')}';
    }
    http.Response response =
        await http.get(Uri.parse('$_url/institutions/$id$queryString'));

    if (response.statusCode == 200) {
      return Institution.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  /// get lists of institutions
  Future<MetaInstitutions?> getInstitutions(
      {String? query,
      List<String>? select,
      int? page,
      int? perPage,
      EntitySort? sort,
      InstitutionFilter? queryFilter}) async {
    String queryString = '';
    if (page != null ||
        perPage != null ||
        select != null ||
        queryFilter != null ||
        query != null) {
      queryString += '?';
      if (queryFilter != null && query != null) {
        queryString += 'filter=${queryFilter.name}.search:$query&';
      } else if (query != null) {
        queryString += 'search=$query&';
      }

      if (query != null) queryString += 'q=$query&';
      if (page != null) queryString += 'page=$page&';
      if (perPage != null) queryString += 'per-page=$perPage&';
      if (select != null) queryString += 'select=${select.join(',')}&';
    }
    http.Response response =
        await http.get(Uri.parse('$_url/institutions$queryString'));

    log('Response: ${response.body}');

    if (response.statusCode == 200) {
      try {
        return MetaInstitutions.fromJson(jsonDecode(response.body));
      } catch (e) {
        debugPrint('Error: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Source?> getSource(String id) async {
    http.Response response = await http.get(Uri.parse('$_url/sources/$id'));

    if (response.statusCode == 200) {
      return Source.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<MetaSources?> getSources() async {
    http.Response response = await http.get(Uri.parse('$_url/sources'));

    if (response.statusCode == 200) {
      return MetaSources.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}

enum WorkFilter {
  abstract('abstract'),
  displayName('display_name'),
  fulltext('fulltext'),
  title('title'),
  concepts('concepts.id'),
  defaultFilter('default');

  const WorkFilter(this.name);

  final String name;
}

enum AuthorFilter {
  worksCount('works_count'),
  concepts('concepts.id'),
  defaultFilter('default');

  const AuthorFilter(this.name);

  final String name;
}

enum ConceptFilter {
  ancestorsId('ancestors.id'),
  citedByCount('cited_by_count'),
  idsOpenalex('ids.openalex'),
  level('level'),
  summaryStats2yrMeanCitedness('summary_stats.2yr_mean_citedness'),
  summaryStatsHIndex('summary_stats.h_index'),
  summaryStatsI10Index('summary_stats.i10_index'),
  worksCount('works_count'),
  defaultFilter('default.search'),
  displayName('display_name.search'),
  hasWixidata('has_wikidata');

  const ConceptFilter(this.name);

  final String name;
}

enum InstitutionFilter {
  citedByCount('cited_by_count'),
  countryCode('country_code'),
  openalex('openalex'),
  repositoriesHostOrganization('repositories.host_organization'),
  repositoriesHostOrganizationLineage('repositories.host_organization_lineage'),
  repositoriesId('repositories.id'),
  ror('ror'),
  summaryStats2yrMeanCitedness('summary_stats.2yr_mean_citedness'),
  summaryStatsHIndex('summary_stats.h_index'),
  summaryStatsI10Index('summary_stats.i10_index'),
  type('type'),
  worksCount('works_count'),
  xConceptsId('x_concepts.id'),
  defaultFilter('default.search'),
  displayName('display_name.search'),
  hasRor('has_ror'),
  continent('continent'),
  isGlobalSouth('is_global_south');

  const InstitutionFilter(this.name);

  final String name;
}

enum EntitySort {
  displayName('display_name'),
  citedByCount('cited_by_count'),
  worksCount('works_count'),
  publicationDate('publication_date'),
  relevanceScore('relevance_score');

  const EntitySort(this.name);

  final String name;
}
