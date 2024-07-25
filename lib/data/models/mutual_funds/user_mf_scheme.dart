import 'package:json_annotation/json_annotation.dart';

part 'user_mf_scheme.g.dart';

@JsonSerializable()
class UserMfScheme {
  final String isin;
  final String folioNumber;
  final String name;
  final String type;
  final double holdingUnits;
  final double redeemableUnits;
  final double investedAmount;
  final String investedAsOn;
  final double currentValue;
  final double redeemableAmount;
  final double nav;
  final double gainOrLoss;
  final double absoluteReturns;
  final DateTime navAsOn;
  final double avgNav;
  final bool exitTriggerGenerated;
  @JsonKey(includeFromJson: false, includeToJson: false)

  ///By default this is false and this key is used to identify within app if the fund is from assisted portfolio or not which will be set in cubit level
  final bool isAssistedFund;

  double get returns => currentValue - investedAmount;

  UserMfScheme({
    required this.isin,
    required this.folioNumber,
    required this.name,
    required this.type,
    required this.holdingUnits,
    required this.redeemableUnits,
    required this.investedAmount,
    required this.investedAsOn,
    required this.currentValue,
    required this.redeemableAmount,
    required this.nav,
    required this.gainOrLoss,
    required this.absoluteReturns,
    required this.navAsOn,
    required this.avgNav,
    required this.exitTriggerGenerated,
    this.isAssistedFund = false,
  });

  UserMfScheme copyWith({bool? isAssistedFund}) => UserMfScheme(
        isin: isin,
        folioNumber: folioNumber,
        name: name,
        type: type,
        holdingUnits: holdingUnits,
        redeemableUnits: redeemableUnits,
        investedAmount: investedAmount,
        investedAsOn: investedAsOn,
        currentValue: currentValue,
        redeemableAmount: redeemableAmount,
        nav: nav,
        gainOrLoss: gainOrLoss,
        absoluteReturns: absoluteReturns,
        navAsOn: navAsOn,
        avgNav: avgNav,
        exitTriggerGenerated: exitTriggerGenerated,
        isAssistedFund: isAssistedFund ?? this.isAssistedFund,
      );

  factory UserMfScheme.fromJson(Map<String, dynamic> json) =>
      _$UserMfSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UserMfSchemeToJson(this);
}
