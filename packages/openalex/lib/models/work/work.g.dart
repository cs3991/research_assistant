// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Work _$WorkFromJson(Map<String, dynamic> json) => Work(
      abstractInvertedIndex:
          (json['abstract_inverted_index'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
      ),
      authorships: (json['authorships'] as List<dynamic>?)
          ?.map((e) => Authorship.fromJson(e as Map<String, dynamic>))
          .toList(),
      apcList: json['apc_list'] == null
          ? null
          : ApcList.fromJson(json['apc_list'] as Map<String, dynamic>),
      apcPaid: json['apc_paid'] == null
          ? null
          : ApcPaid.fromJson(json['apc_paid'] as Map<String, dynamic>),
      bestOALocation: json['best_oa_location'] == null
          ? null
          : Location.fromJson(json['best_oa_location'] as Map<String, dynamic>),
      biblio: json['biblio'] == null
          ? null
          : Biblio.fromJson(json['biblio'] as Map<String, dynamic>),
      citedByApiUrl: json['cited_by_api_url'] as String?,
      citedByCount: json['cited_by_count'] as int?,
      concepts: (json['concepts'] as List<dynamic>?)
          ?.map((e) => Concept.fromJson(e as Map<String, dynamic>))
          .toList(),
      correspondingAuthorIds:
          (json['corresponding_author_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      correspondingInstitutionIds:
          (json['corresponding_institution_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      countriesDistinctCount: json['countries_distinct_count'] as int?,
      countsByYear: (json['counts_by_year'] as List<dynamic>?)
          ?.map((e) => CountByYear.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      displayName: json['display_name'] as String?,
      doi: json['doi'] as String?,
      grants: (json['grants'] as List<dynamic>?)
          ?.map((e) => Grant.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      ids: json['ids'] == null
          ? null
          : AlexIds.fromJson(json['ids'] as Map<String, dynamic>),
      institutionsDistinctCount: json['institutions_distinct_count'] as int?,
      isOA: json['is_oa'] as bool?,
      isParatext: json['is_paratext'] as bool?,
      isRetracted: json['is_retracted'] as bool?,
      language: json['language'] as String?,
      license: json['license'] as String?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      locationsCount: json['locations_count'] as int?,
      mesh: (json['mesh'] as List<dynamic>?)
          ?.map((e) => MeSH.fromJson(e as Map<String, dynamic>))
          .toList(),
      ngramsUrl: json['ngrams_url'] as String?,
      openAccess: json['open_access'] == null
          ? null
          : OpenAccess.fromJson(json['open_access'] as Map<String, dynamic>),
      primaryLocation: json['primary_location'] == null
          ? null
          : Location.fromJson(json['primary_location'] as Map<String, dynamic>),
      publicationDate: json['publication_date'] == null
          ? null
          : DateTime.parse(json['publication_date'] as String),
      publicationYear: json['publication_year'] as int?,
      referencedWorks: (json['referenced_works'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relatedWorks: (json['related_works'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sustainableDevelopmentGoals:
          (json['sustainable_development_goals'] as List<dynamic>?)
              ?.map((e) => SustainableGoal.fromJson(e as Map<String, dynamic>))
              .toList(),
      title: json['title'] as String?,
      type: json['type'] as String?,
      typeCrossref: json['type_crossref'] as String?,
      updatedDate: json['updated_date'] == null
          ? null
          : DateTime.parse(json['updated_date'] as String),
      ngram: json['ngram'] as String?,
      ngramCount: json['ngram_count'] as int?,
      ngramTokens: json['ngram_tokens'] as int?,
      termFrequency: (json['term_frequency'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      'abstract_inverted_index': instance.abstractInvertedIndex,
      'authorships': instance.authorships?.map((e) => e.toJson()).toList(),
      'apc_list': instance.apcList?.toJson(),
      'apc_paid': instance.apcPaid?.toJson(),
      'best_oa_location': instance.bestOALocation?.toJson(),
      'biblio': instance.biblio?.toJson(),
      'cited_by_api_url': instance.citedByApiUrl,
      'cited_by_count': instance.citedByCount,
      'concepts': instance.concepts?.map((e) => e.toJson()).toList(),
      'corresponding_author_ids': instance.correspondingAuthorIds,
      'corresponding_institution_ids': instance.correspondingInstitutionIds,
      'countries_distinct_count': instance.countriesDistinctCount,
      'counts_by_year': instance.countsByYear?.map((e) => e.toJson()).toList(),
      'created_date': instance.createdDate?.toIso8601String(),
      'display_name': instance.displayName,
      'doi': instance.doi,
      'grants': instance.grants?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'ids': instance.ids?.toJson(),
      'institutions_distinct_count': instance.institutionsDistinctCount,
      'is_oa': instance.isOA,
      'is_paratext': instance.isParatext,
      'is_retracted': instance.isRetracted,
      'language': instance.language,
      'license': instance.license,
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
      'locations_count': instance.locationsCount,
      'mesh': instance.mesh?.map((e) => e.toJson()).toList(),
      'ngrams_url': instance.ngramsUrl,
      'open_access': instance.openAccess?.toJson(),
      'primary_location': instance.primaryLocation?.toJson(),
      'publication_date': instance.publicationDate?.toIso8601String(),
      'publication_year': instance.publicationYear,
      'referenced_works': instance.referencedWorks,
      'related_works': instance.relatedWorks,
      'sustainable_development_goals':
          instance.sustainableDevelopmentGoals?.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'type': instance.type,
      'type_crossref': instance.typeCrossref,
      'updated_date': instance.updatedDate?.toIso8601String(),
      'ngram': instance.ngram,
      'ngram_count': instance.ngramCount,
      'ngram_tokens': instance.ngramTokens,
      'term_frequency': instance.termFrequency,
    };
