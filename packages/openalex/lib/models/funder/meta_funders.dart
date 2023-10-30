import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/funder/funder.dart';
import 'package:openalex/models/work/meta.dart';

part 'meta_funders.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaFunders {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Funder>? funders;

  MetaFunders({
    this.meta,
    this.funders,
  });

  factory MetaFunders.fromJson(Map<String, dynamic> json) =>
      _$MetaFundersFromJson(json);

  Map<String, dynamic> toJson() => _$MetaFundersToJson(this);
}
