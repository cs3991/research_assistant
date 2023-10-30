import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/work/dehydrated_source.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location {
  /// true if this location's version is either acceptedVersion or publishedVersion; otherwise false.
  @JsonKey(name: 'is_accepted')
  bool? isAccepted;

  /// True if this work is Open Access (OA).
  /// There are many ways to define OA. OpenAlex uses a broad definition: having a URL where you can read the fulltext of this work without needing to pay money or log in.
  @JsonKey(name: 'is_oa')
  bool? isOa;

  /// true if this location's version is publishedVersion; otherwise false.
  @JsonKey(name: 'is_published')
  bool? isPublished;

  /// The landing page URL for this location.
  @JsonKey(name: 'landing_page_url')
  String? landingPageUrl;

  /// The location's publishing license. This can be a Create Commons license such as cc0 or cc-by, a publisher-specific license, or null which means we are not able to determine a license for this location.
  String? license;

  /// Information about the source of this location, as a DehydratedSource object.
  /// The concept of a source is meant to capture a certain social relationship between the host organization and a version of a work.
  /// When an organization puts the work on the internet, there is an understanding that they have, at some level, endorsed the work. This level varies, and can be very different depending on the source!
  DehydratedSource? source;

  /// A URL where you can find this location as a PDF.
  @JsonKey(name: 'pdf_url')
  String? pdfUrl;

  /// The version of the work, based on the DRIVER Guidelines versioning scheme. Possible values are:.
  /// publishedVersion: The document’s version of record. This is the most authoritative version.
  /// acceptedVersion: The document after having completed peer review and being officially accepted for publication. It will lack publisher formatting, but the content should be interchangeable with the that of the publishedVersion.
  /// submittedVersion: the document as submitted to the publisher by the authors, but before peer-review. Its content may differ significantly from that of the accepted article.
  String? version;

  Location({
    this.isAccepted,
    this.isOa,
    this.isPublished,
    this.landingPageUrl,
    this.license,
    this.source,
    this.pdfUrl,
    this.version,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
