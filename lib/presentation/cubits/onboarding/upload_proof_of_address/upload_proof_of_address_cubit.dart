import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_proof_of_address_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_proof_of_address.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_proof_of_address_state.dart';

@injectable
class UploadProofOfAddressCubit extends Cubit<UploadProofOfAddressState> {
  final UploadProofOfAddress _uploadProofOfAddress;
  final GetKycData _getKycData;

  UploadProofOfAddressCubit(this._uploadProofOfAddress, this._getKycData)
      : super(UploadProofOfAddressInitial());

  void fetchProofOfAddress() async {
    emit(const UploadProofOfAddressLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    res.fold(
        (l) => emit(UploadProofOfAddressFailure(
            errorType: l.errorType,
            isFetch: true,
            errorMessage: l.error)), (r) async {
      late final File kycFrontFile;
      late final File kycBackFile;

      final response = await Utils.fileFromUrl(
          r.userKycFilesData!.addressProofFrontPublicUrl!);
      response.fold(
          (l) => emit(UploadProofOfAddressFailure(
              errorType: l.errorType, errorMessage: l.error)),
          (r) => kycFrontFile = r);
      final response2 = await Utils.fileFromUrl(
          r.userKycFilesData!.addressProofBackPublicUrl!);
      response2.fold(
          (l) => emit(UploadProofOfAddressFailure(
              errorType: l.errorType, errorMessage: l.error)),
          (r) => kycBackFile = r);
      emit(UploadProofOfAddressSuccess(
          isFetch: true,
          uploadProofOfAddressParams: UploadProofOfAddressParams(
              proofTypeId: r.adressProofType!.value,
              proofNumber: r.addressProofNum!,
              proofFrontImage: kycFrontFile,
              proofBackImage: kycBackFile,
              proofExpiryDate: r.addressProofExpiryDate,
              proofIssueDate: r.addressProofIssueDate)));
    });
  }

  void uploadProofOfAddress(
      {required File frontImage,
      required File backImage,
      required int proofTypeId,
      required String proofNumber,
      String? proofIssueDate,
      String? proofExpiryDate}) async {
    getIt<LoadingCubit>().show();
    emit(const UploadProofOfAddressLoading());

    final response = await _uploadProofOfAddress(UploadProofOfAddressParams(
        proofTypeId: proofTypeId,
        proofNumber: proofNumber,
        proofIssueDate: proofIssueDate,
        proofExpiryDate: proofExpiryDate,
        proofFrontImage: frontImage,
        proofBackImage: backImage));
    emit(response.fold(
        (l) => UploadProofOfAddressFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => const UploadProofOfAddressSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
