import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/lamf/loan_import_details_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetLoanImportDetails extends UseCase<LoanImportDetailsModel, NoParams> {
  final LAMFRepository _lamfRepository;

  GetLoanImportDetails(this._lamfRepository);

  @override
  Future<Either<AppError, LoanImportDetailsModel>> call(
          NoParams params) async =>
      await _lamfRepository.getLoanImportDetails();
}
