import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_lumpsum_order_verify_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_lumpsum_order_verify_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class VerifyBasketLumpsumConsent extends UseCase<
    BasketLumpsumOrderVerifyResponse, BasketLumpsumOrderVerifyParams> {
  NeobasketsRepository neobasketsRepository;

  VerifyBasketLumpsumConsent(this.neobasketsRepository);

  @override
  Future<Either<AppError, BasketLumpsumOrderVerifyResponse>> call(
          BasketLumpsumOrderVerifyParams params) =>
      neobasketsRepository.verifyBasketLumpsumConsent(params.toJson());
}
