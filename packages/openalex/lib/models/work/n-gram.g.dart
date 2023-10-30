// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'n-gram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NGram _$NGramFromJson(Map<String, dynamic> json) => NGram(
      ngram: json['ngram'] as String?,
      ngramTokens: json['ngram_tokens'] as int?,
      ngramCount: json['ngram_count'] as int?,
      termFrequency: (json['term_frequency'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NGramToJson(NGram instance) => <String, dynamic>{
      'ngram': instance.ngram,
      'ngram_tokens': instance.ngramTokens,
      'ngram_count': instance.ngramCount,
      'term_frequency': instance.termFrequency,
    };
