import 'package:json_annotation/json_annotation.dart';
part 'delete_symbol.g.dart';
@JsonSerializable()
class DeleteSymbolModel{
  final String data;

  DeleteSymbolModel({
    required this.data,
});
  factory DeleteSymbolModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteSymbolModelFromJson(json);

  Map<String,dynamic> toJson() =>
      _$DeleteSymbolModelToJson(this);
}