import 'package:json_annotation/json_annotation.dart';
part 'favorites.g.dart';

@JsonSerializable(
  createToJson: false,
)
class FavoritesDate {
  final int id;
  final String title;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String timeFrom;
  final String timeTo;
  final int points;
  final int costPoints;
  final int costRubles;
  final String category;
  final String picture;

  FavoritesDate(
      {required this.id,
      required this.title,
      required this.points,
      required this.dateTo,
      required this.dateFrom,
      required this.picture,
      required this.timeTo,
      required this.timeFrom,
      required this.category,
      required this.costPoints,
      required this.costRubles});

  factory FavoritesDate.fromJson(Map<String, dynamic> json) =>
      _$FavoritesDateFromJson(json);
}
