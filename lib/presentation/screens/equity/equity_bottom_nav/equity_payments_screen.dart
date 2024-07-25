// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// import '../../../cubits/equity/equity_nav_cubit.dart';

// class EquityPaymentsScreen extends HookWidget {
//   const EquityPaymentsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final int paymentIndex = context.select<EquityNavCubit, int>(
//         (EquityNavCubit equityCubit) =>
//             equityCubit.state.equityNavEntity.paymentsIndex);
//     final tabController =
//         useTabController(initialLength: 2, initialIndex: paymentIndex);
//     useEffect(() {
//       tabController.addListener(() {
//         context.read<EquityNavCubit>().equityChangeTab(context
//             .read<EquityNavCubit>()
//             .state
//             .equityNavEntity
//             .copyWith(paymentsIndex: tabController.index));
//       });
//       return () {
//         tabController.removeListener(() {});
//       };
//     }, const []);
//     return BlocListener<EquityNavCubit, EquityNavState>(
//       listenWhen: (previous, current) =>
//           previous.equityNavEntity.portfolioIndex !=
//           current.equityNavEntity.portfolioIndex,
//       listener: (context, state) {
//         tabController.animateTo(state.equityNavEntity.portfolioIndex);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Payment'),
//         ),
//         body: const Center(
//           child: Text('Coming Soon'),
//         ),
//       ),
//     );
//   }
// }
