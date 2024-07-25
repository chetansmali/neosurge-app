import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/gold_user.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/digital_gold/get_gold_user.dart';

part 'gold_user_state.dart';

@injectable
class GoldUserCubit extends Cubit<GoldUserState> {
  final GetGoldUser _getGoldUser;

  GoldUserCubit(this._getGoldUser) : super(GoldUserInitial());

  void loadGoldUser() async {
    emit(GoldUserLoading());
    final response = await _getGoldUser(NoParams());
    emit(response.fold((l) => GoldUserLoadError(errorType: l.errorType, errorMessage: l.error), (r) => GoldUserLoaded(r)));
  }

  void reset() {
    emit(GoldUserInitial());
  }
}
