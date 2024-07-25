import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mpin/verify_forgot_mpin_otp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class ForgotMPinVerifyOtp extends UseCase<void, VerifyForgotMPinOtpParams> {
  final AccountRepository _accountRepository;

  ForgotMPinVerifyOtp(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(VerifyForgotMPinOtpParams params) =>
      _accountRepository.forgotMPinVerifyOtp(params.toJson());
}
