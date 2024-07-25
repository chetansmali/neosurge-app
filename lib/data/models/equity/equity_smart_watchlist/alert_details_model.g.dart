// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertDetailsModel _$AlertDetailsModelFromJson(Map<String, dynamic> json) =>
    AlertDetailsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: DataClass.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlertDetailsModelToJson(AlertDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

DataClass _$DataClassFromJson(Map<String, dynamic> json) => DataClass(
      icon: json['icon'] as String?,
      symbol: json['symbol'] as String?,
      companyName: json['companyName'] as String?,
      sector: json['sector'] as String?,
      close: (json['close'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      alertPrice: (json['alertPrice'] as num?)?.toDouble(),
      lastAlertIsTriggered: json['lastAlertIsTriggered'] as bool?,
      holdingValues:
          HoldingValues.fromJson(json['holdingValues'] as Map<String, dynamic>),
      transactions:
          Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
      news: (json['news'] as List<dynamic>)
          .map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
      chartData: (json['chartData'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataClassToJson(DataClass instance) => <String, dynamic>{
      'icon': instance.icon,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'sector': instance.sector,
      'close': instance.close,
      'change': instance.change,
      'percentChange': instance.percentChange,
      'alertPrice': instance.alertPrice,
      'lastAlertIsTriggered': instance.lastAlertIsTriggered,
      'holdingValues': instance.holdingValues,
      'transactions': instance.transactions,
      'news': instance.news,
      'chartData': instance.chartData,
    };

ChartData _$ChartDataFromJson(Map<String, dynamic> json) => ChartData(
      datetime: DateTime.parse(json['datetime'] as String),
      close: double.parse(json['close'] as String),
    );

Map<String, dynamic> _$ChartDataToJson(ChartData instance) => <String, dynamic>{
      'datetime': instance.datetime.toIso8601String(),
      'close': instance.close,
    };

HoldingValues _$HoldingValuesFromJson(Map<String, dynamic> json) =>
    HoldingValues(
      avgValue: (json['avgValue'] as num?)?.toDouble(),
      investedValue: (json['investedValue'] as num?)?.toDouble(),
      currentValue: (json['currentValue'] as num?)?.toDouble(),
      returns: (json['returns'] as num?)?.toDouble(),
      returnsPercent: (json['returnsPercent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HoldingValuesToJson(HoldingValues instance) =>
    <String, dynamic>{
      'avgValue': instance.avgValue,
      'investedValue': instance.investedValue,
      'currentValue': instance.currentValue,
      'returns': instance.returns,
      'returnsPercent': instance.returnsPercent,
    };

News _$NewsFromJson(Map<String, dynamic> json) => News(
      article: Article.fromJson(json['article'] as Map<String, dynamic>),
      featuredHighlight: FeaturedHighlight.fromJson(
          json['featuredHighlight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'article': instance.article,
      'featuredHighlight': instance.featuredHighlight,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as String?,
      uuid: json['uuid'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      keywords: json['keywords'] as String?,
      language: json['language'] as String?,
      publishedAt: json['publishedAt'] as int?,
      sentimentGreaterThan: (json['sentimentGreaterThan'] as num?)?.toDouble(),
      sentimentLessThan: (json['sentimentLessThan'] as num?)?.toDouble(),
      snippet: json['snippet'] as String?,
      source: json['source'] as String?,
      timestamp: json['timestamp'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'keywords': instance.keywords,
      'language': instance.language,
      'publishedAt': instance.publishedAt,
      'sentimentGreaterThan': instance.sentimentGreaterThan,
      'sentimentLessThan': instance.sentimentLessThan,
      'snippet': instance.snippet,
      'source': instance.source,
      'timestamp': instance.timestamp,
      'title': instance.title,
      'url': instance.url,
    };

FeaturedHighlight _$FeaturedHighlightFromJson(Map<String, dynamic> json) =>
    FeaturedHighlight(
      entity: Entity.fromJson(json['entity'] as Map<String, dynamic>),
      highlight: Highlight.fromJson(json['highlight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeaturedHighlightToJson(FeaturedHighlight instance) =>
    <String, dynamic>{
      'entity': instance.entity,
      'highlight': instance.highlight,
    };

Entity _$EntityFromJson(Map<String, dynamic> json) => Entity(
      newsUuid: json['newsUuid'] as String?,
      symbol: json['symbol'] as String?,
      industry: json['industry'] as String?,
      name: json['name'] as String?,
      sentimentScore: (json['sentimentScore'] as num?)?.toDouble(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      'newsUuid': instance.newsUuid,
      'symbol': instance.symbol,
      'industry': instance.industry,
      'name': instance.name,
      'sentimentScore': instance.sentimentScore,
      'type': instance.type,
    };

Highlight _$HighlightFromJson(Map<String, dynamic> json) => Highlight(
      highlight: json['highlight'] as String?,
      sentiment: (json['sentiment'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HighlightToJson(Highlight instance) => <String, dynamic>{
      'highlight': instance.highlight,
      'sentiment': instance.sentiment,
    };

Transactions _$TransactionsFromJson(Map<String, dynamic> json) => Transactions(
      buyTransactions: (json['buyTransactions'] as List<dynamic>)
          .map((e) => BuySellTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellTransactions: (json['sellTransactions'] as List<dynamic>)
          .map((e) => BuySellTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      earliestTransactionDate: json['earliestTransactionDate'] == null
          ? null
          : DateTime.parse(json['earliestTransactionDate'] as String),
      latestTransactionDate: json['latestTransactionDate'] == null
          ? null
          : DateTime.parse(json['latestTransactionDate'] as String),
      transactionsByDate: (json['transactionsByDate'] as List<dynamic>?)
          ?.map((e) => TransactionsByDate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionsToJson(Transactions instance) =>
    <String, dynamic>{
      'buyTransactions': instance.buyTransactions,
      'sellTransactions': instance.sellTransactions,
      'earliestTransactionDate':
          instance.earliestTransactionDate?.toIso8601String(),
      'latestTransactionDate':
          instance.latestTransactionDate?.toIso8601String(),
      'transactionsByDate': instance.transactionsByDate,
    };

BuySellTransaction _$BuySellTransactionFromJson(Map<String, dynamic> json) =>
    BuySellTransaction(
      creationMonthYear: json['creationMonthYear'] as String?,
      creationDay: json['creationDay'] as int?,
      status: json['status'] as String?,
      orderType: json['orderType'] as String?,
      exchange: json['exchange'] as String?,
      broker: json['broker'] as String?,
      quantity: json['quantity'] as int?,
      tradingSymbol: json['tradingSymbol'] as String?,
      companyName: json['companyName'] as String?,
      transactionType: json['transactionType'] as String?,
      filledQuantity: json['filledQuantity'] as int?,
      averagePrice: (json['averagePrice'] as num?)?.toDouble(),
      statusMessage: json['statusMessage'] as String?,
      txnCompletedDateTime: json['txnCompletedDateTime'] == null
          ? null
          : DateTime.parse(json['txnCompletedDateTime'] as String),
    );

Map<String, dynamic> _$BuySellTransactionToJson(BuySellTransaction instance) =>
    <String, dynamic>{
      'creationMonthYear': instance.creationMonthYear,
      'creationDay': instance.creationDay,
      'status': instance.status,
      'orderType': instance.orderType,
      'exchange': instance.exchange,
      'broker': instance.broker,
      'quantity': instance.quantity,
      'tradingSymbol': instance.tradingSymbol,
      'companyName': instance.companyName,
      'transactionType': instance.transactionType,
      'filledQuantity': instance.filledQuantity,
      'averagePrice': instance.averagePrice,
      'statusMessage': instance.statusMessage,
      'txnCompletedDateTime': instance.txnCompletedDateTime?.toIso8601String(),
    };

TransactionsByDate _$TransactionsByDateFromJson(Map<String, dynamic> json) =>
    TransactionsByDate(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      netWeightedAveragePrice:
          (json['netWeightedAveragePrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransactionsByDateToJson(TransactionsByDate instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'netWeightedAveragePrice': instance.netWeightedAveragePrice,
    };
