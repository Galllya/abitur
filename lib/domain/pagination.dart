import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class Pagination<T> {
  final List<T> elements;
  final int totalCount;

  Pagination(this.elements, this.totalCount);

  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);
}
