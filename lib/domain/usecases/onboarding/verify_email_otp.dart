import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/params/authentication/verify_email_otp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class VerifyEmailOtp extends UseCase<User, VerifyEmailOtpParams> {
  final AccountRepository _accountRepository;

  VerifyEmailOtp(this._accountRepository);

  @override
  Future<Either<AppError, User>> call(VerifyEmailOtpParams params) async =>
      await _accountRepository.verifyEmailOtp(params.toJson());
}
