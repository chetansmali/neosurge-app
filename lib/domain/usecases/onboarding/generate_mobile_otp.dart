import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GenerateMobileOtp extends UseCase<void, GenerateMobileOTPParams> {
  final AccountRepository _accountRepository;

  GenerateMobileOtp(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(GenerateMobileOTPParams params) async =>
      await _accountRepository.generateMobileOtp(params.toJson());
}

class GenerateMobileOTPParams {
  final String mobileNumber;

  GenerateMobileOTPParams({required this.mobileNumber});

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
    };
  }
}
