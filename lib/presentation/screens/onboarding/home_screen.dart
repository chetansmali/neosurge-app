import 'dart:async';
import 'dart:io';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../common/common.dart';
import '../../../domain/entities/enums.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/login_with_apple/login_with_apple_cubit.dart';
import '../../cubits/authentication/login_with_google/login_with_google_cubit.dart';
import '../../cubits/authentication/social_login/social_login_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'assets/pngs/onboading_login_bg.png',
    'assets/pngs/onboading_login_bg2.png',
    'assets/pngs/onboading_login_bg3.png',
    'assets/pngs/onboading_login_bg4.png',
    'assets/pngs/onboading_login_bg5.png',
    'assets/pngs/onboading_login_bg6.png',
    'assets/pngs/onboading_login_bg7.png',
  ];
  int currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  images[currentIndex],
                ),
                fit: BoxFit.cover),
          ),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(50),
                    Row(
                      children: [
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const Gap(4),
                        Assets.pngs.onboardingLoginHand
                            .image(height: 50, width: 50),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      'Log in to your account',
                      style: baseTextStyle16400.copyWith(
                          color: AppColors.primaryWhite),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 120,
                      width: 120,
                      padding: const EdgeInsets.all(28.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(
                            color: Colors.white54,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white54.withOpacity(0.1),
                              spreadRadius: 4,
                              blurRadius: 4,
                            )
                          ]),
                      child: Assets.svgs.onboardingLoginNeoLogo
                          .svg(height: 40, width: 40))),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                ),
                child: const Column(
                  children: [
                    _SignInButtons(),
                    Gap(40),
                    TermsAndConditionText(),
                    Gap(8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInButtons extends StatelessWidget {
  const _SignInButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginWithGoogleCubit, LoginWithGoogleState>(
          listener: (context, state) async {
            final fcmToken = await FirebaseMessaging.instance.getToken();
            // print('FCM Token: $fcmToken');
            if (state is LoginWithGoogleSuccess) {
              //ignore:use_build_context_synchronously
              context.read<SocialLoginCubit>().doLogin(
                    socialLoginType: SocialLoginType.google,
                    emailId: state.googleSignInAccount.email,
                    accessToken: state.accessToken,
                    fcmToken: fcmToken ?? '',
                  );
            }
            if (state is LoginWithGoogleFailure) {
              //ignore:use_build_context_synchronously
              Utils.showErrorAlert(
                context,
                state.error,
              );
            }
          },
        ),
        BlocListener<SocialLoginCubit, SocialLoginState>(
          listener: (context, state) {
            if (state is SocialLoginSuccess) {
              // Send the user id to Crashlytics so that it can be used to filter
              // crashes based on the currently logged in user.
              FirebaseCrashlytics.instance.setUserIdentifier(
                state.user.id.toString(),
              );

              Sentry.configureScope(
                (p0) => p0.setUser(
                  SentryUser(
                    id: state.user.id.toString(),
                    email: state.user.emailId,
                    username: state.user.userName,
                  ),
                ),
              );

              if (kReleaseMode) {
                final Amplitude analytics = Amplitude.getInstance();

                analytics.setUserProperties(
                  {
                    'user_id': state.user.id.toString(),
                    'email': state.user.emailId,
                  },
                );
              }
              /*We are pushing to initial route because it will do the
                             check for where the user
                            is coming from and will redirect to the appropriate route*/
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.initial,
                (route) => false,
                arguments: 0,
              );
            }
            if (state is SocialLoginFailure) {
              Utils.showErrorAlert(
                context,
                Utils.getErrorMessage(
                  errorType: state.errorType,
                  msg: state.errorMessage,
                ),
              );
            }
          },
        ),
        BlocListener<LoginWithAppleCubit, LoginWithAppleState>(
          listener: (context, state) {
            if (state is LoginWithAppleSuccess) {
              context.read<SocialLoginCubit>().doLogin(
                    socialLoginType: SocialLoginType.apple,
                    emailId: state.appleSignInAccount.email ?? '',
                    accessToken: state.appleSignInAccount.identityToken ?? '',
                    authCode: state.appleSignInAccount.authorizationCode,
                    fcmToken: '',
                  );
            }
            if (state is LoginWithAppleFailure) {
              Utils.showErrorAlert(
                context,
                state.error,
              );
            }
          },
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                //bypass social login if needed by passing the email to be logged in directly
                context.read<LoginWithGoogleCubit>().login();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF47586E),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                minimumSize: const Size(double.infinity, 54),
                maximumSize: const Size(double.infinity, 54),
                elevation: 0.5,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 20,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.svgs.googleLogo.svg(),
                  const Gap(8),
                  Text(
                    'Continue with Google',
                    style: baseTextStyle14500,
                  ),
                ],
              ),
            ),
            if (Platform.isIOS) ...[
              const Gap(16),
              ElevatedButton(
                onPressed: () async {
                  //bypass social login if needed by passing the email to be logged in directly
                  context.read<LoginWithAppleCubit>().login();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  maximumSize: const Size(double.infinity, 54),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  elevation: 2,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 20,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.svgs.appleLogo.svg(),
                    const Gap(8),
                    Text(
                      'Continue with Apple ID',
                      style: baseTextStyle14500,
                    ),
                  ],
                ),
              ),
            ],
            const Gap(16),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.signUp,
                  );
                },
                child: const Text(
                  'Continue with email',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textLightGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
