import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class ForgotMPinGenerateOtp extends UseCase<void, NoParams> {
  final AccountRepository _accountRepository;

  ForgotMPinGenerateOtp(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) =>
      _accountRepository.forgotMPinGenerateOtp();
}
