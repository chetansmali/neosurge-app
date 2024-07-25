import 'package:json_annotation/json_annotation.dart';
part 'create_watchlist_params.g.dart';
@JsonSerializable()
class CreateWatchlistParams{
  final String name;

  CreateWatchlistParams({
    required this.name,
});

  factory CreateWatchlistParams.fromJson(Map<String, dynamic> json) =>
      _$CreateWatchlistParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$CreateWatchlistParamsToJson(this);
}