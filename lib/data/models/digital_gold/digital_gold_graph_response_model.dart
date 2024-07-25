import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/digital_gold/digital_gold_graph_response_entity.dart';

part 'digital_gold_graph_response_model.g.dart';

@JsonSerializable()
class DigitalGoldGraphResponseModel extends DigitalGoldGraphResponse {
  final int id;
  @override
  final double goldBuyRate;
  @override
  final double goldSellRate;
  @override
  final double silverBuyRate;
  @override
  final double silverSellRate;
  final DateTime onDate;

  DigitalGoldGraphResponseModel({
    required this.id,
    required this.goldBuyRate,
    required this.goldSellRate,
    required this.silverBuyRate,
    required this.silverSellRate,
    required this.onDate,
  }) : super(
          goldBuyRate: goldBuyRate,
          goldSellRate: goldSellRate,
          silverBuyRate: silverBuyRate,
          silverSellRate: silverSellRate,
          date: onDate,
        );

  factory DigitalGoldGraphResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DigitalGoldGraphResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalGoldGraphResponseModelToJson(this);
}
