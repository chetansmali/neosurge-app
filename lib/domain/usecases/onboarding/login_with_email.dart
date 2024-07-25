import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/authentication/login_with_email_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class LoginWithEmail
    extends UseCase<LoginWithEmailResponseModel, LoginWithEmailParams> {
  final AccountRepository _accountRepository;

  LoginWithEmail(this._accountRepository);

  @override
  Future<Either<AppError, LoginWithEmailResponseModel>> call(
          LoginWithEmailParams params) async =>
      await _accountRepository.loginWithEmail(params.toJson());
}

class LoginWithEmailParams {
  final String emailId;

  LoginWithEmailParams({required this.emailId});

  Map<String, dynamic> toJson() => {
        'emailId': emailId,
      };
}
