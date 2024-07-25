import 'package:json_annotation/json_annotation.dart';
part 'get_all_watchlist_model.g.dart';

@JsonSerializable()
class GetAllWatchlistModel{
  final int id;
  final String name;
  final String associatedUserEmail;

  GetAllWatchlistModel({
    required this.id,
    required this.name,
    required this.associatedUserEmail,
});
  factory GetAllWatchlistModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllWatchlistModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$GetAllWatchlistModelToJson(this);

  static List<GetAllWatchlistModel> listFromJson(List<dynamic> json) =>
      json.map((e) => GetAllWatchlistModel.fromJson(e)).toList();
}
