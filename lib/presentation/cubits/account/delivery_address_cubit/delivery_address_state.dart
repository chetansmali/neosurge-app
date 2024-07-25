part of 'delivery_address_cubit.dart';

abstract class DeliveryAddressState extends Equatable {
  const DeliveryAddressState();
}

class DeliveryAddressInitial extends DeliveryAddressState {
  @override
  List<Object> get props => [];
}

class DeliveryAddressLoading extends DeliveryAddressState {
  @override
  List<Object> get props => [];
}

class DeliveryAddressLoaded extends DeliveryAddressState {
  final List<DeliveryAddressDetailsModel> addressList;

  const DeliveryAddressLoaded({required this.addressList});

  @override
  List<Object> get props => [addressList];
}

class DeliveryAddressLoadError extends DeliveryAddressState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const DeliveryAddressLoadError({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
