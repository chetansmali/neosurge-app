import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_kyc_data_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/confirm_pan_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/confirm_pan.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../util_cubits/loading_cubit.dart';

part 'confirm_pan_state.dart';

@injectable
class ConfirmPanCubit extends Cubit<ConfirmPanState> {
  final ConfirmPan _confirmPan;
  final GetKycData _getKycData;
  final LoadingCubit _loadingCubit;

  ConfirmPanCubit(this._confirmPan, this._getKycData, this._loadingCubit) : super(ConfirmPanInitial());

  void fetchPanData() async {
    emit(const ConfirmPanLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    emit(res.fold((l) => ConfirmPanFailure(errorType: l.errorType, errorMessage: l.error, isFetch: true), (r) => ConfirmPanSuccess(isFetch: true, kycData: r)));
  }

  void confirmPan({required String panNumber, required String fullName, required String dateOfBirth, required bool isCompliant}) async {
    _loadingCubit.show();
    emit(const ConfirmPanLoading());
    final response = await _confirmPan(ConfirmPanParams(panNumber: panNumber, fullName: fullName, dateOfBirth: dateOfBirth, isCompliant: isCompliant));
    emit(response.fold((l) => ConfirmPanFailure(errorType: l.errorType, errorMessage: l.error), (r) => const ConfirmPanSuccess()));
    _loadingCubit.hide();
  }
}
