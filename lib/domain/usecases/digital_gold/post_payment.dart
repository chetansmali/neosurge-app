import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/post_payment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class PostDigitalGoldPayment extends UseCase<void, PostPaymentParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  PostDigitalGoldPayment(this._digitalGoldRepository);

  @override
  Future<Either<AppError, void>> call(PostPaymentParams params) async =>
      await _digitalGoldRepository.postPayment(params.toJson());
}
