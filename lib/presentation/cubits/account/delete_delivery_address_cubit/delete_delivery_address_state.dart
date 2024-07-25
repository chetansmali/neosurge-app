part of 'delete_delivery_address_cubit.dart';

abstract class DeleteDeliveryAddressState extends Equatable {
  const DeleteDeliveryAddressState();
}

class DeleteDeliveryAddressInitial extends DeleteDeliveryAddressState {
  @override
  List<Object> get props => [];
}

class DeleteDeliveryAddressLoading extends DeleteDeliveryAddressState {
  @override
  List<Object> get props => [];
}

class DeleteDeliveryAddressSuccess extends DeleteDeliveryAddressState {
  final int index;

  const DeleteDeliveryAddressSuccess({required this.index});

  @override
  List<Object> get props => [index];
}

class DeleteDeliveryAddressFailure extends DeleteDeliveryAddressState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const DeleteDeliveryAddressFailure({
    required this.appErrorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
