import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_portfolio.dart';

part 'basket_portfolio_state.dart';

@injectable
class BasketPortfolioCubit extends Cubit<BasketPortfolioState> {
  final GetBasketPortfolio _getBasketPortfolio;

  BasketPortfolioCubit(
    this._getBasketPortfolio,
  ) : super(BasketPortfolioInitial());

  void getBasketPortfolio() async {
    emit(BasketPortfolioLoading());
    final response = await _getBasketPortfolio(NoParams());
    response.fold(
      (l) => emit(BasketPortfolioError(
        errorType: l.errorType,
        errorMessage: l.error,
      )),
      (r) => emit(BasketPortfolioLoaded(r)),
    );
  }
}
