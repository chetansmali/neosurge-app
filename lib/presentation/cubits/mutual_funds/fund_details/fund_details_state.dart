part of 'fund_details_cubit.dart';

abstract class FundDetailsState extends Equatable {
  const FundDetailsState();
}

class FundDetailsInitial extends FundDetailsState {
  @override
  List<Object> get props => [];
}

class FundDetailsLoading extends FundDetailsState {
  @override
  List<Object> get props => [];
}

class FundDetailsLoaded extends FundDetailsState {
  final FundDetail fundDetail;

  const FundDetailsLoaded({required this.fundDetail});

  @override
  List<Object> get props => [];
}

class FundDetailsLoadFailure extends FundDetailsState {
  final String? error;
  final AppErrorType errorType;

  const FundDetailsLoadFailure({required this.errorType, this.error});

  @override
  List<Object?> get props => [errorType, error];
}
