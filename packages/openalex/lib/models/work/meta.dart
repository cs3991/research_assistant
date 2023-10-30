import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable(explicitToJson: true)
class Meta {
  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'db_response_time_ms')
  int? dbResponseTimeMs;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'per_page')
  int? perPage;

  Meta({
    this.count,
    this.dbResponseTimeMs,
    this.page,
    this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

/*
 "count": 245684392,
        "db_response_time_ms": 929,
        "page": 1,
        "per_page": 25
  */
