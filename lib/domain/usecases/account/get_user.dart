import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class GetUser extends UseCase<User?, GetUserParams> {
  final AccountRepository _accountRepository;

  GetUser(this._accountRepository);

  @override
  Future<Either<AppError, User?>> call(GetUserParams params) async =>
      await _accountRepository.getUser(forceRefresh: params.forceRefresh);
}

class GetUserParams {
  /// If true, the user will be fetched from the server
  final bool forceRefresh;

  GetUserParams({this.forceRefresh = false});
}
