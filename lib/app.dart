import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/cubits/equity/equity_nav_cubit.dart';

import 'common/app_keys.dart';
import 'di/get_it.dart';
import 'flavors.dart';
import 'presentation/cubits/authentication/auth/auth_cubit.dart';
import 'presentation/cubits/digital_gold/gold_silver_rates/gold_silver_rates_cubit.dart';
import 'presentation/cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import 'presentation/cubits/util_cubits/loading_cubit.dart';
import 'presentation/cubits/util_cubits/nav_cubit.dart';
import 'presentation/cubits/util_cubits/network/network_cubit.dart';
import 'presentation/routes/route_generator.dart';
import 'presentation/routes/routes.dart';
import 'presentation/theme/app_theme.dart';

class BullSurgeApp extends StatefulWidget {
  const BullSurgeApp({Key? key}) : super(key: key);

  @override
  State<BullSurgeApp> createState() => _BullSurgeAppState();
}

class _BullSurgeAppState extends State<BullSurgeApp> {
  late final RouteGenerator _routeGenerator;

  @override
  void initState() {
    super.initState();
    _routeGenerator = getIt<RouteGenerator>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<LoadingCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<GoldUserCubit>()..loadGoldUser(),
        ),
        BlocProvider(
          create: (_) => getIt<GoldSilverRatesCubit>()..fetchGoldRates(),
        ),
        BlocProvider(
          create: (_) => getIt<NavCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<NetworkCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<EquityNavCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'BullSurge',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return _flavorBanner(child: child!, show: F.appFlavor != Flavor.PROD);
        },
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        onGenerateRoute: _routeGenerator.generateRoute,
        initialRoute: Routes.initial,
      ),
    );
  }

  @override
  void dispose() {
    _routeGenerator.dispose();
    super.dispose();
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
