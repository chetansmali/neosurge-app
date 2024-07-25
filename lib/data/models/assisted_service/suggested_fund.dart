import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/params/assisted_service/invest_suggested_funds_params.dart';
import '../mutual_funds/fund.dart';

part 'suggested_fund.g.dart';

@JsonSerializable()
class SuggestedFund {
  //{
  //             "fundHouseId": 1,
  //             "type": "major",
  //             "id": 3,
  //             "fundId": "145723",
  //             "name": "Tata Arbitrage Fund-Regular Plan-Growth",
  //             "amount": 6500000,
  //             "isin": "INF277K015Q7",
  //             "isThematic": false
  //         },

  final int fundHouseId;
  final String type;
  final int id;
  final String fundId;
  final String name;
  final double amount;
  final String isin;
  final bool isThematic;
  final Performance performance;
  @JsonKey(name: 'img_url')
  final String imgUrl;

  SuggestedFundDetail get toSuggestedFundDetail => SuggestedFundDetail(
        id: id,
        amount: amount,
        fundId: fundId,
        name: name,
        type: type,
        isThematic: isThematic,
      );

  SuggestedFund({
    required this.fundHouseId,
    required this.type,
    required this.id,
    required this.fundId,
    required this.name,
    required this.amount,
    required this.isin,
    required this.isThematic,
    required this.performance,
    required this.imgUrl,
  });

  factory SuggestedFund.fromJson(Map<String, dynamic> json) =>
      _$SuggestedFundFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedFundToJson(this);
}
