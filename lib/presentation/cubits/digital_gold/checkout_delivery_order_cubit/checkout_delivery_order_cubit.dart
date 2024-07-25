import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/checkout_delivery_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/checkout_delivery_order_params.dart';
import '../../../../domain/usecases/digital_gold/checkout_delivery_order.dart';

part 'checkout_delivery_order_state.dart';

@injectable
class CheckoutDeliveryOrderCubit extends Cubit<CheckoutDeliveryOrderState> {
  final CheckoutDeliveryOrder _checkoutDeliveryOrder;

  CheckoutDeliveryOrderCubit(this._checkoutDeliveryOrder) : super(CheckoutDeliveryOrderInitial());

  void checkOutDeliveryOrder(CheckoutDeliveryOrderParams checkOutParams) async {
    emit(CheckoutDeliveryOrderLoading());
    final response = await _checkoutDeliveryOrder(checkOutParams);
    emit(response.fold((l) => CheckoutDeliveryOrderFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => CheckoutDeliveryOrderSuccess(r)));
  }
}
