// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorship _$AuthorshipFromJson(Map<String, dynamic> json) => Authorship(
      authorPosition: json['author_position'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      institutions: (json['institutions'] as List<dynamic>?)
          ?.map(
              (e) => DehydratedInstitution.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorshipToJson(Authorship instance) =>
    <String, dynamic>{
      'author_position': instance.authorPosition,
      'author': instance.author?.toJson(),
      'institutions': instance.institutions?.map((e) => e.toJson()).toList(),
    };
