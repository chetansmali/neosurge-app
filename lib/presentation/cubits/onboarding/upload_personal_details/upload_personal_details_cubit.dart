import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_kyc_personal_details_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_personal_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_personal_details.dart';
import '../../../../domain/usecases/kyc/upload_personal_details.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_personal_details_state.dart';

@injectable
class UploadPersonalDetailsCubit extends Cubit<UploadPersonalDetailsState> {
  final UploadPersonalDetails _uploadPersonalDetails;
  final GetKycPersonalDetails _getKycPersonalDetails;

  UploadPersonalDetailsCubit(
      this._uploadPersonalDetails, this._getKycPersonalDetails)
      : super(UploadPersonalDetailsInitial());

  void fetchPersonalDetails() async {
    emit(const UploadPersonalDetailsLoading(isFetch: true));
    final res = await _getKycPersonalDetails(NoParams());
    emit(res.fold(
        (l) => UploadPersonalDetailsFailure(
            errorType: l.errorType, errorMessage: l.error, isFetch: true),
        (r) => UploadPersonalDetailsSuccess(
            getKycPersonalDetailsModel: r, isFetch: true)));
  }

  void uploadPersonalDetails(
      UploadPersonalDetailsParams uploadPersonalDetailsParams) async {
    getIt<LoadingCubit>().show();
    final response = await _uploadPersonalDetails(uploadPersonalDetailsParams);
    emit(response.fold(
        (l) => UploadPersonalDetailsFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => const UploadPersonalDetailsSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
