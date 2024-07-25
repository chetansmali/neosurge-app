import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/loan_closure_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class LoanClosure extends UseCase<LoanClosureDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  LoanClosure(this._lamfRepository);

  @override
  Future<Either<AppError, LoanClosureDetails>> call(params) =>
      _lamfRepository.loanClosure();
}
