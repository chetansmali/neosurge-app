import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/market_news/news_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/market_news/fetch_market_news_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/market_news_repository.dart';


@injectable
class GetMarketNews extends UseCase<NewsDetails,FetchMarketNewsParams>{
  final MarketNewsRepository _marketNewsRepository;
  GetMarketNews(this._marketNewsRepository);

  @override
  Future<Either<AppError,NewsDetails>>call(params)=>_marketNewsRepository.getMarketNews(params.toJson());
}