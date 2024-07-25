import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../common/custom_styles.dart';
import '../../../common/utils.dart';
import '../../../core/local_auth_api.dart';
import '../../../data/models/user/user.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/mpin/mpin_login/mpin_login_cubit.dart';
import '../../routes/routes.dart';
import '../loading_screen.dart';

class MPinFpLoginScreen extends StatefulWidget {
  const MPinFpLoginScreen({Key? key}) : super(key: key);

  @override
  State<MPinFpLoginScreen> createState() => _MPinFpLoginScreenState();
}

class _MPinFpLoginScreenState extends State<MPinFpLoginScreen> {
  late final TextEditingController _pinController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final User _user;
  bool _shouldEnableBiometric = false;
  bool _mpinError = false;
  String _mpinErrorString = '';

  final List<String> images = [
    'assets/pngs/onboading_login_bg.png',
    'assets/pngs/onboading_login_bg2.png',
    'assets/pngs/onboading_login_bg3.png',
    'assets/pngs/onboading_login_bg4.png',
    'assets/pngs/onboading_login_bg5.png',
    'assets/pngs/onboading_login_bg6.png',
    'assets/pngs/onboading_login_bg7.png',
  ];
  int currentImageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _user = context.read<AuthCubit>().state.user!;
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % images.length;
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (_user.isBiometricEnabled) {
      _shouldEnableBiometric = true;
      _authenticateViaBiometric();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MPinLoginCubit, MPinLoginState>(
          listener: (context, state) {
            if (state is MPinLoginSuccess) {
              final User? oldUser = context.read<AuthCubit>().state.user;
              User user = state.user;
              if (_shouldEnableBiometric) {
                user = user.copyWith(isBiometricEnabled: true);
              }
              context.read<AuthCubit>().updateUser(user.copyWith(
                  showGoldDisclaimer: oldUser?.showGoldDisclaimer ?? true));

              _handlePageRoute();
              return;
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              Fluttertoast.showToast(
                  msg: Utils.getErrorMessage(
                      errorType: state.errorType, msg: state.message));
            }
            if (state is Authenticated && state.serverAuthenticated) {
              _handlePageRoute();
            }
          },
        ),
      ],
      child: LoadingScreen(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  images[currentImageIndex],
                ),
                fit: BoxFit.cover),
          ),
          curve: Curves.easeInOut,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _GlassEffectContainer(
                            padding: const EdgeInsets.all(8.0),
                            child: Assets.svgs.neoLogo.svg(
                              height: 32.0,
                              width: 32.0,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Welcome Back 👋🏻!',
                            style: baseTextStyle24600.copyWith(
                                color: Colors.white),
                          ),
                          const Gap(8),
                          Text(
                            _mpinErrorString.isNotEmpty
                                ? _mpinErrorString
                                : 'Enter your MPIN',
                            style: baseTextStyle16400.copyWith(
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          BlocConsumer<MPinLoginCubit, MPinLoginState>(
                            listener: (context, state) {
                              if (state is MPinLoginFailure) {
                                setState(() {
                                  _mpinError = true;
                                  _mpinErrorString = state.errorMessage ?? '';
                                });
                              }
                              if (state is MPinLoginInitial ||
                                  state is MPinLoginLoading) {
                                setState(() {
                                  _mpinError = false;
                                  _mpinErrorString = '';
                                });
                              }
                              if (state is MPinLoginSuccess) {
                                setState(() {
                                  _mpinError = false;
                                  _mpinErrorString = '';
                                });
                              }
                            },
                            builder: (context, state) {
                              return Pinput(
                                controller: _pinController,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                autofocus: true,
                                length: 4,
                                obscureText: true,
                                onCompleted: (String pin) {
                                  final phoneNumber = _user.mobileNumber!;
                                  context.read<MPinLoginCubit>().loginWithMPin(
                                        mPin: pin,
                                        phoneNumber: phoneNumber,
                                      );
                                },
                                defaultPinTheme:
                                    CustomStyles.defaultLoginPinTheme,
                                forceErrorState: state is MPinLoginFailure,
                                onChanged: (_) {
                                  if (state is MPinLoginFailure) {
                                    context.read<MPinLoginCubit>().reset();
                                  }
                                },
                                errorText: state is MPinLoginFailure
                                    ? Utils.getErrorMessage(
                                        errorType: state.errorType,
                                        msg: state.errorMessage)
                                    : null,
                                errorBuilder: (context, error) =>
                                    const SizedBox(),
                                errorPinTheme: CustomStyles.errorLoginPinTheme,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your PIN';
                                  }
                                  if (value.length != 4) {
                                    return 'Please enter a valid PIN';
                                  }
                                  return null;
                                },
                                focusedPinTheme:
                                    CustomStyles.focusedLoginPinTheme,
                                showCursor: true,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                cursor: CustomStyles.pinPutCursor,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                              );
                            },
                          ),
                          const Gap(24),
                          if (!_shouldEnableBiometric)
                            Text('OR',
                                style: baseTextStyle14500.copyWith(
                                    color: Colors.white)),
                          if (!_shouldEnableBiometric) const Gap(24),
                          if (!_shouldEnableBiometric)
                            _GlassEffectContainer(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.fingerprint_rounded,
                                    color: Colors.white,
                                  ),
                                  _user.isBiometricEnabled
                                      ? TextButton(
                                          onPressed: _authenticateViaBiometric,
                                          child: Text('Use Biometric Unlock',
                                              style:
                                                  baseTextStyle14500.copyWith(
                                                      color: Colors.white)),
                                        )
                                      : !_shouldEnableBiometric
                                          ? TextButton(
                                              onPressed: () {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Biometric unlock will be enabled from next login');
                                                setState(() =>
                                                    _shouldEnableBiometric =
                                                        true);
                                              },
                                              child: Text(
                                                  'Enable Biometric Unlock',
                                                  style: baseTextStyle14500
                                                      .copyWith(
                                                          color: Colors.white)),
                                            )
                                          : const SizedBox()
                                ],
                              ),
                            ),
                          if (!_shouldEnableBiometric) const Gap(16),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, Routes.forgotMPinOtp),
                            child: Text('Forgot your PIN?',
                                style: baseTextStyle14500.copyWith(
                                    color: Colors.white)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.logout,
                                (route) => false,
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Logout',
                                    style: baseTextStyle14500.copyWith(
                                        color: Colors.white)),
                                const Gap(4),
                                const Icon(
                                  Icons.power_settings_new_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _authenticateViaBiometric() async {
    if (!mounted) return;
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated && mounted) {
      context.read<AuthCubit>().getServerUser();
    } else {
      if (mounted) {
        Utils.showErrorAlert(context, "Failed to authenticate");
      }
    }
  }

  void _handlePageRoute() {
    if (_user.userName != null) {
      Fluttertoast.showToast(msg: "Welcome ${_user.userName}");
    }
    if (_user.isOnBoardingCompleted || _user.eSignSubmitDone) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.dashboard, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.dashboard, (route) => false);
    }
  }
}

class _GlassEffectContainer extends StatelessWidget {
  const _GlassEffectContainer({
    required this.child,
    required this.padding,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.06),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          width: padding == EdgeInsets.zero ? double.infinity : null,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
