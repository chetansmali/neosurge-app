import 'package:json_annotation/json_annotation.dart';
part 'equity_brokers.g.dart';
@JsonSerializable()
class BrokersModel{
  final String id;
  final String broker;
  final String icon;
  final String key;
  final String name;

  BrokersModel({
    required this.id,
    required this.broker,
    required this.icon,
    required this.key,
    required this.name
});
  factory BrokersModel.fromJson(Map<String, dynamic> json) =>
      _$BrokersModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$BrokersModelToJson(this);

  static List<BrokersModel> listFromJson(List<dynamic> json) =>
      json.map((e) => BrokersModel.fromJson(e)).toList();
}