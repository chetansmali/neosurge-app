class DigitalGoldGraphResponse {
  final double goldBuyRate;
  final double goldSellRate;
  final double silverBuyRate;
  final double silverSellRate;
  final DateTime date;

  DigitalGoldGraphResponse({
    required this.goldBuyRate,
    required this.goldSellRate,
    required this.silverBuyRate,
    required this.silverSellRate,
    required this.date,
  });
}
