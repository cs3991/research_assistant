// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      role: json['role'] as String?,
      id: json['id'] as String?,
      worksCount: json['works_count'] as int?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'role': instance.role,
      'id': instance.id,
      'works_count': instance.worksCount,
    };
