import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_sip_order_verify_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_sip_order_verify_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class VerifyBasketSipConsent
    extends UseCase<BasketSipOrderVerifyResponse, BasketSipOrderVerifyParams> {
  NeobasketsRepository neobasketsRepository;

  VerifyBasketSipConsent(this.neobasketsRepository);

  @override
  Future<Either<AppError, BasketSipOrderVerifyResponse>> call(
          BasketSipOrderVerifyParams params) =>
      neobasketsRepository.verifyBasketSipConsent(
        params.toJson(),
      );
}
