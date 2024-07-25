part of 'get_loan_data_cubit.dart';

sealed class GetLoanDataState extends Equatable {
  const GetLoanDataState();
}

final class GetLoanDataInitial extends GetLoanDataState {
  @override
  List<Object> get props => [];
}

final class GetLoanDataLoading extends GetLoanDataState {
  @override
  List<Object> get props => [];
}

final class GetLoanDataSuccess extends GetLoanDataState {
  final GetLoanDataResponse getLoanDataResponse;

  const GetLoanDataSuccess({required this.getLoanDataResponse});

  @override
  List<Object> get props => [getLoanDataResponse];
}

final class GetLoanDataFailure extends GetLoanDataState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const GetLoanDataFailure({this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
