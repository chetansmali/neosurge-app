import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../animators/slide_fade_animator.dart';
import '../cubits/authentication/auth/auth_cubit.dart';
import '../routes/route_arguments.dart';
import '../routes/routes.dart';
import '../widgets/gradient_text.dart';
import '../widgets/neo_logo.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
    this.delay,
  }) : super(key: key);

  final int? delay;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool flag = false;

  @override
  void initState() {
    super.initState();
    // After 2 seconds, update the firstText
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        flag = !flag;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: context.read<AuthCubit>()
          ..checkForUpdate(
            delay: widget.delay,
          ),
        listener: (context, state) {
          if (state is UpdateApp) {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => updateAppBottomSheet(
                appVersionResult: state.appVersionUpdateResult,
              ),
              enableDrag: false,
              isDismissible: false,
              isScrollControlled: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            );
          }

          if (state is Authenticated) {
            if (!state.user!.isEmailIdVerified) {
              Navigator.pushReplacementNamed(
                context,
                Routes.signUp,
                arguments: const SignUpArgs(
                  pageIndex: 1,
                ),
              );
            } else if (state.user!.mPin == null) {
              Navigator.pushReplacementNamed(
                context,
                Routes.signUp,
                arguments: const SignUpArgs(
                  pageIndex: 2,
                ),
              );
            } else if (!state.user!.isMobileNumberVerified) {
              Navigator.pushReplacementNamed(
                context,
                Routes.signUp,
                arguments: const SignUpArgs(
                  pageIndex: 3,
                ),
              );
            } else if (!(state.user!.panVerified ?? false)) {
              Navigator.pushReplacementNamed(
                context,
                Routes.signUp,
                arguments: const SignUpArgs(
                  pageIndex: 5,
                ),
              );
            } else {
              Navigator.pushReplacementNamed(context, Routes.mPinFpLogin);
            }
          }
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, Routes.onboarding);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.delay == 0
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Container(),
            // Assets.gifs.splashLogo.image(
            //   height: 200,
            //   width: 200,
            //   fit: BoxFit.contain,
            // ),
            const Gap(4),
            Center(
              child: flag
                  ? const Column(
                      children: [
                        SlideFadeAnimator(
                          child: NeoLogo(
                            height: 60,
                          ),
                        ),
                        Gap(2),
                        SlideFadeAnimator(
                          delay: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'neo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              GradientText(
                                'surge',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF39AAF3),
                                    Color(0xFF326CF9),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const SlideFadeAnimator(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'hello,',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              GradientText(
                                ' we’re',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF39AAF3),
                                    Color(0xFF326CF9),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  updateAppBottomSheet({
    required appVersionResult,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'New Update Available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
              'A new version of the app is available. Please update to the latest version to continue using the app.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(height: 16 * 2),
          ElevatedButton(
            onPressed: () {
              launchUrl(
                Uri.parse(
                  appVersionResult!.storeUrl ??
                      'https://play.google.com/store/apps/details?id=com.neosurge.neosurge',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }
}
