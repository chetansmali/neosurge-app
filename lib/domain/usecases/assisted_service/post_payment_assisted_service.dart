import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/user.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/post_payment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class PostPaymentAssistedService
    extends UseCase<User, PostPaymentParams> {
  final AssistedServiceRepository _repository;

  PostPaymentAssistedService(this._repository);

  @override
  Future<Either<AppError, User>> call(PostPaymentParams params) =>
      _repository.postPayment(params.toJson());
}
