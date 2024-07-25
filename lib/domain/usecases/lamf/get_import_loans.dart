import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/import_loans_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetImportLoans extends UseCase<ImportLoansDetails,NoParams>{
  final LAMFRepository _lAMFRepository;

  GetImportLoans(this._lAMFRepository);

  @override
  Future<Either<AppError,ImportLoansDetails>>call(NoParams params)=>
      _lAMFRepository.getImportLoans();

}

