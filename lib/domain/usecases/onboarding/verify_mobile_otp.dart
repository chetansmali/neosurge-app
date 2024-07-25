import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class VerifyMobileOtp extends UseCase<void, VerifyMobileOtpParams> {
  final AccountRepository _accountRepository;

  VerifyMobileOtp(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(VerifyMobileOtpParams params) async =>
      await _accountRepository.verifyMobileOtp(params.toJson());
}

class VerifyMobileOtpParams {
  final String mobile;
  final String otp;

  VerifyMobileOtpParams(this.mobile, this.otp);

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobile,
      'otp': otp,
    };
  }
}
