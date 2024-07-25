import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user_mandate_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/get_user_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class DeleteUserMandateById extends UseCase<UserMandate?, GetUserMandateParams> {
  final AccountRepository _accountRepository;

  DeleteUserMandateById(this._accountRepository);

  @override
  Future<Either<AppError, UserMandate?>> call(GetUserMandateParams params) =>
      _accountRepository.deleteUserMandateById(params.toJson());
}
