import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/user/address_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/add_delivery_address_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/account_repository.dart';

@injectable
class AddDeliveryAddress
    extends UseCase<DeliveryAddressDetailsModel, AddDeliveryAddressParams> {
  final AccountRepository _accountRepository;

  AddDeliveryAddress(this._accountRepository);

  @override
  Future<Either<AppError, DeliveryAddressDetailsModel>> call(
          AddDeliveryAddressParams params) =>
      _accountRepository.addAddress(params.toJson());
}
