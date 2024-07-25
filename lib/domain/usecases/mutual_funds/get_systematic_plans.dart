import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/systematic_plan.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_systematic_plans_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetSystematicPlans
    extends UseCase<List<SystematicPlan>, GetSystematicPlansParams> {
  final MutualFundRepository repository;

  GetSystematicPlans(this.repository);

  @override
  Future<Either<AppError, List<SystematicPlan>>> call(
          GetSystematicPlansParams params) =>
      repository.getSystematicPlans(params.toJson());
}
