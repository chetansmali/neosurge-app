// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// import '../../../cubits/equity/equity_nav_cubit.dart';

// class EquityPortfolioScreen extends HookWidget {
//   const EquityPortfolioScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final int portfolioIndex = context.select<EquityNavCubit, int>(
//             (EquityNavCubit equityCubit) =>
//         equityCubit.state.equityNavEntity.portfolioIndex);
//     final tabController =
//     useTabController(initialLength: 2, initialIndex: portfolioIndex);
//     useEffect(() {
//       tabController.addListener(() {
//         context.read<EquityNavCubit>().equityChangeTab(context
//             .read<EquityNavCubit>()
//             .state
//             .equityNavEntity
//             .copyWith(portfolioIndex: tabController.index));
//       });
//       return () {
//         tabController.removeListener(() {});
//       };
//     }, const []);
//     return BlocListener<EquityNavCubit, EquityNavState>(
//       listenWhen: (previous, current) =>
//       previous.equityNavEntity.paymentsIndex !=
//           current.equityNavEntity.paymentsIndex,
//       listener: (context, state) {
//         tabController.animateTo(state.equityNavEntity.paymentsIndex);
//       },
//       child:Scaffold(
//         appBar: AppBar(
//           title: const Text('Portfolio'),
//           centerTitle: true,
//         ),
//       ),
//     );
//   }
// }
