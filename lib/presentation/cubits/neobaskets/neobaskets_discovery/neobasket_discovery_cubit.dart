import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/neobaskets_discovery_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/neobaskets_discovery_params.dart';
import '../../../../domain/usecases/neobaskets/get_neobaskets.dart';

part 'neobasket_discovery_state.dart';

@injectable
class NeoBasketDiscoveryCubit extends Cubit<NeobasketDiscoveryState> {
  final GetNeoBasket _getNeoBasket;
  NeoBasketDiscoveryCubit(this._getNeoBasket)
      : super(NeobasketDiscoveryInitial());

  void getNeoBasketDiscoveryBaskets(NeobasketDiscoveryParams param) async {
    emit(NeobasketDiscoveryLoading());
    final response = await _getNeoBasket(param);

    emit(
      response.fold(
        (l) => NeobasketDiscoveryFailure(l.error, l.errorType),
        (r) => NeobasketDiscoverySuccess(r),
      ),
    );
  }
}
