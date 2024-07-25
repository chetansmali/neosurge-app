import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/delete_delivery_address_params.dart';
import '../../../../domain/usecases/account/delete_delivery_address.dart';

part 'delete_delivery_address_state.dart';

@injectable
class DeleteDeliveryAddressCubit extends Cubit<DeleteDeliveryAddressState> {
  final DeleteDeliveryAddress _deleteDeliveryAddress;

  DeleteDeliveryAddressCubit(this._deleteDeliveryAddress) : super(DeleteDeliveryAddressInitial());

  void deleteAddress({required int index, required int id}) async {
    emit(DeleteDeliveryAddressLoading());
    final response = await _deleteDeliveryAddress(DeleteDeliveryAddressParams(id));
    emit(response.fold((l) => DeleteDeliveryAddressFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => DeleteDeliveryAddressSuccess(index: index)));
  }
}
