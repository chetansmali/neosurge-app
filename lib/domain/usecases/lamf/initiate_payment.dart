import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/lamf/initiate_payment_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class InitiatePayment extends UseCase<InitiatePaymentDetails, NoParams> {
  final LAMFRepository _lamfRepository;
  InitiatePayment(this._lamfRepository);

  @override
  Future<Either<AppError, InitiatePaymentDetails>> call(params) =>
      _lamfRepository.initiatePayment();
}
