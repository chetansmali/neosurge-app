part of 'get_pincode_data_cubit.dart';

abstract class GetPincodeDataState extends Equatable {
  const GetPincodeDataState();
}

class GetPincodeDataInitial extends GetPincodeDataState {
  @override
  List<Object> get props => [];
}

class GetPincodeDataLoading extends GetPincodeDataState {
  @override
  List<Object> get props => [];
}

class GetPincodeDataSuccess extends GetPincodeDataState {
  final PinCodeDataModel pinCodeData;

  const GetPincodeDataSuccess({
    required this.pinCodeData,
  });

  @override
  List<Object> get props => [];
}

class GetPincodeDataFailure extends GetPincodeDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetPincodeDataFailure({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
