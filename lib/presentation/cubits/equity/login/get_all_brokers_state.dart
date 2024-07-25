part of 'get_all_brokers_cubit.dart';

abstract class GetAllBrokersState extends Equatable {
  const GetAllBrokersState();
}

class GetAllBrokersInitial extends GetAllBrokersState {
  @override
  List<Object> get props => [];
}

class GetAllBrokersLoading extends GetAllBrokersState {
  @override
  List<Object> get props => [];
}

class GetAllBrokersSuccess extends GetAllBrokersState {
  final List<BrokersModel> brokersModel;

  const GetAllBrokersSuccess({required this.brokersModel});

  @override
  List<Object> get props => [brokersModel];
}

class GetAllBrokersFailure extends GetAllBrokersState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetAllBrokersFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
