import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_order_transaction.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_transaction_detail_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_order_transaction_details.dart';

part 'basket_order_details_state.dart';

@injectable
class BasketOrderDetailsCubit extends Cubit<BasketOrderDetailsState> {
  final GetBasketOrderTransactionDetails _getBasketOrderTransactionDetails;
  BasketOrderDetailsCubit(
    this._getBasketOrderTransactionDetails,
  ) : super(BasketOrderDetailsInitial());

  void getBasketOrderTransactionDetails(
    BasketTransactionDetailParams basketTransactionDetailParams,
  ) async {
    if (state is BasketOrderDetailsLoading) return;

    emit(BasketOrderDetailsLoading());

    final response = await _getBasketOrderTransactionDetails(
      basketTransactionDetailParams,
    );

    emit(
      response.fold(
        (l) => BasketOrderDetailsError(
          appErrorType: l.errorType,
          message: l.error,
        ),
        (r) => BasketOrderDetailsLoaded(
          basketOrderTransactionDetail: r,
        ),
      ),
    );
  }
}
