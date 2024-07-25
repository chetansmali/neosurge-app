// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../../../gen/assets.gen.dart';

// import '../component/equity_custom_checkbox.dart';

// class EquityLoginReuser extends StatefulWidget {
//   const EquityLoginReuser({super.key});

//   @override
//   State<EquityLoginReuser> createState() => _EquityLoginReuserState();
// }

// class _EquityLoginReuserState extends State<EquityLoginReuser> {
//   final List<Widget> imageList = [
//     Assets.pngs.equityZerodhaBroker.image(),
//     Assets.pngs.equityUpstoxBroker.image(),
//     Assets.pngs.equityTrustlineBroker.image(),
//     Assets.pngs.equityNuvamaBroker.image(),
//     Assets.pngs.equityMotilalBroker.image(),
//     Assets.pngs.equityKotakBroker.image(),
//     Assets.pngs.equityIcicBroker.image(),
//     Assets.pngs.equityHdfcBroker.image(),
//     Assets.pngs.equityGrowwBroker.image(),
//     Assets.pngs.equityFundzbazarBroker.image(),
//     Assets.pngs.equityFisdomBroker.image(),
//   ];

//   final PageController _pageController = PageController();
//   bool isSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login with your broker'),
//         centerTitle: true,
//         actions: [TextButton(onPressed: () {}, child: const Text('skip'))],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text('Choose the broker you previously linked to '),
//           const Gap(16),
//           // Expanded(
//           //   child: ImageGridView(
//           //     pageController: _pageController,
//           //     currentPage: _currentPage,
//           //     isSelected: isSelected,
//           //     brokerList: [],
//           //   ),
//           // ),
//           const Gap(60),
//           const CheckboxWithText(),
//           const Gap(27),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: isSelected ? Colors.grey : null,
//               fixedSize: const Size(335, 56),
//             ),
//             child: const Text('Continue'),
//           ),
//           const Gap(16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(' Don\'t have a broker?'),
//               TextButton(
//                   onPressed: () {}, child: const Text('Create a account')),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
