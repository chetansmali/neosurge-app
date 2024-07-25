part of 'index_price_banner_cubit.dart';

abstract class IndexPriceBannerState extends Equatable {
  const IndexPriceBannerState();
}

class IndexPriceBannerInitial extends IndexPriceBannerState {
  @override
  List<Object> get props => [];
}

class IndexPriceBannerLoading extends IndexPriceBannerState {
  @override
  List<Object> get props => [];
}

class IndexPriceBannerLoaded extends IndexPriceBannerState {
  final List<IndexPriceModel> indexPriceModel;

  const IndexPriceBannerLoaded(this.indexPriceModel);

  @override
  List<Object> get props => [];
}

class IndexPriceBannerFailure extends IndexPriceBannerState {
  final String? errorMessage;
  final AppErrorType errorType;

  const IndexPriceBannerFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
