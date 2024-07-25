import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_kyc_bank_details_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_bank_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_bank_details.dart';
import '../../../../domain/usecases/kyc/upload_bank_details.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_bank_details_state.dart';

@injectable
class UploadBankDetailsCubit extends Cubit<UploadBankDetailsState> {
  final UploadBankDetails _uploadBankDetails;
  final GetKycBankDetails _getKycBankDetails;

  UploadBankDetailsCubit(
    this._uploadBankDetails,
    this._getKycBankDetails,
  ) : super(UploadBankDetailsInitial());

  void fetchBankDetails() async {
    emit(const UploadBankDetailsLoading(isFetch: true));
    final response = await _getKycBankDetails(NoParams());
    emit(response.fold((l) => UploadBankDetailsFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error), (r) => UploadBankDetailsSuccess(isFetch: true, bankDetails: r)));
  }

  void uploadBankDetails({required UploadBankDetailsParams bankDetailsParams}) async {
    getIt<LoadingCubit>().show();
    emit(const UploadBankDetailsLoading());
    final response = await _uploadBankDetails(bankDetailsParams);
    emit(response.fold((l) => UploadBankDetailsFailure(errorType: l.errorType, errorMessage: l.error), (r) => const UploadBankDetailsSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
