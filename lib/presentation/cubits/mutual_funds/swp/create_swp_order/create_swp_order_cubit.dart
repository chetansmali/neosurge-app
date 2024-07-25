import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/mutual_funds/swp/swp_order_response.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/mutual_funds/create_swp_order_params.dart';
import '../../../../../domain/usecases/mutual_funds/create_swp_order.dart';
import '../../../util_cubits/loading_cubit.dart';

part 'create_swp_order_state.dart';

@injectable
class CreateSwpOrderCubit extends Cubit<CreateSwpOrderState> {
  final CreateSwpOrder _createSwpOrder;

  CreateSwpOrderCubit(
    this._createSwpOrder,
  ) : super(CreateSwpOrderInitial());

  void createSwpOrder(CreateSwpOrderParams createSwpOrderParams) async {
    if (state is CreateSwpOrderLoading) return;

    emit(CreateSwpOrderLoading());
    final res = await _createSwpOrder(createSwpOrderParams);
    emit(res.fold((l) => CreateSwpOrderFailure(l.error, l.errorType),
        (r) => CreateSwpOrderSuccess(r)));
  }
}
