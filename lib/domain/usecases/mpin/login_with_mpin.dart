import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class LoginWithMPin extends UseCase<User, LoginWithMPinParams> {
  final AccountRepository _accountRepository;

  LoginWithMPin(this._accountRepository);

  @override
  Future<Either<AppError, User>> call(LoginWithMPinParams params) async =>
      await _accountRepository.loginWithMPin(params.toJson());
}

class LoginWithMPinParams {
  final String mPin;
  final String mobileNumber;

  LoginWithMPinParams({required this.mPin, required this.mobileNumber});

  Map<String, dynamic> toJson() => {
        'mpin': mPin,
        'mobileNumber': mobileNumber,
      };
}
