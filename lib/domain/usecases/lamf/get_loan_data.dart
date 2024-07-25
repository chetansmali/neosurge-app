import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/lamf/get_loan_data_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetLoanData extends UseCase<GetLoanDataDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  GetLoanData(this._lamfRepository);

  @override
  Future<Either<AppError, GetLoanDataDetails>> call(params) =>
      _lamfRepository.getLoanData();
}
