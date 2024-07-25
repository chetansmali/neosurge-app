import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/upload_cancelled_cheque_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/get_kyc_data.dart';
import '../../../../domain/usecases/kyc/upload_cancelled_cheque.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_cheque_state.dart';

@injectable
class UploadCancelledChequeCubit extends Cubit<UploadCancelledChequeState> {
  final UploadCancelledCheque _uploadCancelledCheque;
  final GetKycData _getKycData;

  UploadCancelledChequeCubit(this._uploadCancelledCheque, this._getKycData) : super(UploadCancelledChequeInitial());

  void fetchCheque() async {
    emit(const UploadCancelledChequeLoading(isFetch: true));
    final res = await _getKycData(NoParams());
    (res.fold((l) => emit(UploadCancelledChequeFailure(errorType: l.errorType, isFetch: true, errorMessage: l.error)), (r) async {
      final response = await Utils.fileFromUrl(r.userKycFilesData!.cancelledChequePublicUrl!);
      emit(response.fold((l) => UploadCancelledChequeFailure(errorType: l.errorType, errorMessage: l.error), (r) => UploadCancelledChequeSuccess(isFetch: true, chequeImage: r)));
    }));
  }

  void uploadCheque({required File chequeImage}) async {
    getIt<LoadingCubit>().show();
    emit(const UploadCancelledChequeLoading());
    Uint8List bytes = await chequeImage.readAsBytes();
    final response = await _uploadCancelledCheque(UploadCancelledChequeParams(fileBytes: bytes));
    emit(response.fold((l) => UploadCancelledChequeFailure(errorType: l.errorType, errorMessage: l.error), (r) => const UploadCancelledChequeSuccess()));
    getIt<LoadingCubit>().hide();
  }
}
