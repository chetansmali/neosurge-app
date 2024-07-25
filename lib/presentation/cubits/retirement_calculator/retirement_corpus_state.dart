part of 'retirement_corpus_cubit.dart';

abstract class RetirementCorpusState extends Equatable {
  const RetirementCorpusState();
}

class RetirementCorpusInitial extends RetirementCorpusState {
  @override
  List<Object> get props => [];
}

class RetirementCorpusLoading extends RetirementCorpusState {
  @override
  List<Object> get props => [];
}

class RetirementCorpusSuccess extends RetirementCorpusState {
  final RetirementCorpusModel retirementCorpusModel;

  const RetirementCorpusSuccess(this.retirementCorpusModel);
  @override
  List<Object> get props => [retirementCorpusModel];
}

class RetirementCorpusFailure extends RetirementCorpusState {
  final String? errorMessage;
  final AppErrorType errorType;

  const RetirementCorpusFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
