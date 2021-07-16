// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Pagination<T>(
    (json['elements'] as List<dynamic>).map(fromJsonT).toList(),
    json['totalCount'] as int,
  );
}
