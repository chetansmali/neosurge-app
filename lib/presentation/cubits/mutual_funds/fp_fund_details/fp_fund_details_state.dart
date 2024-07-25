part of 'fp_fund_details_cubit.dart';

abstract class FpFundDetailsState extends Equatable {
  const FpFundDetailsState();
}

class FpFundDetailsInitial extends FpFundDetailsState {
  @override
  List<Object> get props => [];
}

class FpFundDetailsLoading extends FpFundDetailsState {
  @override
  List<Object> get props => [];
}

class FpFundDetailsLoaded extends FpFundDetailsState {
  final FpFundDetails fpFundDetails;

  const FpFundDetailsLoaded(this.fpFundDetails);

  @override
  List<Object> get props => [fpFundDetails];
}

class FpFundDetailsError extends FpFundDetailsState {
  final AppErrorType errorType;
  final String? error;

  const FpFundDetailsError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
