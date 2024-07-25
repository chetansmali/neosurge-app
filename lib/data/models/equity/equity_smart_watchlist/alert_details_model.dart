import 'package:json_annotation/json_annotation.dart';
part 'alert_details_model.g.dart';

@JsonSerializable()
class AlertDetailsModel {
  final bool? success;
  final String? message;
  final DataClass data;

  AlertDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AlertDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AlertDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertDetailsModelToJson(this);
}

@JsonSerializable()
class DataClass {
  final String? icon;
  final String? symbol;
  final String? companyName;
  final String? sector;
  final double? close;
  final double? change;
  final double? percentChange;
  final double? alertPrice;
  final bool? lastAlertIsTriggered;
  final HoldingValues holdingValues;
  final Transactions transactions;
  final List<News> news;
  final List<ChartData> chartData;

  DataClass({
    required this.icon,
    required this.symbol,
    required this.companyName,
    required this.sector,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.alertPrice,
    required this.lastAlertIsTriggered,
    required this.holdingValues,
    required this.transactions,
    required this.news,
    required this.chartData,
  });
  factory DataClass.fromJson(Map<String, dynamic> json) =>
      _$DataClassFromJson(json);

  Map<String, dynamic> toJson() => _$DataClassToJson(this);
}

@JsonSerializable()
class ChartData {
  final DateTime datetime;
  @JsonKey(fromJson: double.parse)
  final double close;

  ChartData({
    required this.datetime,
    required this.close,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChartDataToJson(this);
}

@JsonSerializable()
class HoldingValues {
  final double? avgValue;
  final double? investedValue;
  final double? currentValue;
  final double? returns;
  final double? returnsPercent;

  HoldingValues({
    required this.avgValue,
    required this.investedValue,
    required this.currentValue,
    required this.returns,
    required this.returnsPercent,
  });

  factory HoldingValues.fromJson(Map<String, dynamic> json) =>
      _$HoldingValuesFromJson(json);

  Map<String, dynamic> toJson() => _$HoldingValuesToJson(this);
}

@JsonSerializable()
class News {
  final Article article;
  final FeaturedHighlight featuredHighlight;

  News({
    required this.article,
    required this.featuredHighlight,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Article {
  final String? id;
  final String? uuid;
  final String? description;
  final String? imageUrl;
  final String? keywords;
  final String? language;
  final int? publishedAt;
  final double? sentimentGreaterThan;
  final double? sentimentLessThan;
  final String? snippet;
  final String? source;
  final int? timestamp;
  final String? title;
  final String? url;

  Article({
    required this.id,
    required this.uuid,
    required this.description,
    required this.imageUrl,
    required this.keywords,
    required this.language,
    required this.publishedAt,
    required this.sentimentGreaterThan,
    required this.sentimentLessThan,
    required this.snippet,
    required this.source,
    required this.timestamp,
    required this.title,
    required this.url,
  });
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class FeaturedHighlight {
  final Entity entity;
  final Highlight highlight;

  FeaturedHighlight({
    required this.entity,
    required this.highlight,
  });
  factory FeaturedHighlight.fromJson(Map<String, dynamic> json) =>
      _$FeaturedHighlightFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturedHighlightToJson(this);
}

@JsonSerializable()
class Entity {
  final String? newsUuid;
  final String? symbol;
  final String? industry;
  final String? name;
  final double? sentimentScore;
  final String? type;

  Entity({
    required this.newsUuid,
    required this.symbol,
    required this.industry,
    required this.name,
    required this.sentimentScore,
    required this.type,
  });
  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

@JsonSerializable()
class Highlight {
  final String? highlight;
  final double? sentiment;

  Highlight({
    required this.highlight,
    required this.sentiment,
  });
  factory Highlight.fromJson(Map<String, dynamic> json) =>
      _$HighlightFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightToJson(this);
}

@JsonSerializable()
class Transactions {
  final List<BuySellTransaction> buyTransactions;
  final List<BuySellTransaction> sellTransactions;
  final DateTime? earliestTransactionDate;
  final DateTime? latestTransactionDate;
  final List<TransactionsByDate>? transactionsByDate;

  Transactions({
    required this.buyTransactions,
    required this.sellTransactions,
    required this.earliestTransactionDate,
    required this.latestTransactionDate,
    required this.transactionsByDate,
  });
  factory Transactions.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsToJson(this);
}

@JsonSerializable()
class BuySellTransaction {
  final String? creationMonthYear;
  final int? creationDay;
  final String? status;
  final String? orderType;
  final String? exchange;
  final String? broker;
  final int? quantity;
  final String? tradingSymbol;
  final String? companyName;
  final String? transactionType;
  final int? filledQuantity;
  final double? averagePrice;
  final String? statusMessage;
  final DateTime? txnCompletedDateTime;

  BuySellTransaction({
    required this.creationMonthYear,
    required this.creationDay,
    required this.status,
    required this.orderType,
    required this.exchange,
    required this.broker,
    required this.quantity,
    required this.tradingSymbol,
    required this.companyName,
    required this.transactionType,
    required this.filledQuantity,
    required this.averagePrice,
    required this.statusMessage,
    required this.txnCompletedDateTime,
  });
  factory BuySellTransaction.fromJson(Map<String, dynamic> json) =>
      _$BuySellTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$BuySellTransactionToJson(this);
}

@JsonSerializable()
class TransactionsByDate {
  final DateTime? date;
  final double? netWeightedAveragePrice;

  TransactionsByDate({
    required this.date,
    required this.netWeightedAveragePrice,
  });

  factory TransactionsByDate.fromJson(Map<String, dynamic> json) =>
      _$TransactionsByDateFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsByDateToJson(this);
}
