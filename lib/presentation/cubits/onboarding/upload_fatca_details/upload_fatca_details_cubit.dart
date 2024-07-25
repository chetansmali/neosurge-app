import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_kyc_fatca_details_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_fatca_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_fatca_details.dart';
import '../../../../domain/usecases/kyc/upload_fatca_details.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_fatca_details_state.dart';

@injectable
class UploadFatcaDetailsCubit extends Cubit<UploadFatcaDetailsState> {
  final UploadFatcaDetails _uploadFatcaDetails;
  final GetKycFatcaDetails _getKycFatcaDetails;

  UploadFatcaDetailsCubit(this._uploadFatcaDetails, this._getKycFatcaDetails) : super(UploadFatcaDetailsInitial());

  void fetchFatcaDetails() async {
    emit(const UploadFatcaDetailsLoading(isFetch: true));
    final result = await _getKycFatcaDetails(NoParams());
    emit(result.fold((l) => UploadFatcaDetailsFailure(appErrorType: l.errorType, isFetch: true, errorMessage: l.error), (r) => UploadFatcaDetailsSuccess(isFetch: true, fatcaDetails: r)));
  }

  void uploadFatcaDetails(UploadFatcaDetailsParams params) async {
    getIt<LoadingCubit>().show();
    emit(const UploadFatcaDetailsLoading());
    final response = await _uploadFatcaDetails(params);
    emit(response.fold((l) => UploadFatcaDetailsFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => const UploadFatcaDetailsSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
