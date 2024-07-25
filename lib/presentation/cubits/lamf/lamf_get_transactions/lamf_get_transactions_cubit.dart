import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_transactions_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_transactions.dart';

part 'lamf_get_transactions_state.dart';

@Injectable()
class LamfGetTransactionsCubit extends Cubit<LamfGetTransactionsState> {
  final GetTransactions _getTransactions;
  LamfGetTransactionsCubit(this._getTransactions)
      : super(LamfGetTransactionsInitial());
  void lamfGetTransactions() async {
    emit(LamfGetTransactionsLoading());
    final response = await _getTransactions(NoParams());
    emit(response.fold((l) => LamfGetTransactionsFailure(l.error, l.errorType),
        (r) => LamfGetTransactionsSuccess(r)));
  }
}
