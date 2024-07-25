import 'package:json_annotation/json_annotation.dart';

part 'amc_logo.g.dart';

@JsonSerializable()
class AmcLogo {
  final int id;
  final String amcCode;
  final String amcName;
  final String imgUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  AmcLogo({
    required this.id,
    required this.amcCode,
    required this.amcName,
    required this.imgUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AmcLogo.fromJson(Map<String, dynamic> json) =>
      _$AmcLogoFromJson(json);

  Map<String, dynamic> toJson() => _$AmcLogoToJson(this);
}
