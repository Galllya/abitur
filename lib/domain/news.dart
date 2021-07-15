import 'package:json_annotation/json_annotation.dart';
part 'news.g.dart';

@JsonSerializable(
  createToJson: false,
)
class NewsArticle {
  final int id;
  final String title;
  final String? picture;
  final String? text;
  final DateTime date;
  final bool isFavorite;

  NewsArticle(
      {required this.id,
      required this.title,
      required this.date,
      required this.isFavorite,
      required this.picture,
      required this.text});

  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);
}
