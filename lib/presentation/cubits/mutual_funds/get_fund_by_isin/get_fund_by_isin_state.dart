part of 'get_fund_by_isin_cubit.dart';

abstract class GetFundByIsinState extends Equatable {
  const GetFundByIsinState();
}

class GetFundByIsinInitial extends GetFundByIsinState {
  @override
  List<Object> get props => [];
}

class GetFundByIsinLoading extends GetFundByIsinState {
  @override
  List<Object> get props => [];
}

class GetFundByIsinLoadFailure extends GetFundByIsinState {
  final AppErrorType errorType;
  final String? error;

  const GetFundByIsinLoadFailure(this.errorType, this.error);

  @override
  List<Object?> get props => [error, errorType];
}

class GetFundByIsinLoaded extends GetFundByIsinState {
  final Fund fund;

  const GetFundByIsinLoaded(this.fund);

  @override
  List<Object?> get props => [fund];
}
