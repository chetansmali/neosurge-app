import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_kyc_addresss_details_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_address_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_address_details.dart';
import '../../../../domain/usecases/kyc/upload_address_details.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_address_details_state.dart';

@injectable
class UploadAddressDetailsCubit extends Cubit<UploadAddressDetailsState> {
  final UploadAddressDetails _uploadAddressDetails;
  final GetKycAddressDetails _getKycAddressDetails;

  UploadAddressDetailsCubit(
      this._uploadAddressDetails, this._getKycAddressDetails)
      : super(UploadAddressDetailsInitial());

  void fetchAddressDetails() async {
    emit(const UploadAddressDetailsLoading(isFetch: true));
    final result = await _getKycAddressDetails(NoParams());
    emit(result.fold(
        (l) => UploadAddressDetailsFailure(
            errorType: l.errorType, isFetch: true, errorMessage: l.error),
        (r) =>
            UploadAddressDetailsSuccess(isFetch: true, kycAddressDetails: r)));
  }

  void uploadAddressDetails(
      UploadAddressDetailsParams uploadAddressDetailsParams) async {
    getIt<LoadingCubit>().show();
    emit(const UploadAddressDetailsLoading());
    final response = await _uploadAddressDetails(uploadAddressDetailsParams);
    emit(
      response.fold(
        (l) => UploadAddressDetailsFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => const UploadAddressDetailsSuccess(),
      ),
    );
    getIt<LoadingCubit>().hide();
  }
}
