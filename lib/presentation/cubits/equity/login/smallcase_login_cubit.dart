import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/login/smallcase_login.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/ligin/smallcase_login.dart';
import '../../../../domain/usecases/equity/get_smallcase_login.dart';

part 'smallcase_login_state.dart';

@injectable
class SmallcaseLoginCubit extends Cubit<SmallcaseLoginState> {
  final GetSmallcaseLogin getSmallcaseLogin;

  SmallcaseLoginCubit(this.getSmallcaseLogin) : super(SmallcaseLoginInitial());

  Future fetchSmallcaseLogin(SmallCaseLoginParams params) async {
    emit(SmallcaseLoginLoading());
    final response = await getSmallcaseLogin(params);
    response.fold(
      (l) => emit(
        SmallcaseLoginFailure(errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(
        SmallcaseLoginSuccess(smallCaseLoginModel: r),
      ),
    );
  }
}
