import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/sip/sip_order_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/create_sip_order_params.dart';
import '../../../../domain/usecases/mutual_funds/create_sip_order.dart';
import '../../util_cubits/loading_cubit.dart';

part 'sip_order_state.dart';

@injectable
class SipOrderCubit extends Cubit<SipOrderState> {
  final CreateSipOrder _createSipOrder;
  final LoadingCubit _loadingCubit;

  SipOrderCubit(this._createSipOrder, this._loadingCubit) : super(SipOrderInitial());

  void createSipOrder(CreateSipOrderParams createSipOrderParams) async {
    emit(SipOrderLoading());
    _loadingCubit.show();
    final response = await _createSipOrder(createSipOrderParams);
    emit(response.fold((l) {
      if (l.error != null && l.error!.contains('User Mandate Account not created')) {
        return SipNoMandateError();
      }
      return SipOrderLoadError(l.errorType, l.error);
    }, (r) => SipOrderLoaded(r)));
    _loadingCubit.hide();
  }
}
