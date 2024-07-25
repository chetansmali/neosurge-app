import 'package:json_annotation/json_annotation.dart';
part 'delete_watchlist.g.dart';
@JsonSerializable()
class DeleteWatchlistModel{
  final bool success;
  final String? message;


  DeleteWatchlistModel({
    required this.success,
    required this.message,
});
  factory DeleteWatchlistModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteWatchlistModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$DeleteWatchlistModelToJson(this);
}