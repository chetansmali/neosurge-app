part of 'basket_details_cubit.dart';

abstract class BasketDetailsState extends Equatable {
  const BasketDetailsState();
}

class BasketDetailsInitial extends BasketDetailsState {
  @override
  List<Object> get props => [];
}

class BasketDetailsLoading extends BasketDetailsState {
  @override
  List<Object> get props => [];
}

class BasketDetailsSuccess extends BasketDetailsState {
  final BasketDetailsModel basketDetailsModel;
  const BasketDetailsSuccess(this.basketDetailsModel);

  @override
  List<Object> get props => [];
}

class BasketDetailsFailure extends BasketDetailsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const BasketDetailsFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
