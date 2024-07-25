import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/verify_transaction_otp_params.dart';
import '../../../../domain/usecases/mutual_funds/verify_redemption_otp.dart';
import '../../../../domain/usecases/mutual_funds/verify_stp_otp.dart';
import '../../../../domain/usecases/mutual_funds/verify_switch_otp.dart';
import '../../../../domain/usecases/mutual_funds/verify_swp_otp.dart';

part 'verify_transaction_otp_state.dart';

@injectable
class VerifyTransactionOtpCubit extends Cubit<VerifyTransactionOtpState> {
  final VerifyRedemptionOtp _verifyRedemptionOtp;
  final VerifySwitchOtp _verifySwitchOtp;
  final VerifySwpOtp _verifySwpOtp;
  final VerifyStpOtp _verifyStpOtp;

  VerifyTransactionOtpCubit(
    this._verifyRedemptionOtp,
    this._verifySwitchOtp,
    this._verifySwpOtp,
    this._verifyStpOtp,
  ) : super(VerifyTransactionOtpInitial());

  void verifyTransactionOtp({
    required String otp,
    required int transactionId,
    required MFTransactionTypes transactionType,
  }) async {
    if (state is VerifyTransactionOtpLoading) return;

    emit(VerifyTransactionOtpLoading());
    late final Either<AppError, void> res;
    switch (transactionType) {
      case MFTransactionTypes.redemption:
        res = await _verifyRedemptionOtp(
          VerifyTransactionOtpParams(
            id: transactionId,
            otp: otp,
          ),
        );
        break;
      case MFTransactionTypes.switchTransaction:
        res = await _verifySwitchOtp(
          VerifyTransactionOtpParams(
            id: transactionId,
            otp: otp,
          ),
        );
        break;
      case MFTransactionTypes.swp:
        res = await _verifySwpOtp(
          VerifyTransactionOtpParams(
            id: transactionId,
            otp: otp,
          ),
        );
        break;
      case MFTransactionTypes.stp:
        res = await _verifyStpOtp(
          VerifyTransactionOtpParams(
            id: transactionId,
            otp: otp,
          ),
        );
        break;
      default:
        emit(const VerifyTransactionOtpFailure(
            'Invalid transaction type', AppErrorType.api));
    }
    emit(
      res.fold(
        (l) => VerifyTransactionOtpFailure(l.error, l.errorType),
        (r) => VerifyTransactionOtpSuccess(),
      ),
    );
  }
}
