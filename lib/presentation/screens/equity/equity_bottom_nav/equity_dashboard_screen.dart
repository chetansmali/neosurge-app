// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import '../../../../domain/repositories/token_repository.dart';
// import 'equity_home_screen.dart';
// import 'equity_invest_screen.dart';
// import 'bottom_nav.dart';
// import 'equity_payments_screen.dart';
// import 'equity_portfolio_screen.dart';

// class EquityDashboard extends HookWidget {
//   const EquityDashboard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final pageController = usePageController();
//     return Scaffold(
//       body: PageView(
//         controller: pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           EquityInvestScreens(),
//           EquityHomeScreen(),
//           const EquityPaymentsScreen(),
//           const EquityPortfolioScreen()
//         ],
//       ),
//       bottomNavigationBar: BottomNav(pageController: pageController),
//     );
//   }
// }
