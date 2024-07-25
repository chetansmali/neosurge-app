import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class SetUser extends UseCase<void, User> {
  final AccountRepository _accountRepository;

  SetUser(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(User params) =>
      _accountRepository.setUser(params);
}
