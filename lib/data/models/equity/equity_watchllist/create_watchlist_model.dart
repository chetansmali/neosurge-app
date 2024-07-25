import 'package:json_annotation/json_annotation.dart';

part 'create_watchlist_model.g.dart';

@JsonSerializable()
class CreateWatchlistModel {
  final int? id;
  final String name;
  final String associatedUserEmail;

  CreateWatchlistModel(
      {required this.id,
      required this.name,
      required this.associatedUserEmail});

  factory CreateWatchlistModel.fromJson(Map<String, dynamic> json) =>
      _$CreateWatchlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWatchlistModelToJson(this);
}
