import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/installment_dto.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_sip_installment_params.dart';
import '../../../../domain/entities/params/mutual_funds/get_stp_installment_params.dart';
import '../../../../domain/entities/params/mutual_funds/get_swp_installment_params.dart';
import '../../../../domain/usecases/mutual_funds/get_sip_installments.dart';
import '../../../../domain/usecases/mutual_funds/get_stp_installments.dart';
import '../../../../domain/usecases/mutual_funds/get_swp_installments.dart';

part 'systematic_plan_installments_state.dart';

@injectable
class SystematicPlanInstallmentsCubit extends Cubit<SystematicPlanInstallmentsState> {
  final GetSipInstallments _getSipInstallments;
  final GetStpInstallments _getStpInstallments;
  final GetSwpInstallments _getSwpInstallments;

  SystematicPlanInstallmentsCubit(this._getSipInstallments, this._getStpInstallments, this._getSwpInstallments) : super(SipInstallmentsInitial());

  void fetchSipInstallments({required int userId, required int sipId}) async {
    emit(SystematicPlanInstallmentsLoading());
    final result = await _getSipInstallments(
      GetSipInstallmentParams(userId: userId, sipId: sipId),
    );
    emit(result.fold(
      (l) => SystematicPlanInstallmentsError(l.errorType, l.error),
      (r) => SystematicPlanInstallmentsLoaded(r),
    ));
  }

  void fetchSwpInstallments({required int userId, required String swpId}) async {
    emit(SystematicPlanInstallmentsLoading());
    final result = await _getSwpInstallments(
      GetSwpInstallmentParams(userId: userId, swpId: swpId),
    );
    emit(result.fold(
      (l) => SystematicPlanInstallmentsError(l.errorType, l.error),
      (r) => SystematicPlanInstallmentsLoaded(r),
    ));
  }

  void fetchStpInstallments({required int userId, required String stpId}) async {
    emit(SystematicPlanInstallmentsLoading());
    final result = await _getStpInstallments(
      GetStpInstallmentParams(userId: userId, stpId: stpId),
    );
    emit(result.fold(
      (l) => SystematicPlanInstallmentsError(l.errorType, l.error),
      (r) => SystematicPlanInstallmentsLoaded(r),
    ));
  }
}
