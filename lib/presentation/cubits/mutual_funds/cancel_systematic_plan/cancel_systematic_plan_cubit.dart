import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/stop_sip_params.dart';
import '../../../../domain/entities/params/mutual_funds/stop_stp_params.dart';
import '../../../../domain/entities/params/mutual_funds/stop_swp_params.dart';
import '../../../../domain/usecases/mutual_funds/stop_sip_order.dart';
import '../../../../domain/usecases/mutual_funds/stop_stp_order.dart';
import '../../../../domain/usecases/mutual_funds/stop_swp_order.dart';
import '../../util_cubits/loading_cubit.dart';

part 'cancel_systematic_plan_state.dart';

@injectable
class CancelSystematicPlanCubit extends Cubit<CancelSystematicPlanState> {
  final StopSipOrder _stopSipOrder;
  final StopStpOrder _stopStpOrder;
  final StopSwpOrder _stopSwpOrder;
  final LoadingCubit _loadingCubit;

  CancelSystematicPlanCubit(
    this._stopSipOrder,
    this._stopStpOrder,
    this._stopSwpOrder,
    this._loadingCubit,
  ) : super(CancelSystematicPlanInital());

  void cancelSip({required int userId, required int sipId}) async {
    emit(CancelSystematicPlanLoading());
    _loadingCubit.show();
    final res = await _stopSipOrder(StopSipParams(userId: userId, sipId: sipId));
    emit(res.fold((l) => CancelSystematicPlanError(errorType: l.errorType, errorMessage: l.error), (r) => CancelSystematicPlanSuccess()));
    _loadingCubit.hide();
  }

  void cancelStp({required int userId, required int stpId}) async {
    emit(CancelSystematicPlanLoading());
    _loadingCubit.show();
    final res = await _stopStpOrder(StopStpParams(userId: userId, stpId: stpId));
    emit(res.fold((l) => CancelSystematicPlanError(errorType: l.errorType, errorMessage: l.error), (r) => CancelSystematicPlanSuccess()));
    _loadingCubit.hide();
  }

  void cancelSwp({required int userId, required int swpId}) async {
    emit(CancelSystematicPlanLoading());
    _loadingCubit.show();
    final res = await _stopSwpOrder(StopSwpParams(userId: userId, swpId: swpId));
    emit(res.fold((l) => CancelSystematicPlanError(errorType: l.errorType, errorMessage: l.error), (r) => CancelSystematicPlanSuccess()));
    _loadingCubit.hide();
  }
}
