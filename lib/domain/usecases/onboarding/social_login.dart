import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/params/authentication/social_login_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class SocialLogin extends UseCase<User, SocialLoginParams> {
  final AccountRepository _accountRepository;

  SocialLogin(this._accountRepository);

  @override
  Future<Either<AppError, User>> call(SocialLoginParams params) async {
    return await _accountRepository.doSocialLogin(params.toJson());
  }
}
