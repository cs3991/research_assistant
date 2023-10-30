import 'package:json_annotation/json_annotation.dart';

part 'biblio.g.dart';

@JsonSerializable(explicitToJson: true)
class Biblio {
  @JsonKey(name: 'volume')
  String? volume;

  @JsonKey(name: 'issue')
  String? issue;

  @JsonKey(name: 'first_page')
  String? firstPage;

  @JsonKey(name: 'last_page')
  String? lastPage;

  Biblio({
    this.volume,
    this.issue,
    this.firstPage,
    this.lastPage,
  });

  factory Biblio.fromJson(Map<String, dynamic> json) => _$BiblioFromJson(json);

  Map<String, dynamic> toJson() => _$BiblioToJson(this);
}

/*
volume (String)
issue (String)
first_page (String)
last_page (String)
 */
