part of 'create_lumpsum_purchase_cubit.dart';

abstract class CreateLumpsumPurchaseState extends Equatable {
  const CreateLumpsumPurchaseState();
}

class CreateLumpsumPurchaseInitial extends CreateLumpsumPurchaseState {
  @override
  List<Object> get props => [];
}

class CreateLumpsumPurchaseLoading extends CreateLumpsumPurchaseState {
  @override
  List<Object> get props => [];
}

class ProceedtoOrderSummary extends CreateLumpsumPurchaseState {
  final LumpsumPurchase lumpsumPurchase;

  const ProceedtoOrderSummary({required this.lumpsumPurchase});

  @override
  List<Object> get props => [lumpsumPurchase];
}

class CreateLumpsumPurchaseSuccess extends CreateLumpsumPurchaseState {
  final LumpsumPurchase lumpsumPurchase;

  const CreateLumpsumPurchaseSuccess({required this.lumpsumPurchase});

  @override
  List<Object> get props => [lumpsumPurchase];
}

class CreateLumpsumPurchaseFailure extends CreateLumpsumPurchaseState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CreateLumpsumPurchaseFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
