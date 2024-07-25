import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/retake_kyc.dart';
import '../../util_cubits/loading_cubit.dart';

part 'retake_kyc_state.dart';

@injectable
class RetakeKycCubit extends Cubit<RetakeKycState> {
  final RetakeKyc _retakeKyc;
  final LoadingCubit _loadingCubit;

  RetakeKycCubit(this._retakeKyc, this._loadingCubit) : super(RetakeKycInitial());

  void retakeKyc() async {
    _loadingCubit.show();
    emit(RetakeKycLoading());
    final result = await _retakeKyc(NoParams());
    result.fold((l) => emit(RetakeKycError(error: l.error, errorType: l.errorType)), (r) => emit(RetakeKycSuccess()));
    _loadingCubit.hide();
  }
}
