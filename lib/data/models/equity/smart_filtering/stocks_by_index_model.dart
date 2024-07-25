import 'package:json_annotation/json_annotation.dart';

import 'smart_filter_indices_details.dart';
import 'subsidiaries_model.dart';

part 'stocks_by_index_model.g.dart';

@JsonSerializable()
class StocksByIndexModel {
  final List<SubsidiaryModel> indexInstruments;
  final IndexDetails index;

  StocksByIndexModel({
    required this.indexInstruments,
    required this.index,
  });

  factory StocksByIndexModel.fromJson(Map<String, dynamic> json) =>
      _$StocksByIndexModelFromJson(json);

  Map<String, dynamic> toJson() => _$StocksByIndexModelToJson(this);
}
