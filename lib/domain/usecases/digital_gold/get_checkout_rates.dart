import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/checkout_rates_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/checkout_rates_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class GetCheckoutRates
    extends UseCase<CheckoutRatesModel, CheckoutRatesParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  GetCheckoutRates(this._digitalGoldRepository);

  @override
  Future<Either<AppError, CheckoutRatesModel>> call(
          CheckoutRatesParams params) =>
      _digitalGoldRepository.getCheckoutRates(params.toJson());
}
