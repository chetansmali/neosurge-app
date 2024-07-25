import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/create_kyc_request_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/create_kyc_request.dart';
import '../../../../domain/usecases/kyc/get_kyc_video_otp.dart';
import '../../util_cubits/loading_cubit.dart';

part 'get_kyc_video_otp_state.dart';

@injectable
class GetKycVideoOtpCubit extends Cubit<GetKycVideoOtpState> {
  final GetKycVideoOtp _getKycVideoOtp;
  final CreateKycRequest _createKycRequest;

  GetKycVideoOtpCubit(this._getKycVideoOtp, this._createKycRequest) : super(GetKycVideoOtpInitial());

  void getKycVideoOtp({required double lat, required double long}) async {
    getIt<LoadingCubit>().show();
    emit(GetKycVideoOtpLoading());
    final createKycResponse = await _createKycRequest(CreateKycRequestParams(isFinalSubmit: false, latitude: lat, longitude: long));

    createKycResponse.fold((l) => emit(GetKycVideoOtpFailure(errorType: l.errorType, errorMessage: l.error)), (r) async {
      final response = await _getKycVideoOtp(NoParams());
      response.fold((l) => emit(GetKycVideoOtpFailure(errorType: l.errorType, errorMessage: l.error)), (r) => emit(GetKycVideoOtpLoaded(otp: r.otp)));
    });
    getIt<LoadingCubit>().hide();
  }
}
