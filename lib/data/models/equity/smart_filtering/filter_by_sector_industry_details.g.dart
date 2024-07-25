// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_by_sector_industry_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterBySectorIndustryDetails _$FilterBySectorIndustryDetailsFromJson(
        Map<String, dynamic> json) =>
    FilterBySectorIndustryDetails(
      content: (json['content'] as List<dynamic>)
          .map((e) => StockItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable: Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      last: json['last'] as bool,
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
      sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: json['numberOfElements'] as int,
      first: json['first'] as bool,
      size: json['size'] as int,
      number: json['number'] as int,
      empty: json['empty'] as bool,
    );

Map<String, dynamic> _$FilterBySectorIndustryDetailsToJson(
        FilterBySectorIndustryDetails instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'first': instance.first,
      'size': instance.size,
      'number': instance.number,
      'empty': instance.empty,
    };

StockItem _$StockItemFromJson(Map<String, dynamic> json) => StockItem(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      industry: json['industry'] as String,
      sector: json['sector'] as String,
      close: (json['close'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      icon: json['icon'] as String,
      companyName: json['companyName'] as String,
      percentChange: (json['percentChange'] as num).toDouble(),
      isinCode: json['isinCode'] as String,
    );

Map<String, dynamic> _$StockItemToJson(StockItem instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'industry': instance.industry,
      'sector': instance.sector,
      'close': instance.close,
      'change': instance.change,
      'icon': instance.icon,
      'companyName': instance.companyName,
      'percentChange': instance.percentChange,
      'isinCode': instance.isinCode,
    };

Pageable _$PageableFromJson(Map<String, dynamic> json) => Pageable(
      sort: Sort.fromJson(json['sort'] as Map<String, dynamic>),
      pageSize: json['pageSize'] as int,
      pageNumber: json['pageNumber'] as int,
      offset: json['offset'] as int,
      paged: json['paged'] as bool,
      unpaged: json['unpaged'] as bool,
    );

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'sort': instance.sort,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

Sort _$SortFromJson(Map<String, dynamic> json) => Sort(
      unsorted: json['unsorted'] as bool,
      sorted: json['sorted'] as bool,
      empty: json['empty'] as bool,
    );

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'unsorted': instance.unsorted,
      'sorted': instance.sorted,
      'empty': instance.empty,
    };
