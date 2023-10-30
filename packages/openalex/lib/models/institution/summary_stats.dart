import 'package:json_annotation/json_annotation.dart';

part 'summary_stats.g.dart';

@JsonSerializable(explicitToJson: true)
class SummaryStats {
  @JsonKey(name: '2yr_mean_citedness')
  double? twoYearMeanCitedness;

  @JsonKey(name: 'h_index')
  int? hIndex;

  @JsonKey(name: 'i10_index')
  int? i10Index;

  SummaryStats({
    this.twoYearMeanCitedness,
    this.hIndex,
    this.i10Index,
  });

  factory SummaryStats.fromJson(Map<String, dynamic> json) =>
      _$SummaryStatsFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryStatsToJson(this);
}

/*
 2yr_mean_citedness Float: The 2-year mean citedness for this institution. Also known as impact factor.
h_index Integer: The h-index for this institution.
i10_index Integer: The i-10 index for this institution.
  */
