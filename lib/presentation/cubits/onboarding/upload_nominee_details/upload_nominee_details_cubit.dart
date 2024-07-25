import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/get_kyc_nominee_details_model.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/nominee_entity.dart';
import '../../../../domain/entities/params/kyc/delete_nominee_params.dart';
import '../../../../domain/entities/params/kyc/upload_nominee_details_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/kyc/delete_nominee_details.dart';
import '../../../../domain/usecases/kyc/get_kyc_nominee_details.dart';
import '../../../../domain/usecases/kyc/update_investor_account.dart';
import '../../../../domain/usecases/kyc/upload_nominee_details.dart';
import '../../util_cubits/loading_cubit.dart';

part 'upload_nominee_details_state.dart';

@injectable
class UploadNomineeDetailsCubit extends Cubit<UploadNomineeDetailsState> {
  final UploadNomineeDetails _uploadNomineeDetails;
  final GetKycNomineeDetails _getKycNomineeDetails;
  final DeleteNomineeDetails _deleteNomineeDetails;
  final UpdateInvestorAccount _updateInvestorAccount;

  List<GetKycNomineeDetailsModel> _nomineeList = [];

  UploadNomineeDetailsCubit(
      this._uploadNomineeDetails,
      this._getKycNomineeDetails,
      this._deleteNomineeDetails,
      this._updateInvestorAccount)
      : super(UploadNomineeDetailsInitial());

  void fetchNomineeDetails() async {
    emit(const UploadNomineeDetailsLoading(isFetch: true));
    final res = await _getKycNomineeDetails(NoParams());
    emit(res.fold(
        (l) => UploadNomineeDetailsFailure(
            appErrorType: l.errorType,
            isFetch: true,
            errorMessage: l.error), (r) {
      _nomineeList = r;
      return UploadNomineeDetailsSuccess(isFetch: true, nomineeList: r);
    }));
  }

  void uploadNomineeDetails({
    required List<NomineeEntity> nomineeList,
    bool isFromViewUpdate = false,
  }) async {
    getIt<LoadingCubit>().show();
    emit(const UploadNomineeDetailsLoading());
    final response = await _uploadNomineeDetails(
        UploadNomineeDetailsParams(nomineeData: nomineeList));
    response.fold(
      (l) {
        emit(UploadNomineeDetailsFailure(
            appErrorType: l.errorType, errorMessage: l.error));
        getIt<LoadingCubit>().hide();
      },
      (r) async {
        if (isFromViewUpdate) {
          await _updateInvestorAccount(NoParams());
        }
        emit(const UploadNomineeDetailsSuccess());
        getIt<LoadingCubit>().hide();
      },
    );
  }

  void deleteNomineeDetails({
    required int nomineeId,
    required int index,
    bool isFromViewUpdate = false,
  }) async {
    getIt<LoadingCubit>().show();
    emit(const UploadNomineeDetailsLoading());
    final response =
        await _deleteNomineeDetails(DeleteNomineeParams(nomineeId: nomineeId));
    response.fold((l) {
      emit(UploadNomineeDetailsFailure(
          appErrorType: l.errorType, errorMessage: l.error));
      getIt<LoadingCubit>().hide();
    }, (r) async {
      if (isFromViewUpdate) {
        await _updateInvestorAccount(NoParams());
      }
      _nomineeList.removeWhere((element) => element.id == nomineeId);
      emit(UploadNomineeDetailsSuccess(
          isFetch: true,
          nomineeList: _nomineeList,
          isDelete: true,
          deleteIndex: index));
      getIt<LoadingCubit>().hide();
    });
  }
}
