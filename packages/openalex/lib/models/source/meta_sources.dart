import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/models.dart';

part 'meta_sources.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaSources {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Source>? sources;

  MetaSources({
    this.meta,
    this.sources,
  });

  factory MetaSources.fromJson(Map<String, dynamic> json) =>
      _$MetaSourcesFromJson(json);

  Map<String, dynamic> toJson() => _$MetaSourcesToJson(this);
}
