// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stocks_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStocksParams _$AllStocksParamsFromJson(Map<String, dynamic> json) =>
    AllStocksParams(
      sortBy: json['sortBy'] as String?,
      direction: json['direction'] as String?,
      filter: json['filter'] as String?,
      industries: json['industries'] as String?,
      size: json['size'] as String,
      page: json['page'] as String,
    );

Map<String, dynamic> _$AllStocksParamsToJson(AllStocksParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sortBy', instance.sortBy);
  writeNotNull('direction', instance.direction);
  writeNotNull('filter', instance.filter);
  writeNotNull('industries', instance.industries);
  val['size'] = instance.size;
  val['page'] = instance.page;
  return val;
}
