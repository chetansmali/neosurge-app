import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_mandate_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/add_user_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class AddUserMandate extends UseCase<void, AddUserMandateParams> {
  final AccountRepository _accountRepository;

  AddUserMandate(this._accountRepository);

  @override
  Future<Either<AppError, UserMandate>> call(AddUserMandateParams params) =>
      _accountRepository.addUserMandate(params.toJson());
}
