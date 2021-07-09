// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel<T> _$PaginationModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return PaginationModel<T>(
    (json['elements'] as List<dynamic>).map(fromJsonT).toList(),
    json['totalCount'] as int,
  );
}
