import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/market_news/news_details.dart';

abstract class MarketNewsRemoteDataSource {
  Future<NewsDetails> getMarketNews(Map<String, dynamic> params);
}

@LazySingleton(as: MarketNewsRemoteDataSource)
class MarketNewsRemoteDataSourceImpl implements MarketNewsRemoteDataSource {
  final ApiClient _client;
  MarketNewsRemoteDataSourceImpl(this._client);

  @override
  Future<NewsDetails> getMarketNews(Map<String, dynamic> queryparams) async {
    final response = await _client.get(
      ApiConstants.fetchMarketNews,
      queryParameters: queryparams,
      extractData: false,
    );

    return NewsDetails.fromJson(response);
  }
}
