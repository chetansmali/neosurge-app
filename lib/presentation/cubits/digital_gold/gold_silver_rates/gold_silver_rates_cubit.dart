import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/gold_silver_rates_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/digital_gold/get_gold_silver_rates.dart';

part 'gold_silver_rates_state.dart';

@injectable
class GoldSilverRatesCubit extends Cubit<GoldSilverRatesState> {
  final GetGoldSilverRates _getGoldSilverRates;

  GoldSilverRatesCubit(this._getGoldSilverRates) : super(GoldSilverRatesInitial());

  void fetchGoldRates() async {
    emit(GoldSilverRatesLoading());
    final res = await _getGoldSilverRates(NoParams());
    emit(res.fold((l) => GoldSilverRatesLoadError(), (r) => GoldSilverRatesLoaded(goldSilverRates: r, quantity: GoldSilverRatesQuantity.tenGram)));
  }

  void changeQuantity() {
    if (state is GoldSilverRatesLoaded) {
      final state = this.state as GoldSilverRatesLoaded;
      emit(GoldSilverRatesLoaded(
          goldSilverRates: state.goldSilverRates, quantity: state.quantity == GoldSilverRatesQuantity.tenGram ? GoldSilverRatesQuantity.oneGram : GoldSilverRatesQuantity.tenGram));
    }
  }

  void reset() {
    emit(GoldSilverRatesInitial());
  }
}
