import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/lamf/get_loan_data_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/lamf/get_loan_data_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetImportLoanData
    extends UseCase<GetLoanDataResponse, GetLoanDataParams> {
  final LAMFRepository _lamfRepository;

  GetImportLoanData(this._lamfRepository);

  @override
  Future<Either<AppError, GetLoanDataResponse>> call(
          GetLoanDataParams params) async =>
      await _lamfRepository.getImportLoanData(params.toJson());
}
