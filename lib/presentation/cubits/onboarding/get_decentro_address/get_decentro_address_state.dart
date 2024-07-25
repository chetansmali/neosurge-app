part of 'get_decentro_address_cubit.dart';

abstract class GetDecentroAddressState extends Equatable {
  const GetDecentroAddressState();
}

class GetDecentroAddressInitial extends GetDecentroAddressState {
  @override
  List<Object> get props => [];
}

class GetDecentroAddressLoading extends GetDecentroAddressState {
  @override
  List<Object> get props => [];
}

class GetDecentroAddressSuccess extends GetDecentroAddressState {
  final List<GetDecentroAddressModel> decentroAddressList;

  const GetDecentroAddressSuccess({
    required this.decentroAddressList,
  });

  @override
  List<Object> get props => [];
}

class GetDecentroAddressFailure extends GetDecentroAddressState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetDecentroAddressFailure({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
