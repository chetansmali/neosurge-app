import 'package:json_annotation/json_annotation.dart';
part 'business_houses_model.g.dart';

@JsonSerializable()
class BusinessHouseModel {
  final String? businessHouseEnum;
  final String? businessHouse;
  final int? count;
  final String? icon;

  BusinessHouseModel({
    required this.businessHouseEnum,
    required this.businessHouse,
    required this.count,
    required this.icon,
  });

  factory BusinessHouseModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessHouseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessHouseModelToJson(this);

  static List<BusinessHouseModel> listFromJson(List<dynamic> json) =>
      json.map((e) => BusinessHouseModel.fromJson(e)).toList();
}
