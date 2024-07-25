import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/delivery_product_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/get_delivery_product_params.dart';
import '../../../../domain/usecases/digital_gold/get_delivery_products.dart';

part 'delivery_product_state.dart';

@injectable
class DeliveryProductCubit extends Cubit<DeliveryProductState> {
  final GetDeliveryProducts _getDeliveryProducts;

  DeliveryProductCubit(this._getDeliveryProducts) : super(DeliveryProductInitial());

  void getDeliveryProducts(MetalType metalType) async {
    emit(DeliveryProductLoading());
    final response = await _getDeliveryProducts(GetDeliveryProductParams(metalType: metalType));
    emit(response.fold((l) => DeliveryProductError(appErrorType: l.errorType, errorMessage: l.error), (r) => DeliveryProductLoaded(deliveryProducts: r)));
  }
}
