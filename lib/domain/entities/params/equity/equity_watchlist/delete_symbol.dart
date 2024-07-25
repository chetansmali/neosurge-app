import 'package:json_annotation/json_annotation.dart';
part 'delete_symbol.g.dart';
@JsonSerializable()
class DeleteSymbolParams{
  final int watchlistId;
  final int symbolId;

  DeleteSymbolParams({
    required this.watchlistId,
    required this.symbolId,
});
  factory DeleteSymbolParams.fromJson(Map<String, dynamic> json) =>
      _$DeleteSymbolParamsFromJson(json);

  Map<String,dynamic> toJson() =>
      _$DeleteSymbolParamsToJson(this);
}