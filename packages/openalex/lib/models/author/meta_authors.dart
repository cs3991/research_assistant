import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/models.dart';

part 'meta_authors.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaAuthors {
  Meta? meta;

  @JsonKey(name: 'results')
  List<Author>? authors;

  MetaAuthors({
    this.meta,
    this.authors,
  });

  factory MetaAuthors.fromJson(Map<String, dynamic> json) =>
      _$MetaAuthorsFromJson(json);

  Map<String, dynamic> toJson() => _$MetaAuthorsToJson(this);
}
