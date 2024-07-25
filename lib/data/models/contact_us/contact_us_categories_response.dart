import 'package:json_annotation/json_annotation.dart';

part 'contact_us_categories_response.g.dart';

@JsonSerializable()
class ContactUsCategoriesModel {
  String enumName;
  String displayName;
  String icon;

  ContactUsCategoriesModel({
    required this.enumName,
    required this.displayName,
    required this.icon,
  });

  factory ContactUsCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsCategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsCategoriesModelToJson(this);
}
