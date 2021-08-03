import 'package:json_annotation/json_annotation.dart';
part 'subjects.g.dart';

@JsonSerializable(
  createToJson: false,
)
class SubjectsDate {
  final int id;
  final String title;
  final int maxValue;
  final bool required;
  SubjectsDate({
    required this.id,
    required this.title,
    required this.required,
    required this.maxValue,
  });

  factory SubjectsDate.fromJson(Map<String, dynamic> json) =>
      _$SubjectsDateFromJson(json);
}
