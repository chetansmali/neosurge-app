import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/login/get_transaction_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/ligin/get_transaction.dart';
import '../../../../domain/usecases/equity/get_smallcase_transaction_id.dart';

part 'transactionid_state.dart';

@injectable
class TransactionidCubit extends Cubit<TransactionidState> {
  final GetTransactionId getTransactionId;

  TransactionidCubit(this.getTransactionId) : super(TransactionidInitial());

  Future fetchTransactionId(TransactionParams params) async {
    emit(TransactionidLoading());
    final response = await getTransactionId(params);
    response.fold(
        (l) => emit(TransactionidFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(TransactionidSuccess(transactionModel: r)));
  }
}
