import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_adhaar_number_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_adhaar_number.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_adhaar_number_state.dart';

@injectable
class UploadAadhaarNumberCubit extends Cubit<UploadAadhaarNumberState> {
  final UploadAdhaarNumber _uploadAadhaarNumber;
  final GetKycData _getKycData;

  UploadAadhaarNumberCubit(this._uploadAadhaarNumber, this._getKycData) : super(UploadAadhaarNumberInitial());

  void fetchAadhaarNumber() async {
    emit(const UploadAadhaarNumberLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    emit(res.fold((l) => UploadAadhaarNumberFailure(errorType: l.errorType, errorMessage: l.error, isFetch: true), (r) => UploadAadhaarNumberSuccess(adhaarNumber: r.aadhaarNum, isFetch: true)));
  }

  void uploadAadhaarNumber({required String aadhaarNumber}) async {
    getIt<LoadingCubit>().show();
    emit(const UploadAadhaarNumberLoading());
    final response = await _uploadAadhaarNumber(UploadAadhaarNumberParams(adhaarNum: aadhaarNumber));
    emit(response.fold((l) => UploadAadhaarNumberFailure(errorType: l.errorType, errorMessage: l.error), (r) => const UploadAadhaarNumberSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
