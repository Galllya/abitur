import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class PaginationModel<T> {
  final List<T> elements;
  final int totalCount;

  PaginationModel(this.elements, this.totalCount);

  factory PaginationModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationModelFromJson(json, fromJsonT);
}
