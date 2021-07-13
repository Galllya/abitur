import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class EventViewModel {
  final int id;
  final String title;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? timeFrom;
  final String? timeTo;
  final String? picture;
  final String? text;
  final int points;
  final int? locationX;
  final int? locationY;
  final String? address;
  final String? image;
  final bool? forAbiturients;
  final bool? isFavorite;
  final bool? isInCalendar;
  final bool? isAvailable;

  EventViewModel(
      {required this.id,
      required this.title,
      required this.text,
      required this.picture,
      required this.isFavorite,
      required this.address,
      required this.dateFrom,
      required this.dateTo,
      required this.forAbiturients,
      required this.image,
      required this.isAvailable,
      required this.isInCalendar,
      required this.locationX,
      required this.locationY,
      required this.points,
      required this.timeFrom,
      required this.timeTo});

  factory EventViewModel.fromJson(Map<String, dynamic> json) =>
      _$EventViewModelFromJson(json);
}
