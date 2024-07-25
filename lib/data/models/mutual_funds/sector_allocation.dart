import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import '../../../presentation/theme/app_colors.dart';

part 'sector_allocation.g.dart';

////[
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Govt-Sec",
// //             "holding_perc": 30.23,
// //             "market_value": 8373.08
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Finance",
// //             "holding_perc": 25.13,
// //             "market_value": 6952.46
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Banks",
// //             "holding_perc": 22.45,
// //             "market_value": 6215.71
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Retailing",
// //             "holding_perc": 4.48,
// //             "market_value": 1239.34
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Port",
// //             "holding_perc": 3.57,
// //             "market_value": 989.11
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Refineries",
// //             "holding_perc": 3.46,
// //             "market_value": 956.46
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Power",
// //             "holding_perc": 3.2,
// //             "market_value": 886.46
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Steel",
// //             "holding_perc": 3.18,
// //             "market_value": 882.48
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Cash/Deposits/Margins/Treps/Repo/Swaps",
// //             "holding_perc": 1.38,
// //             "market_value": 401.45
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Consumer Staples",
// //             "holding_perc": 1.24,
// //             "market_value": 345.84
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Chemicals",
// //             "holding_perc": 0.81,
// //             "market_value": 223.2
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Pharmaceuticals",
// //             "holding_perc": 0.54,
// //             "market_value": 148.53
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "Diversified",
// //             "holding_perc": 0.27,
// //             "market_value": 74.84
// //         },
// //         {
// //             "as_on_date": "2022-06",
// //             "sector": "TV Broadcasting & Software Production",
// //             "holding_perc": 0.06,
// //             "market_value": 13.92
// //         }
// //     ]

@JsonSerializable(fieldRename: FieldRename.snake)
class SectorAllocationList {
  final List<HoldingSector> sectors;

  SectorAllocationList({required this.sectors});

  factory SectorAllocationList.fromJson(Map<String, dynamic> json) =>
      _$SectorAllocationListFromJson(json);

  Map<String, dynamic> toJson() => _$SectorAllocationListToJson(this);

  List<HoldingSector> get _sortedSectorList => sectors.toList();

  List<String> get sectorNames =>
      _sortedSectorList.map((e) => e.sector).toList();

  List<double> get sectorPercentList =>
      _sortedSectorList.map((e) => e.holdingPercent).toList();

// // get the top 5 sectors else if length is less than 5 then return all the sectors
// List<String> get top5SectorTitles =>
//    (_maxLength>5? _sortedSectorList.getRange(0, 4).map((sector) => sector.sector).toList(): _sortedSectorList.map((sector) => sector.sector).toList());
//
// List<double> get top5SectorHoldingPercent =>
//     _sortedSectorList.map((e) => e.holdingPercent).take(4).toList()
//       ..add(_sortedSectorList.last.holdingPercent);

  double get totalMarketValue => _sortedSectorList.fold(
      0, (previousValue, element) => previousValue + element.marketValue);

//
  List<Color> get top5SectorColors => AppColors.assistedServiceFundColors;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class HoldingSector {
  final String asOnDate;
  final String sector;
  @JsonKey(name: 'holding_perc')
  final double holdingPercent;
  final double marketValue;

  HoldingSector({
    required this.asOnDate,
    required this.sector,
    required this.holdingPercent,
    required this.marketValue,
  });

  factory HoldingSector.fromJson(Map<String, dynamic> json) =>
      _$HoldingSectorFromJson(json);

  Map<String, dynamic> toJson() => _$HoldingSectorToJson(this);
}
