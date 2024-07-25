import 'package:json_annotation/json_annotation.dart';
part 'fetch_market_news_params.g.dart';

@JsonSerializable()

class FetchMarketNewsParams{
  final String date;
  FetchMarketNewsParams({required this.date});

  factory FetchMarketNewsParams.fromJson(Map<String,dynamic>json)=>_$FetchMarketNewsParamsFromJson(json);
  Map<String, dynamic>toJson()=>_$FetchMarketNewsParamsToJson(this);
}