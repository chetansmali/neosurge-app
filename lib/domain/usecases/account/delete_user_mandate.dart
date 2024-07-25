import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/delete_mandate_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/account/delete_mandate_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class DeleteUserMandate
    extends UseCase<DeleteMandateModel, DeleteMandateParams> {
  final AccountRepository _accountRepository;

  DeleteUserMandate(this._accountRepository);

  @override
  Future<Either<AppError, DeleteMandateModel>> call(
          DeleteMandateParams params) =>
      _accountRepository.deleteUserMandate(params.toJson());
}
