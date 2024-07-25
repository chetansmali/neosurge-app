import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/address_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/get_delivery_address_list.dart';

part 'delivery_address_state.dart';

@injectable
class DeliveryAddressCubit extends Cubit<DeliveryAddressState> {
  final GetDeliveryAddressList _getDeliveryAddressList;

  DeliveryAddressCubit(this._getDeliveryAddressList) : super(DeliveryAddressInitial());

  void getDeliveryAddresses() async {
    emit(DeliveryAddressLoading());
    final response = await _getDeliveryAddressList(NoParams());
    emit(response.fold((l) => DeliveryAddressLoadError(appErrorType: l.errorType, errorMessage: l.error), (r) => DeliveryAddressLoaded(addressList: r)));
  }

  void addAddress(DeliveryAddressDetailsModel addressDetailsModel) async {
    final List<DeliveryAddressDetailsModel> addressList = List.from((state as DeliveryAddressLoaded).addressList);
    addressList.add(addressDetailsModel);
    emit(DeliveryAddressLoaded(addressList: addressList));
  }

  void deleteAddress(int index) async {
    final List<DeliveryAddressDetailsModel> addressList = List.from((state as DeliveryAddressLoaded).addressList);
    addressList.removeAt(index);
    emit(DeliveryAddressLoaded(addressList: addressList));
  }
}
