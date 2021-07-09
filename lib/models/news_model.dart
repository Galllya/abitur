import 'package:json_annotation/json_annotation.dart';
part 'news_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class NewsViewModel {
  final int id;
  final String title;
  final String? picture;
  final String? text;
  final DateTime date;
  final bool isFavorite;

  NewsViewModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.isFavorite,
      required this.picture,
      required this.text});

  factory NewsViewModel.fromJson(Map<String, dynamic> json) =>
      _$NewsViewModelFromJson(json);
}
