import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import 'package:dartz/dartz.dart';

import '../../entities/params/neobaskets/verify_basket_redeem_consent_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class VerifyBasketRedeemConsent
    extends UseCase<void, VerifyBasketRedeemConsentParams> {
  final NeobasketsRepository _neobasketsRepository;

  VerifyBasketRedeemConsent(this._neobasketsRepository);

  @override
  Future<Either<AppError, void>> call(VerifyBasketRedeemConsentParams params) {
    return _neobasketsRepository.verifyBasketRedeemConsent(
      params.toJson(),
    );
  }
}
