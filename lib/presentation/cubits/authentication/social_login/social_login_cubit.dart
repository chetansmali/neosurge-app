import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/authentication/social_login_params.dart';
import '../../../../domain/usecases/onboarding/social_login.dart';
import '../../util_cubits/loading_cubit.dart';

part 'social_login_state.dart';

@injectable
class SocialLoginCubit extends Cubit<SocialLoginState> {
  final LoadingCubit _loadingCubit;

  final SocialLogin _socialLogin;

  SocialLoginCubit(this._socialLogin, this._loadingCubit)
      : super(SocialLoginInitial());

  void doLogin(
      {required SocialLoginType socialLoginType,
      required String emailId,
      required String accessToken,
      required String fcmToken,
      String? authCode}) async {
    _loadingCubit.show();
    emit(SocialLoginLoading());
    final response = await _socialLogin(SocialLoginParams(
        emailId: emailId,
        socialLoginType: socialLoginType,
        accessToken: accessToken,
        fcmToken: fcmToken,
        authCode: authCode));
    response.fold(
        (l) => emit(
            SocialLoginFailure(errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(SocialLoginSuccess(user: r)));
    _loadingCubit.hide();
  }
}
