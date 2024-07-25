import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/address_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/add_delivery_address_params.dart';
import '../../../../domain/usecases/account/add_delivery_address.dart';
import '../../util_cubits/loading_cubit.dart';

part 'add_delivery_address_state.dart';

@injectable
class AddDeliveryAddressCubit extends Cubit<AddDeliveryAddressState> {
  final AddDeliveryAddress _addDeliveryAddress;
  final LoadingCubit _loadingCubit;

  AddDeliveryAddressCubit(this._addDeliveryAddress, this._loadingCubit) : super(AddDeliveryAddressInitial());

  void addDeliveryAddress(AddDeliveryAddressParams addDgAddressParams) async {
    _loadingCubit.show();
    emit(AddDeliveryAddressLoading());
    final res = await _addDeliveryAddress(addDgAddressParams);
    emit(res.fold((l) => AddDeliveryAddressFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => AddDeliveryAddressSuccess(addressDetailsModel: r)));
    _loadingCubit.hide();
  }
}
