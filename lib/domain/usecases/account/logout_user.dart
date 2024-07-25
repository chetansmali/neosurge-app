import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';

@injectable
class LogoutUser extends UseCase<void, NoParams> {
  LogoutUser();

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    await Hive.deleteFromDisk();
    return const Right(null);
  }
}
