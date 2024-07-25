part of 'add_delivery_address_cubit.dart';

abstract class AddDeliveryAddressState extends Equatable {
  const AddDeliveryAddressState();
}

class AddDeliveryAddressInitial extends AddDeliveryAddressState {
  @override
  List<Object> get props => [];
}

class AddDeliveryAddressLoading extends AddDeliveryAddressState {
  @override
  List<Object> get props => [];
}

class AddDeliveryAddressSuccess extends AddDeliveryAddressState {
  final DeliveryAddressDetailsModel addressDetailsModel;

  const AddDeliveryAddressSuccess({required this.addressDetailsModel});

  @override
  List<Object> get props => [addressDetailsModel];
}

class AddDeliveryAddressFailure extends AddDeliveryAddressState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const AddDeliveryAddressFailure({
    required this.appErrorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
