import 'package:json_annotation/json_annotation.dart';

part 'counts_by_year.g.dart';

@JsonSerializable(explicitToJson: true)
class CountByYear {
  int? year;

  @JsonKey(name: 'works_count')
  int? worksCount;

  @JsonKey(name: 'cited_by_count')
  int? citedByCount;

  CountByYear({
    this.year,
    this.worksCount,
    this.citedByCount,
  });

  factory CountByYear.fromJson(Map<String, dynamic> json) =>
      _$CountByYearFromJson(json);

  Map<String, dynamic> toJson() => _$CountByYearToJson(this);
}

/*
 {
        year: 2022,
        works_count: 133,
        cited_by_count: 32731
    },
  */
