import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/initiate_payment_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/assisted_service/initiate_suggested_funds_payment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class InitiateSuggestedFundsPayment extends UseCase<InitiatePaymentResponse,
    InitiateSuggestedFundsPaymentParams> {
  final AssistedServiceRepository _assistedServiceRepository;

  InitiateSuggestedFundsPayment(this._assistedServiceRepository);

  @override
  Future<Either<AppError, InitiatePaymentResponse>> call(
          InitiateSuggestedFundsPaymentParams params) =>
      _assistedServiceRepository.initiateSuggestedFundsPayment(params.toJson());
}
