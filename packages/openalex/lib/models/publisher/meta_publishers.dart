import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/models.dart';

part 'meta_publishers.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaPublishers {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Publisher>? publishers;

  MetaPublishers({
    this.meta,
    this.publishers,
  });

  factory MetaPublishers.fromJson(Map<String, dynamic> json) =>
      _$MetaPublishersFromJson(json);

  Map<String, dynamic> toJson() => _$MetaPublishersToJson(this);
}
