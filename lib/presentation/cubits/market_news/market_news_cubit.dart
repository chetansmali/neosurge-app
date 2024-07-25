import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/market_news/news_details.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/market_news/fetch_market_news_params.dart';
import '../../../domain/usecases/market_news/get_market_news.dart';

part 'market_news_state.dart';

@injectable
class MarketNewsCubit extends Cubit<MarketNewsState> {
  final GetMarketNews _getMarketNews;
  MarketNewsCubit(this._getMarketNews) : super(MarketNewsInitial());
  void fetchMarketNews(String date) async {
    emit(MarketNewsLoading());
    final response = await _getMarketNews(FetchMarketNewsParams(date: date));
    emit(response.fold((l) => MarketNewsFailure(l.errorType, l.error),
        (r) => MarketNewsSuccess(r)));
  }
}
