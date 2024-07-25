import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/get_loan_user_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetCreditLimit extends UseCase<GetLoanUserDetails,NoParams>{
  final LAMFRepository _lAMFRepository;

  GetCreditLimit(this._lAMFRepository);

  @override
  Future<Either<AppError,GetLoanUserDetails>>call(NoParams params)=>
      _lAMFRepository.getCreditLimit();

}

