import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/create_order_response_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/create_delivery_order_params.dart';
import '../../../../domain/usecases/digital_gold/create_delivery_order.dart';

part 'create_delivery_order_state.dart';

@injectable
class CreateDeliveryOrderCubit extends Cubit<CreateDeliveryOrderState> {
  final CreateDeliveryOrder _createDeliveryOrder;

  CreateDeliveryOrderCubit(this._createDeliveryOrder) : super(CreateDeliveryOrderInitial());

  void createDeliveryOrder(CreateDeliveryOrderParams dA) async {
    emit(CreateDeliveryOrderLoading());
    final response = await _createDeliveryOrder(dA);
    emit(response.fold((l) => CreateDeliveryOrderFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => CreateDeliveryOrderSuccess(orderResponse: r)));
  }
}
