import 'package:json_annotation/json_annotation.dart';

part 'filter_by_sector_industry_details.g.dart';

@JsonSerializable()
class FilterBySectorIndustryDetails {
  List<StockItem> content;
  Pageable pageable;
  bool last;
  int totalElements;
  int totalPages;
  Sort sort;
  int numberOfElements;
  bool first;
  int size;
  int number;
  bool empty;

  FilterBySectorIndustryDetails({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.size,
    required this.number,
    required this.empty,
  });

  factory FilterBySectorIndustryDetails.fromJson(Map<String, dynamic> json) =>
      _$FilterBySectorIndustryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$FilterBySectorIndustryDetailsToJson(this);
}

@JsonSerializable()
class StockItem {
  String id;
  String symbol;
  String industry;
  String sector;
  double close;
  double change;
  String icon;
  String companyName;
  double percentChange;
  String isinCode;

  StockItem({
    required this.id,
    required this.symbol,
    required this.industry,
    required this.sector,
    required this.close,
    required this.change,
    required this.icon,
    required this.companyName,
    required this.percentChange,
    required this.isinCode,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) =>
      _$StockItemFromJson(json);
  Map<String, dynamic> toJson() => _$StockItemToJson(this);
}

@JsonSerializable()
class Pageable {
  Sort sort;
  int pageSize;
  int pageNumber;
  int offset;
  bool paged;
  bool unpaged;

  Pageable({
    required this.sort,
    required this.pageSize,
    required this.pageNumber,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}

@JsonSerializable()
class Sort {
  bool unsorted;
  bool sorted;
  bool empty;

  Sort({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);
  Map<String, dynamic> toJson() => _$SortToJson(this);
}
