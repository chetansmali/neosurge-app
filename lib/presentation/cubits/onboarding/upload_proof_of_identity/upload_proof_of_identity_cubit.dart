import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_proof_of_identity_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_proof_of_identity.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_proof_of_identity_state.dart';

@injectable
class UploadProofOfIdentityCubit extends Cubit<UploadProofOfIdentityState> {
  final UploadProofOfIdentity _uploadProofOfIdentity;
  final GetKycData _getKycData;

  UploadProofOfIdentityCubit(this._uploadProofOfIdentity, this._getKycData)
      : super(UploadProofOfIdentityInitial());

  void fetchProofOfIdentity() async {
    emit(const UploadProofOfIdentityLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    res.fold(
        (l) => emit(UploadProofOfIdentityFailure(
            errorType: l.errorType,
            isFetch: true,
            errorMessage: l.error)), (r) async {
      final response =
          await Utils.fileFromUrl(r.userKycFilesData!.panPublicUrl!);
      emit(response.fold(
          (l) => UploadProofOfIdentityFailure(
              errorType: l.errorType, errorMessage: l.error),
          (r) => UploadProofOfIdentitySuccess(panImage: r, isFetch: true)));
    });
  }

  void uploadProofOfIdentity({required File panImage}) async {
    getIt<LoadingCubit>().show();
    emit(const UploadProofOfIdentityLoading());
    Uint8List imageBytes = await panImage.readAsBytes();
    final response = await _uploadProofOfIdentity(
        UploadProofOfIdentityParams(panImageBytes: imageBytes));
    emit(response.fold(
        (l) => UploadProofOfIdentityFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => const UploadProofOfIdentitySuccess()));
    getIt<LoadingCubit>().hide();
  }
}
