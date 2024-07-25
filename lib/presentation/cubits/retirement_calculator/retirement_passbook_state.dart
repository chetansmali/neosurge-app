part of 'retirement_passbook_cubit.dart';

abstract class RetirementPassbookState extends Equatable {
  const RetirementPassbookState();
}

class RetirementPassbookInitial extends RetirementPassbookState {
  @override
  List<Object> get props => [];
}

class RetirementPassbookLoading extends RetirementPassbookState {
  @override
  List<Object> get props => [];
}

class RetirementPassbookLoaded extends RetirementPassbookState {
  final RetirementPassbookModel retirementPassbookModel;
  const RetirementPassbookLoaded(this.retirementPassbookModel);
  @override
  List<Object> get props => [retirementPassbookModel];
}

class RetirementPassbookFailure extends RetirementPassbookState {
  final String? errorMessage;
  final AppErrorType errorType;

  const RetirementPassbookFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
