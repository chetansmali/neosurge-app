import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/mutual_funds/switch/switch_order_response.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/mutual_funds/create_switch_order_params.dart';
import '../../../../../domain/usecases/mutual_funds/create_switch_order.dart';

part 'create_switch_order_state.dart';

@injectable
class CreateSwitchOrderCubit extends Cubit<CreateSwitchOrderState> {
  final CreateSwitchOrder _createSwitchOrder;

  CreateSwitchOrderCubit(this._createSwitchOrder)
      : super(CreateSwitchOrderInitial());

  void createSwitchOrder(CreateSwitchOrderParams switchOrderParams) async {
    if (state is CreateSwitchOrderLoading) return;

    emit(CreateSwitchOrderLoading());
    final res = await _createSwitchOrder(switchOrderParams);
    emit(
      res.fold(
        (l) => CreateSwitchOrderFailure(l.errorType, l.error),
        (r) => CreateSwitchOrderSuccess(r),
      ),
    );
  }
}
