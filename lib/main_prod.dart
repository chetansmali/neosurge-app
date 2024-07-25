import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'app.dart';
import 'config_main.dart';
import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.PROD;
  await configMain();

  runZonedGuarded(
    () {
      if (kReleaseMode) {
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        SentryFlutter.init(
          (options) {
            options.dsn =
                'https://15873d9085441a888a450987269ff41e@us.sentry.io/4506699829673984';
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0;
          },
        );
      }

      runApp(const BullSurgeApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    ),
  );
}
