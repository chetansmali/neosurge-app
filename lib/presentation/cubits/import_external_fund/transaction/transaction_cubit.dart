import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../data/models/import_external_funds/initialise_transaction_response.dart';
import '../../../../data/models/import_external_funds/validate_transaction_response.dart';
import '../../../../domain/entities/params/import_external_fund/initialise_transaction_params.dart';
import '../../../../domain/entities/params/import_external_fund/validate_transaction_params.dart';
import '../../../../domain/usecases/import_external_fund/initialise_transaction.dart';
import '../../../../domain/usecases/import_external_fund/validate_transaction.dart';
import '../../util_cubits/loading_cubit.dart';

part 'transaction_state.dart';

@injectable
class TransactionCubit extends Cubit<TransactionState> {
  final LoadingCubit _loadingCubit;
  final InitialiseTransaction _initialiseTransaction;
  final ValidateTransaction _validateTransaction;

  TransactionCubit(
    this._loadingCubit,
    this._initialiseTransaction,
    this._validateTransaction,
  ) : super(TransactionInitial());

  Future initailiseImportTransaction({
    required int userId,
    required String panNumber,
    required String phoneNumber,
  }) async {
    _loadingCubit.show();

    emit(TransactionLoading());

    final response = await _initialiseTransaction(
      InitialiseTransactionParams(
        userID: userId,
        panNumber: panNumber,
        phoneNumber: phoneNumber,
      ),
    );

    emit(
      response.fold(
        (l) => TransactionError(
          appErrorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => TransactionInitialised(
          initialiseTransactionReposnse: r,
        ),
      ),
    );

    _loadingCubit.hide();
  }

  Future validateTransaction({
    required String transactionID,
    required String panNumber,
    required String phoneNumber,
    required int userId,
    required String otp,
  }) async {
    _loadingCubit.show();

    final response = await _validateTransaction(
      ValidateTransactionParams(
        transactionID: transactionID,
        panNumber: panNumber,
        phoneNumber: phoneNumber,
        userID: userId,
        otp: otp,
      ),
    );

    emit(
      response.fold(
        (l) => TransactionError(
          appErrorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => TransactionValidated(
          validateTransactionResponse: r,
        ),
      ),
    );

    _loadingCubit.hide();
  }
}
