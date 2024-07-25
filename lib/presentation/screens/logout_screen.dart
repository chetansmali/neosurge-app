import 'package:amplitude_flutter/amplitude.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../cubits/authentication/auth/auth_cubit.dart';
import '../cubits/digital_gold/gold_silver_rates/gold_silver_rates_cubit.dart';
import '../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../cubits/equity/equity_nav_cubit.dart';
import '../cubits/util_cubits/nav_cubit.dart';
import '../routes/routes.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    super.initState();

    _logout();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void _logout() async {
    bool isSignedIn = await GoogleSignIn().isSignedIn();
    if (isSignedIn) {
      await GoogleSignIn().signOut();
    }
    if (!mounted) return;
    await context.read<AuthCubit>().logout();
    //Remove the current user from firebase crashlytics
    await FirebaseCrashlytics.instance.setUserIdentifier('');

    await Sentry.configureScope(
      (p0) async => await p0.setUser(null),
    );

    if (kReleaseMode) {
      final Amplitude analytics = Amplitude.getInstance();

      await analytics.setUserProperties({});
    }

    Fluttertoast.showToast(msg: 'Logged out successfully');
    if (!mounted) return;
    context.read<GoldSilverRatesCubit>().reset();
    context.read<GoldUserCubit>().reset();
    context.read<NavCubit>().resetTabStates();
    context.read<EquityNavCubit>().equityResetTabState();
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }
}
