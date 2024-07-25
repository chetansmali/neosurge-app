import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/checkout_rates_model.dart';
import '../../../../data/models/digital_gold/create_order_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/create_order_params.dart';
import '../../../../domain/usecases/digital_gold/create_order.dart';

part 'create_order_state.dart';

@injectable
class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrder _createOrder;

  CreateOrderCubit(this._createOrder) : super(CreateOrderInitial());

  void createOrder(CheckoutRatesModel checkoutRatesModel) async {
    emit(CreateOrderLoading());
    final response = await _createOrder(CreateOrderParams(
        metalType: checkoutRatesModel.metalType,
        amount: checkoutRatesModel.totalAmount,
        blockId: checkoutRatesModel.goldSilverRate.blockId,
        lockPrice: checkoutRatesModel.lockPrice,
        transactionType: checkoutRatesModel.transactionType,
        metalWeight: checkoutRatesModel.metalWeight));
    emit(response.fold((l) => CreateOrderLoadError(errorType: l.errorType, errorMessage: l.error), (r) => CreateOrderLoaded(createOrderResponseModel: r)));
  }
}
