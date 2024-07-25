import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../../di/get_it.dart';
import '../../cubits/authentication/login_with_email/login_with_email_cubit.dart';
import '../../cubits/authentication/mobile_otp_cubit/mobile_otp_cubit.dart';
import '../../cubits/authentication/verify_email_otp/verify_email_otp_cubit.dart';
import '../../cubits/authentication/verify_mobile_otp/verify_mobile_otp_cubit.dart';
import '../../cubits/mpin/set_mpin/set_mpin_cubit.dart';
import '../../cubits/onboarding/verify_pan/verify_pan_cubit.dart';
import '../../cubits/util_cubits/ocr_read_cubit.dart';

import '../../routes/routes.dart';
import 'sign_up/enter_mobile_screen.dart';
import 'sign_up/create_mpin_screen.dart';
import 'sign_up/verify_email_screen.dart';

import '../../routes/route_arguments.dart';
import 'sign_up/login_with_email_screen.dart';
import 'sign_up/verify_mobile_screen.dart';
import 'verify_pan_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, this.signUpArgs});

  final SignUpArgs? signUpArgs;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final PageController _pageController;

  late VerifyEmailParams _verifyEmailParams;
  late MobileNumberArgs _mobileNumberArgs;

  var _progress = 0.25;
  var _isBackBtnVisible = false;

  @override
  void initState() {
    super.initState();
    _initPageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isBackBtnVisible = _isBackButtonVisible();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_pageController.page == 0 ||
            widget.signUpArgs?.pageIndex == _pageController.page) {
          Navigator.pop(context);
        } else {
          _navigateToPreviousPage();
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Visibility(
            visible: _isBackBtnVisible,
            child: BackButton(
              onPressed: () {
                if (_pageController.page == 0 ||
                    widget.signUpArgs?.pageIndex == _pageController.page) {
                  Navigator.pop(context);
                } else {
                  _navigateToPreviousPage();
                }
              },
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(_progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      lineHeight: 6,
                      percent: _progress,
                      backgroundColor: Colors.grey[300],
                      progressColor: Colors.black,
                      barRadius: const Radius.circular(
                        10,
                      ),
                      animateFromLastPercent: true,
                      animation: true,
                      animationDuration: 1000,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return BlocProvider(
                            create: (context) => getIt<LoginWithEmailCubit>(),
                            child: LoginWithEmailScreen(
                              onSuccess: (verifyEmailParams) {
                                _verifyEmailParams = verifyEmailParams;
                                _navigateToNextPage();
                              },
                            ),
                          );

                        case 1:
                          return BlocProvider(
                            create: (context) => getIt<VerifyEmailOtpCubit>(),
                            child: VerifyEmailScreen(
                              verifyEmailParams: VerifyEmailParams(
                                emailId: _verifyEmailParams.emailId,
                                loginWithEmailResponseModel: _verifyEmailParams
                                    .loginWithEmailResponseModel,
                              ),
                              onSuccessfulVerification: () {
                                if (context
                                        .read<AuthCubit>()
                                        .state
                                        .user!
                                        .mPin !=
                                    null) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.mPinFpLogin,
                                    (route) => false,
                                  );
                                } else {
                                  _navigateToNextPage();
                                }
                              },
                            ),
                          );
                        case 2:
                          return BlocProvider(
                            create: (context) => getIt<SetMPinCubit>(),
                            child: CreateMPinScreen(
                              onSuccess: () {
                                _navigateToNextPage();
                              },
                            ),
                          );
                        case 3:
                          return BlocProvider(
                            create: (context) => getIt<MobileOtpCubit>(),
                            child: EnterMobileScreen(
                              onSuccess: (mobileNumberArgs) {
                                _mobileNumberArgs = mobileNumberArgs;
                                _navigateToNextPage();
                              },
                            ),
                          );
                        case 4:
                          return BlocProvider(
                            create: (context) => getIt<VerifyMobileOtpCubit>(),
                            child: VerifyMobileScreen(
                              mobileNumber: _mobileNumberArgs.mobileNumber,
                              onSuccess: () {
                                _navigateToNextPage();
                              },
                            ),
                          );
                        case 5:
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => getIt<VerifyPanCubit>(),
                              ),
                              BlocProvider(
                                create: (context) => getIt<OcrReadCubit>(),
                              ),
                            ],
                            child: const VerifyPanScreen(),
                          );

                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage() async {
    if (_pageController.page == 1) {
      setState(() {
        _progress = 0.5;
      });
    } else if (_pageController.page == 2) {
      setState(() {
        _progress = 0.75;
      });
    } else if (_pageController.page == 4) {
      setState(() {
        _progress = 1;
      });
    }
    await _pageController.animateToPage(
      _pageController.page!.toInt() + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      _isBackBtnVisible = _isBackButtonVisible();
    });
  }

  void _navigateToPreviousPage() async {
    if (_pageController.page == 2) {
      setState(() {
        _progress = 0.25;
      });
    } else if (_pageController.page == 3) {
      setState(() {
        _progress = 0.5;
      });
    } else if (_pageController.page == 4) {
      setState(() {
        _progress = 0.75;
      });
    }

    if (_pageController.page == 2 || _pageController.page == 5) {
      await _pageController.animateToPage(
        _pageController.page!.toInt() - 2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await _pageController.animateToPage(
        _pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    setState(() {
      _isBackBtnVisible = _isBackButtonVisible();
    });
  }

  void _initPageController() {
    var page = widget.signUpArgs?.pageIndex ?? 0;
    _pageController = PageController(
      initialPage: page,
    );

    if (page == 2) {
      _progress = 0.5;
    } else if (page == 3) {
      _progress = 0.75;
    } else if (page == 5) {
      _progress = 1;
    }
  }

  bool _isBackButtonVisible() {
    switch (_pageController.page) {
      case 0:
        return Navigator.canPop(context);
      case 1:
        return true;
      case 2:
      case 3:
        return false;
      case 4:
        return true;

      default:
        return false;
    }
  }
}
