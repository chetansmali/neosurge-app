import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/lamf/avail_loan_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetAvailLoan extends UseCase<AvailLoanDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  GetAvailLoan(this._lamfRepository);

  @override
  Future<Either<AppError, AvailLoanDetails>> call(params) =>
      _lamfRepository.getAvailLoan();
}
