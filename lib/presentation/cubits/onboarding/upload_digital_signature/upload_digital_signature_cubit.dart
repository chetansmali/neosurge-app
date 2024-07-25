import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_digital_signature_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_digital_signature.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_digital_signature_state.dart';

@injectable
class UploadDigitalSignatureCubit extends Cubit<UploadDigitalSignatureState> {
  final UploadDigitalSignature _uploadDigitalSignature;
  final GetKycData _getKycData;

  UploadDigitalSignatureCubit(this._uploadDigitalSignature, this._getKycData) : super(UploadDigitalSignatureInitial());

  void fetchSignature() async {
    emit(const UploadDigitalSignatureLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    res.fold((l) => emit(UploadDigitalSignatureFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error)), (r) async {
      final response = await Utils.fileFromUrl(r.userKycFilesData!.userSignaturePublicUrl!);
      response.fold((l) => emit(UploadDigitalSignatureFailure(errorType: l.errorType, errorMessage: l.error, isFetch: true)),
          (r) async => emit(UploadDigitalSignatureSuccess(isFetch: true, signature: r, signatureBytes: await r.readAsBytes())));
    });
  }

  void uploadSignature(Uint8List signFileBytes) async {
    getIt<LoadingCubit>().show();
    emit(const UploadDigitalSignatureLoading());

    final response = await _uploadDigitalSignature(UploadDigitalSignatureParams(imageFileBytes: signFileBytes));
    emit(response.fold((l) => UploadDigitalSignatureFailure(errorType: l.errorType, errorMessage: l.error), (r) => const UploadDigitalSignatureSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
