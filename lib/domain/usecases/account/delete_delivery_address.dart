import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/delete_delivery_address_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class DeleteDeliveryAddress extends UseCase<void, DeleteDeliveryAddressParams> {
  final AccountRepository _accountRepository;

  DeleteDeliveryAddress(this._accountRepository);

  @override
  Future<Either<AppError, void>> call(DeleteDeliveryAddressParams params) =>
      _accountRepository.deleteAddress(params.toJson());
}
