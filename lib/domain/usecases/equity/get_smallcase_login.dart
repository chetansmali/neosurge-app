import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/login/smallcase_login.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/ligin/smallcase_login.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSmallcaseLogin extends UseCase<SmallCaseLoginModel,SmallCaseLoginParams>{
  final EquityRespository equityRespository;

  GetSmallcaseLogin(this.equityRespository);

  @override
  Future<Either<AppError,SmallCaseLoginModel>> call(SmallCaseLoginParams params) =>
      equityRespository.getSmallCaseLogin(params.toJson());
}