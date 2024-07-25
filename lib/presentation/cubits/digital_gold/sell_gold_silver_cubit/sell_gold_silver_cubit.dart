import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/digital_gold/sell_gold_silver_params.dart';
import '../../../../domain/usecases/digital_gold/sell_gold_silver.dart';

part 'sell_gold_silver_state.dart';

@injectable
class SellGoldSilverCubit extends Cubit<SellGoldSilverState> {
  final SellGoldSilver _sellGoldSilver;

  SellGoldSilverCubit(this._sellGoldSilver) : super(SellGoldSilverInitial());

  void sellGoldSilver({required String orderId}) async {
    emit(SellGoldSilverLoading());
    final result = await _sellGoldSilver(SellGoldSilverParams(orderId: orderId));
    result.fold(
      (l) => emit(SellGoldSilverError(appErrorType: l.errorType, errorMessage: l.error)),
      (r) => emit(SellGoldSilverSuccess()),
    );
  }
}
