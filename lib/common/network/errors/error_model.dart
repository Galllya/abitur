import 'package:json_annotation/json_annotation.dart';
part 'error_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class ErrorModel {
  @JsonKey(name: '#')
  final List<String> commonErrors;

  ErrorModel(this.commonErrors);

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}
