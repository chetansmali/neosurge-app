import 'package:json_annotation/json_annotation.dart';
part 'smart_watchlist_search_params.g.dart';

@JsonSerializable()
class SmartWatchlistSearchParams {
  final String filter;
  final int size;

  SmartWatchlistSearchParams({required this.filter, required this.size});

  factory SmartWatchlistSearchParams.fromJson(Map<String, dynamic> json) =>
      _$SmartWatchlistSearchParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SmartWatchlistSearchParamsToJson(this);
}
