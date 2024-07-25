import 'package:dartz/dartz.dart';

import '../../data/models/market_news/news_details.dart';
import '../entities/app_error.dart';

abstract class MarketNewsRepository{

  Future<Either<AppError,NewsDetails>> getMarketNews(Map<String,dynamic>params);

}