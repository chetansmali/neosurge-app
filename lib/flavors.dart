import 'core/api/api_constants.dart';

enum Flavor {
  DEV,
  STAGING,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Neosurge Dev';
      case Flavor.STAGING:
        return 'Neosurge Staging';
      case Flavor.PROD:
        return 'Neosurge';
      default:
        return 'title';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return ApiConstants.baseDevUrl;
      case Flavor.STAGING:
        return ApiConstants.baseDevUrl;
      case Flavor.PROD:
        return ApiConstants.baseProdUrl;
      default:
        return ApiConstants.baseDevUrl;
    }
  }
}
