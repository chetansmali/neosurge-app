import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/custom_appbar.dart';
import '../credit/credit_screen.dart';
import '../invest/invest_screen.dart';
import '../logged_in_home/logged_in_home.dart';
import '../my_portfolio/my_portfolio_screen.dart';

class DashboardScreen extends HookWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(
      initialPage: 2,
    );
    final currentBackPressTime = useRef<DateTime?>(null);

    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime.value == null ||
          now.difference(currentBackPressTime.value!) >
              const Duration(seconds: 1)) {
        currentBackPressTime.value = now;
        Fluttertoast.showToast(
          msg: 'Press back again to exit Neosurge',
        );
        return Future.value(false);
      }
      //exit the app

      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            CreditScreen(),
            SizedBox(),
            LoggedInHome(),
            InvestScreen(),
            MyPortfolioScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          pageController: pageController,
        ),
      ),
    );
  }
}
