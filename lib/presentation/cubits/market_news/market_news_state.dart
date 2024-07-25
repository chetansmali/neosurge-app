part of 'market_news_cubit.dart';

abstract class MarketNewsState extends Equatable {
  const MarketNewsState();
}

class MarketNewsInitial extends MarketNewsState {
  @override
  List<Object> get props => [];
}

class MarketNewsLoading extends MarketNewsState {
  @override
  List<Object> get props => [];
}

class MarketNewsFailure extends MarketNewsState {
  final String? errorMessage;
  final AppErrorType errorType;
  const MarketNewsFailure(this.errorType, this.errorMessage);
  @override
  List<Object?> get props => [errorMessage, errorType];
}

class MarketNewsSuccess extends MarketNewsState {
  final NewsDetails newsDetails;
  const MarketNewsSuccess(this.newsDetails);
  @override
  List<Object> get props => [];
}
