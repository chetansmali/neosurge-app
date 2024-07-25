part of 'basket_chart_cubit.dart';

abstract class BasketChartState extends Equatable {
  const BasketChartState();
}

class BasketChartInitial extends BasketChartState {
  @override
  List<Object> get props => [];
}

class BasketChartLoading extends BasketChartState {
  @override
  List<Object> get props => [];
}

class BasketChartSuccess extends BasketChartState {
  final BasketChartResponse basketChartResponse;

  const BasketChartSuccess(
    this.basketChartResponse,
  );

  @override
  List<Object> get props => [
        basketChartResponse,
      ];
}

class BasketChartFailure extends BasketChartState {
  final AppErrorType appErrorType;
  final String? message;

  const BasketChartFailure(this.appErrorType, this.message);

  @override
  List<Object> get props => [
        appErrorType,
      ];
}
