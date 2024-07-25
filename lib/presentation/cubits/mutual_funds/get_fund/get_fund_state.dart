part of 'get_fund_cubit.dart';

abstract class GetFundState extends Equatable {
  const GetFundState();
}

class GetFundInitial extends GetFundState {
  @override
  List<Object> get props => [];
}

class GetFundLoading extends GetFundState {
  @override
  List<Object> get props => [];
}

class GetFundLoaded extends GetFundState {
  final Fund fund;

  const GetFundLoaded({required this.fund});

  @override
  List<Object> get props => [fund];
}

class GetFundLoadFailure extends GetFundState {
  final AppErrorType errorType;
  final String? error;

  const GetFundLoadFailure({
    required this.errorType,
    this.error,
  });

  @override
  List<Object> get props => [errorType];
}
