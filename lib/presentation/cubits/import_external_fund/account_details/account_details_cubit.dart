import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/validators.dart';
import '../../../../data/models/import_external_funds/account_details_response.dart';
import '../../../../domain/entities/params/import_external_fund/get_account_details_params.dart';
import '../../../../domain/usecases/import_external_fund/get_account_details.dart';
import '../../../../domain/entities/app_error.dart';

part 'account_details_state.dart';

@injectable
class AccountDetailsCubit extends Cubit<AccountDetailsState> {
  final GetAccountDetails _getAccountDetails;

  AccountDetailsCubit(
    this._getAccountDetails,
  ) : super(AccountDetailsInitial());

  Future getAccountDetails({required int userId}) async {
    emit(AccountDetailsLoading());

    final response = await _getAccountDetails(
      GetAccountDetailsParams(
        userID: userId,
      ),
    );

    emit(
      response.fold(
        (l) => AccountDetailsLoadError(
          appErrorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => AccountDetailsLoaded(
          accountDetailsResponse: r,
        ),
      ),
    );
  }

  void validateForm({
    required String panNumber,
    required String mobileNumber,
  }) {
    emit(
      AccountDetailsChanged(
        isBtnEnabled: _isFormValid(
          panNumber: panNumber,
          mobileNumber: mobileNumber,
        ),
      ),
    );
  }

  bool _isFormValid({
    required String panNumber,
    required String mobileNumber,
  }) {
    return Validators.validateMobileNumber(mobileNumber) == null &&
        Validators.validatePanNumber(panNumber) == null;
  }
}
