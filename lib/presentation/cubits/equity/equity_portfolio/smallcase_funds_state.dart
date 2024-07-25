part of 'smallcase_funds_cubit.dart';

abstract class SmallcaseFundsState extends Equatable {
  const SmallcaseFundsState();
}

class SmallcaseFundsInitial extends SmallcaseFundsState {
  @override
  List<Object> get props => [];
}

class SmallcaseFundsLoading extends SmallcaseFundsState {
  @override
  List<Object> get props => [];
}

class SmallcaseFundsSuccess extends SmallcaseFundsState {
  final GetFundsModel getFundsModel;

  const SmallcaseFundsSuccess(this.getFundsModel);

  @override
  List<Object> get props => [getFundsModel];
}

class SmallcaseFundsFailure extends SmallcaseFundsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const SmallcaseFundsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
