import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_selfie_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_selfie.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_selfie_state.dart';

@injectable
class UploadSelfieCubit extends Cubit<UploadSelfieState> {
  final UploadSelfie _uploadSelfie;
  final GetKycData _getKycData;

  UploadSelfieCubit(this._uploadSelfie, this._getKycData) : super(UploadSelfieInitial());

  void fetchSelfie() async {
    emit(const UploadSelfieLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    res.fold((l) => emit(UploadSelfieFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error)), (r) async {
      final response = await Utils.fileFromUrl(r.userKycFilesData!.userImagePublicUrl!);
      emit(response.fold((l) => UploadSelfieFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error), (r) => UploadSelfieSuccess(selfie: r, isFetch: true)));
    });
  }

  void uploadSelfie(File selfie) async {
    getIt<LoadingCubit>().show();
    emit(const UploadSelfieLoading());
    final result = await _uploadSelfie(UploadSelfieParams(selfieImage: selfie));
    emit(result.fold((l) => UploadSelfieFailure(errorType: l.errorType, errorMessage: l.error), (r) => const UploadSelfieSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
