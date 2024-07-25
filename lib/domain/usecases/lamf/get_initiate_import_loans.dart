import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/get_init_loan_import_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/lamf/initiate_loan_import_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetInititateImportLoans extends UseCase<GetInitiateLoanImportResponse,
    GetInitiateLoanImportsParams> {
  final LAMFRepository _lAMFRepository;

  GetInititateImportLoans(this._lAMFRepository);

  @override
  Future<Either<AppError, GetInitiateLoanImportResponse>> call(
          GetInitiateLoanImportsParams params) async =>
      _lAMFRepository.getInitiateLoanImport(params.toJson());
}
