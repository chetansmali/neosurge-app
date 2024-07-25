import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../data/models/lamf/get_loan_user_details.dart';
import '../../../di/get_it.dart';
import '../../cubits/lamf/lamf_avail_loans/lamf_avail_loan_cubit.dart';
import '../../cubits/lamf/lamf_get_credit_limit/lamf_get_credit_limit_cubit.dart';
import '../../cubits/lamf/lamf_get_loan_data/lamf_get_loan_data_cubit.dart';
import '../../cubits/lamf/lamf_initiate_payment/lamf_initiate_payment_cubit.dart';
import '../../cubits/lamf/lamf_initiate_withdrawl/lamf_initiate_withdrawal_cubit.dart';
import '../../cubits/lamf/get_initiate_import_loans/get_initiate_import_loans_cubit.dart';
import '../../routes/routes.dart';
import 'widgets/check_credit_limit.dart';
import 'widgets/import_loans_consent_bottom_sheet.dart';
import 'widgets/custom_expansion_tile.dart';
import 'widgets/features_banner.dart';
import 'widgets/how_it_works.dart';

import '../../../common/custom_styles.dart';
import '../../../gen/assets.gen.dart';

class LAMFScreen extends StatelessWidget {
  const LAMFScreen({
    Key? key,
    required this.loanUser,
  }) : super(key: key);
  final bool isLoansImported = false;
  final GetLoanUserDetails loanUser;

  @override
  Widget build(BuildContext context) {
    List<Widget> listFeatures = [
      const FeatureBanner(
        title: 'Pay interest only on the amount borrowed',
        blueTexts: ['interest', 'borrowed'],
      ),
      const FeatureBanner(
        title: 'Interest rates lower than personal loans',
        blueTexts: ['lower'],
      ),
      const FeatureBanner(
        title: 'Retain dividends',
        blueTexts: ['dividends'],
      ),
      const FeatureBanner(
        title: 'Interest rates lower than personal loans',
        blueTexts: ['lower'],
      ),
      const FeatureBanner(
          title: 'You do not have to liquidate your funds',
          blueTexts: ['liquidate']),
      const FeatureBanner(title: 'Retain dividends', blueTexts: ['dividends']),
      const FeatureBanner(
          title: 'You do not have to liquidate your funds',
          blueTexts: ['liquidate']),
      const FeatureBanner(
          title: 'Pay interest only on the amount borrowed',
          blueTexts: ['interest', 'borrowed']),
      const FeatureBanner(title: 'Retain dividends', blueTexts: ['dividends']),
      const FeatureBanner(
          title: 'Pay interest only on the amount borrowed',
          blueTexts: ['interest', 'borrowed']),
      const FeatureBanner(
          title: 'Interest rates lower than personal loans',
          blueTexts: ['lower']),
      const FeatureBanner(title: 'Retain dividends', blueTexts: ['dividends']),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(12.0),
              (loanUser.loansImported != null)
                  ? (loanUser.loansImported!)
                      ? const SizedBox.shrink()
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFBEDCFF),
                            ),
                            color: const Color(0xFFEAF4FF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    const Gap(20),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        Assets.pngs.cash.path.toString(),
                                        height: 80,
                                        width: 60,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'One Tap, all loans!',
                                      style: baseTextStyle16500,
                                    ),
                                    const Gap(5),
                                    Text(
                                      'Aggregate all bank loans in a single click',
                                      style: baseTextStyle12400.copyWith(
                                        color: const Color(0xFF727579),
                                      ),
                                    ),
                                    const Gap(25),
                                    SizedBox(
                                      width: 180,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(30),
                                              ),
                                            ),
                                            context: context,
                                            builder: (_) {
                                              return BlocProvider(
                                                create: (context) => getIt<
                                                    GetInitiateImportLoansCubit>(),
                                                child:
                                                    const ImportLoansConsentBottomSheet(),
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0.5,
                                          backgroundColor: Colors.white,
                                        ),
                                        child: const Text(
                                          'Import loans',
                                          style: TextStyle(
                                            color: Color(0xFF2E8EFF),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                  : const SizedBox.shrink(),

              const Gap(24),

              (loanUser.mfImported!)
                  ? MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (BuildContext context) =>
                              getIt<LamfInitiateWithdrawalCubit>(),
                        ),
                        BlocProvider(
                          create: (BuildContext context) =>
                              getIt<LamfInitiatePaymentCubit>(),
                        ),
                        BlocProvider(
                          create: (BuildContext context) =>
                              getIt<LamfGetCreditLimitCubit>(),
                        ),
                        BlocProvider(
                          create: (BuildContext context) =>
                              getIt<LamfGetLoanDataCubit>()..lamfGetLoanData(),
                        ),
                        BlocProvider(
                          create: (BuildContext context) =>
                              getIt<LamfAvailLoanCubit>()..availLoans(),
                        ),
                      ],
                      child: CheckCreditLimit(
                        creditPulled: loanUser.creditPulled!,
                        creditLimit: loanUser.creditLimit.toString(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                const Gap(5),
                                Text(
                                  'Introducing Loan Against Mutual Funds',
                                  style: baseTextStyle16500,
                                ),
                              ],
                            ),
                            RotatedBox(
                              quarterTurns: 1,
                              child: Assets.animations.sparkle.lottie(),
                            ),
                          ],
                        ),
                        const Gap(8),
                        Text(
                          'With Neosurge, you can now liquidate your mutual funds',
                          style: baseTextStyle12400.copyWith(
                              color: const Color(0xFF9EA0A3)),
                        ),
                        const Gap(20),
                        const ElevatedButton(
                          onPressed: null,
                          child: Text('Check credit limit'),
                        ),
                        const Gap(8),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No mutual funds imported. ',
                                style: baseTextStyle10400.copyWith(
                                    color: const Color(0xFF9EA0A3)),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    await Navigator.of(context).pushNamed(
                                        Routes.importExternalFundsPan);
                                  },
                                  child: Text(
                                    'Import now >',
                                    style: baseTextStyle12400.copyWith(
                                        color: const Color(0xFF2E8EFF)),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),

              const Gap(40),
              const HowItWorks(),
              const Gap(40),
              Text('What it offers for you', style: baseTextStyle18500),
              const Gap(26),
              // slider

              CarouselSlider(
                  items: listFeatures,
                  options: CarouselOptions(
                    clipBehavior: Clip.none,
                    height: 110.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.5,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.15,
                    scrollDirection: Axis.horizontal,
                  )),

              const Gap(10),
              Text('FAQs', style: baseTextStyle18500),
              const Gap(12),
              const CustomExpansionTile(
                title: 'What is Loan Against Mutual Funds (LAMF)?',
                description:
                    'Through LAMF, you offer mutual funds as collateral to the loan provider who holds it as a security till the loan amount is repaid.',
              ),
              const CustomExpansionTile(
                title: 'Can I sell the pledged Mutual Funds?',
                description:
                    'Through LAMF, you offer mutual funds as collateral to the loan provider who holds it as a security till the loan amount is repaid.',
              ),
              const CustomExpansionTile(
                title: 'How is LAMF different from personal loans?',
                description:
                    'Through LAMF, you offer mutual funds as collateral to the loan provider who holds it as a security till the loan amount is repaid.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
