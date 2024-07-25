import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/get_transactions_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetTransactions extends UseCase<GetTransactionsDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  GetTransactions(this._lamfRepository);

  @override
  Future<Either<AppError, GetTransactionsDetails>> call(params) =>
      _lamfRepository.getTransactions();
}
