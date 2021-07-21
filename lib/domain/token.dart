import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

@JsonSerializable(
  createToJson: false,
)
class TokenData {
  final String token;

  TokenData({required this.token});

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);
}
