import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_mandate_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/authorise_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

///The [AuthoriseMandateUsecase] is a [Usecase] that is used to update the token url
/// everytime the user tries to authorise the mandate as the old token url will be invalidated.

@injectable
class AuthoriseMandate extends UseCase<UserMandate, AuthoriseMandateParams> {
  final AccountRepository _accountRepository;

  AuthoriseMandate(this._accountRepository);

  @override
  Future<Either<AppError, UserMandate>> call(AuthoriseMandateParams params) =>
      _accountRepository.authoriseMandate(params.toJson());
}
