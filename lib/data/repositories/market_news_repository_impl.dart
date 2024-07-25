import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/market_news_repository.dart';
import '../data_sources/remote/market_news_remote_data_source.dart';
import '../models/market_news/news_details.dart';

@LazySingleton(as: MarketNewsRepository)
class MarketNewsRepositoryImpl implements MarketNewsRepository{
  final MarketNewsRemoteDataSource _marketNewsRemoteDataSource;
  MarketNewsRepositoryImpl(this._marketNewsRemoteDataSource);
  @override

  Future<Either<AppError,NewsDetails>>getMarketNews(params)async{
    return ApiCallWithError.call(() => _marketNewsRemoteDataSource.getMarketNews(params));
  }
}