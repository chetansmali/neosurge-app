import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_kyc_video_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_kyc_video.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_kyc_video_state.dart';

@injectable
class UploadKycVideoCubit extends Cubit<UploadKycVideoState> {
  final UploadKycVideo _uploadKycVideo;
  final GetKycData _getKycData;

  UploadKycVideoCubit(this._uploadKycVideo, this._getKycData) : super(UploadKycVideoInitial());

  void fetchVideo() async {
    emit(const UploadKycVideoLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    res.fold((l) => emit(UploadKycVideoFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error)), (r) async {
      final response = await Utils.fileFromUrl(r.userKycFilesData!.videoPublicUrl!);
      emit(response.fold((l) => UploadKycVideoFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error), (r) => UploadKycVideoSuccess(isFetch: true, kycVideoFile: r)));
    });
  }

  void uploadVideo({required File videoFile}) async {
    getIt<LoadingCubit>().show();
    emit(const UploadKycVideoLoading());
    final videoBytes = await videoFile.readAsBytes();
    final response = await _uploadKycVideo(UploadKycVideoParams(kycVideoBytes: videoBytes));
    emit(response.fold((l) => UploadKycVideoFailure(errorType: l.errorType, errorMessage: l.error), (r) => const UploadKycVideoSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
