import 'package:json_annotation/json_annotation.dart';

part 'year.g.dart';

abstract class YearBase {
  YearBase({
    required this.year,
  });

  final int year;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class YearWork extends YearBase {
  YearWork({
    required super.year,
    required this.citedByCount,
  });

  factory YearWork.fromJson(Map<String, dynamic> json) =>
      _$YearWorkFromJson(json);

  final int citedByCount;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Year extends YearBase {
  Year({
    required super.year,
    required this.worksCount,
    required this.citedByCount,
  });

  factory Year.fromJson(Map<String, dynamic> json) => _$YearFromJson(json);

  final int worksCount;
  final int citedByCount;
}
