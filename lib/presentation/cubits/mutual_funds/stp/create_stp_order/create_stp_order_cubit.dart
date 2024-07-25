import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/mutual_funds/stp/stp_order_response.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/mutual_funds/create_stp_order_params.dart';
import '../../../../../domain/usecases/mutual_funds/create_stp_order.dart';

part 'create_stp_order_state.dart';

@injectable
class CreateStpOrderCubit extends Cubit<CreateStpOrderState> {
  final CreateStpOrder _createStpOrder;

  CreateStpOrderCubit(
    this._createStpOrder,
  ) : super(CreateStpOrderInitial());

  void createStpOrder(CreateStpOrderParams createStpOrderParams) async {
    if (state is CreateStpOrderLoading) return;

    emit(CreateStpOrderLoading());
    final res = await _createStpOrder(createStpOrderParams);
    if (isClosed) return;
    emit(
      res.fold(
        (l) => CreateStpOrderFailure(l.error, l.errorType),
        (r) => CreateStpOrderSuccess(r),
      ),
    );
  }
}
