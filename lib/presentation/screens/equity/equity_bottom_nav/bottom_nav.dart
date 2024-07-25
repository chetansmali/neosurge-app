// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// import '../../../../gen/assets.gen.dart';
// import '../../../cubits/equity/equity_nav_cubit.dart';
// import '../../../theme/app_colors.dart';

// class BottomNav extends StatelessWidget {
//   final PageController pageController;
//   const BottomNav({super.key, required this.pageController});

//   @override
//   Widget build(BuildContext context) {
//     return KeyboardVisibilityBuilder(
//       builder: (_, isVisible) => isVisible
//           ? const SizedBox.shrink()
//           : BlocConsumer<EquityNavCubit, EquityNavState>(
//         listenWhen: (previous, current) =>
//         previous.equityNavEntity.mainTabIndex !=
//             current.equityNavEntity.mainTabIndex,
//         listener: (context, state) {
//           pageController.animateToPage(
//             state.equityNavEntity.mainTabIndex,
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.ease,
//           );
//         },
//         buildWhen: (previous, current) =>
//         current.equityNavEntity.mainTabIndex !=
//             previous.equityNavEntity.mainTabIndex,
//         builder: (context, state) {
//           return BottomNavigationBar(
//             selectedItemColor: AppColors.mainBlack,
//             type: BottomNavigationBarType.fixed,
//             selectedLabelStyle: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 10,
//               color: AppColors.mainBlack,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 10,
//               color: AppColors.mainBlack,
//             ),
//             currentIndex: state.equityNavEntity.mainTabIndex,
//             onTap: (index) {
//               HapticFeedback.mediumImpact();
//               context.read<EquityNavCubit>().equityChangeTab(context
//                   .read<EquityNavCubit>()
//                   .state
//                   .equityNavEntity
//                   .copyWith(mainTabIndex: index));
//               pageController.animateToPage(
//                 index,
//                 duration: const Duration(milliseconds: 400),
//                 curve: Curves.ease,
//               );
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavHome.svg(),
//                 ),
//                 activeIcon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavHome.svg(),
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavInvest.svg(),
//                 ),
//                 activeIcon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavInvest.svg(),
//                 ),
//                 label: 'Invest',
//               ),
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavPayment.svg(),
//                 ),
//                 activeIcon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavPayment.svg(),
//                 ),
//                 label: 'Payments',
//               ),
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavProtfolio.svg(),
//                 ),
//                 activeIcon: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Assets.icons.equityBotnavProtfolio.svg(),
//                 ),
//                 label: 'Portfolio',
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
