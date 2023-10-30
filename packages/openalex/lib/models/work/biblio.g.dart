// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biblio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Biblio _$BiblioFromJson(Map<String, dynamic> json) => Biblio(
      volume: json['volume'] as String?,
      issue: json['issue'] as String?,
      firstPage: json['first_page'] as String?,
      lastPage: json['last_page'] as String?,
    );

Map<String, dynamic> _$BiblioToJson(Biblio instance) => <String, dynamic>{
      'volume': instance.volume,
      'issue': instance.issue,
      'first_page': instance.firstPage,
      'last_page': instance.lastPage,
    };
