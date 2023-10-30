import 'package:json_annotation/json_annotation.dart';

part 'open_access.g.dart';

@JsonSerializable(explicitToJson: true)
class OpenAccess {
  /// True if any of this work's locations has location.is_oa=true and location.source.type=repository.
  /// Use case: researchers want to track Green OA, using a definition of "any repository hosts this." OpenAlex's definition (as used in oa_status) doesn't support this, because as soon as there's a publisher-hosted copy (bronze, hybrid, or gold), oa_status is set to that publisher-hosted status.
  /// So there's a lot of repository-hosted content that the oa_status can't tell you about. Our State of OA paper calls this "shadowed Green." This feature makes it possible to track shadowed Green.
  @JsonKey(name: 'any_repository_has_fulltext')
  bool? anyRepositoryHasFulltext;

  /// The Open Access (OA) status of this work. Possible values are:
  /// gold: Published in an OA journal that is indexed by the DOAJ.
  /// green: Toll-access on the publisher landing page, but there is a free copy in an OA repository.
  /// hybrid: Free under an open license in a toll-access journal.
  /// bronze: Free to read on the publisher landing page, but without any identifiable license.
  /// closed: All other articles.
  @JsonKey(name: 'oa_status')
  String? oaStatus;

  /// The best Open Access (OA) URL for this work.
  /// Although there are many ways to define OA, in this context an OA URL is one where you can read the fulltext of this work without needing to pay money or log in. The "best" such URL is the one closest to the version of record.
  /// This URL might be a direct link to a PDF, or it might be to a landing page that links to the free PDF
  @JsonKey(name: 'oa_url')
  String? oaUrl;

  OpenAccess({
    this.anyRepositoryHasFulltext,
    this.oaStatus,
    this.oaUrl,
  });

  factory OpenAccess.fromJson(Map<String, dynamic> json) =>
      _$OpenAccessFromJson(json);

  Map<String, dynamic> toJson() => _$OpenAccessToJson(this);
}
