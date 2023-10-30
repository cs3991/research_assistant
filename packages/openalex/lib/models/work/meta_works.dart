import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/work/meta.dart';
import 'package:openalex/models/work/work.dart';

part 'meta_works.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaWorks {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Work>? works;

  MetaWorks({
    this.meta,
    this.works,
  });

  factory MetaWorks.fromJson(Map<String, dynamic> json) =>
      _$MetaWorksFromJson(json);

  Map<String, dynamic> toJson() => _$MetaWorksToJson(this);
}
