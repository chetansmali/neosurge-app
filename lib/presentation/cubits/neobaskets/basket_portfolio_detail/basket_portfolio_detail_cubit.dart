import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_portfolio_detail_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_portfolio_detail.dart';

part 'basket_portfolio_detail_state.dart';

@injectable
class BasketPortfolioDetailCubit extends Cubit<BasketPortfolioDetailState> {
  final GetBasketPortfolioDetail _getBasketPortfolioDetail;

  BasketPortfolioDetailCubit(
    this._getBasketPortfolioDetail,
  ) : super(BasketPortfolioDetailInitial());

  void getBasketPortfolioDetail(BasketPortfolioDetailParams params) async {
    emit(BasketPortfolioDetailLoading());

    final response = await _getBasketPortfolioDetail(
      params,
    );

    response.fold(
      (l) => emit(
        BasketPortfolioDetailError(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(
        BasketPortfolioDetailLoaded(
          basketPortfolioDetailResponse: r,
        ),
      ),
    );
  }
}
