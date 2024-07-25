// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stocks_by_index_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StocksByIndexModel _$StocksByIndexModelFromJson(Map<String, dynamic> json) =>
    StocksByIndexModel(
      indexInstruments: (json['indexInstruments'] as List<dynamic>)
          .map((e) => SubsidiaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      index: IndexDetails.fromJson(json['index'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StocksByIndexModelToJson(StocksByIndexModel instance) =>
    <String, dynamic>{
      'indexInstruments': instance.indexInstruments,
      'index': instance.index,
    };
