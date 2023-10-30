import 'package:json_annotation/json_annotation.dart';

part 'n-gram.g.dart';

@JsonSerializable(explicitToJson: true)
class NGram {
  @JsonKey(name: 'ngram')
  String? ngram;

  @JsonKey(name: 'ngram_tokens')
  int? ngramTokens;

  @JsonKey(name: 'ngram_count')
  int? ngramCount;

  @JsonKey(name: 'term_frequency')
  double? termFrequency;

  NGram({
    this.ngram,
    this.ngramTokens,
    this.ngramCount,
    this.termFrequency,
  });

  factory NGram.fromJson(Map<String, dynamic> json) => _$NGramFromJson(json);

  Map<String, dynamic> toJson() => _$NGramToJson(this);
}

/*
ngram: "energy formula into a functional",
      ngram_tokens: 5,
      ngram_count: 1,
      term_frequency: 0.0005452562704471102
 */
