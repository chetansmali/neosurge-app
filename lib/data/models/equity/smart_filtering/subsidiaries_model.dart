import 'package:json_annotation/json_annotation.dart';
part 'subsidiaries_model.g.dart';

@JsonSerializable()
class SubsidiaryModel {
  final String? symbol;
  final String? icon;
  final String? industry;
  final String? sector;
  final String? businessHouse;
  final String? companyName;
  final double? marketCapitalization;
  final double? percentChange;
  final double? change;
  final double? close;

  SubsidiaryModel({
    required this.symbol,
    required this.icon,
    required this.industry,
    required this.sector,
    required this.businessHouse,
    required this.companyName,
    required this.marketCapitalization,
    required this.percentChange,
    required this.change,
    required this.close,
  });

  factory SubsidiaryModel.fromJson(Map<String, dynamic> json) =>
      _$SubsidiaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubsidiaryModelToJson(this);

  static List<SubsidiaryModel> listFromJson(List<dynamic> json) =>
      json.map((e) => SubsidiaryModel.fromJson(e)).toList();
}
