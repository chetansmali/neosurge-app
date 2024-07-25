import 'package:json_annotation/json_annotation.dart';
part 'delete_watchlist_params.g.dart';

@JsonSerializable()
class DeleteWatchlistParams{
  final String id;

  DeleteWatchlistParams({
    required this.id,
});
  factory DeleteWatchlistParams.fromJson(Map<String, dynamic> json) =>
      _$DeleteWatchlistParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$DeleteWatchlistParamsToJson(this);
}