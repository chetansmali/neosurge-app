part of 'etf_fund_houses_cubit.dart';

sealed class EtfFundHousesState extends Equatable {
  const EtfFundHousesState();
}

class EtfFundHousesInitial extends EtfFundHousesState {
  @override
  List<Object> get props => [];
}

class EtfFundHousesLoading extends EtfFundHousesState {
  @override
  List<Object> get props => [];
}

class EtfFundHousesSuccess extends EtfFundHousesState {
  final List<String> etfFundHouses;

  const EtfFundHousesSuccess({required this.etfFundHouses});

  @override
  List<Object> get props => [etfFundHouses];
}

class EtfFundHousesFailure extends EtfFundHousesState {
  final String? errorMessage;
  final AppErrorType errorType;

  const EtfFundHousesFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
