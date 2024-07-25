import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../common/custom_styles.dart';
import '../../../data/models/transaction_data.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/goal_planning/create_goal_investment_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/goal_planning/create_goal_investements_cubit.dart';
import '../../cubits/goal_planning/get_goal_planning_dashboard_data_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_shimmer.dart';
import '../profile/widgets/list_icon.dart';
import 'invest_goals_cards_screen.dart';

const double _size = 24;

class MFTransactionStatusScreen extends StatefulWidget {
  final MfTransactionStatus mfTransactionStatus;
  final MFTransactionTypes transactionType;

  const MFTransactionStatusScreen({
    Key? key,
    required this.mfTransactionStatus,
    required this.transactionType,
  }) : super(key: key);

  @override
  State<MFTransactionStatusScreen> createState() =>
      _MFTransactionStatusScreenState();
}

class _MFTransactionStatusScreenState extends State<MFTransactionStatusScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLastPageFetched = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
                  _scrollController.position.pixels <=
              200 &&
          !_isLastPageFetched) {
        _handleFetchFund();
      }
    });
  }

  void _handleFetchFund({
    bool isFirstFetch = false,
  }) {
    context.read<GetGoalPlanningDashboardDataCubit>().getDashboardData(
          goaltype: '',
          page: isFirstFetch ? 0 : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.mfTransactionStatus ==
                      MfTransactionStatus.success) ...[
                    Assets.gifs.transactionSuccess.image(
                      width: 200,
                      height: 200,
                    ),
                    const Gap(20),
                    const Text(
                      'Congratulations!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'Your ${transactionData.transactionType ?? widget.transactionType} transaction is successfully completed',
                      style: TextStyle(
                        color: AppColors.neutral[400],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    if (transactionData.transactionType ==
                        MFTransactionTypes.assistedService)
                      const SizedBox.shrink()
                    else ...[
                      Card(
                        elevation: 3,
                        margin: EdgeInsets.zero,
                        shadowColor: AppColors.neutral[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: CachedNetworkImage(
                              imageUrl: transactionData.fund!.imgUrl,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(transactionData.fund!.schemeName),
                          ),
                        ),
                      ),
                      if (!(transactionData.transactionType ==
                              MFTransactionTypes.lumpsum ||
                          transactionData.transactionType ==
                              MFTransactionTypes.sip ||
                          transactionData.transactionType ==
                              MFTransactionTypes.cart)) ...[
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Assets.svgs.transactionDottedLine.svg(
                              height: 80,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 2.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF4EA),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Text(
                                widget.transactionType.toString(),
                                style: const TextStyle(
                                  color: Color(0xFFF7922E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (transactionData.transactionType ==
                                MFTransactionTypes.redemption ||
                            transactionData.transactionType ==
                                MFTransactionTypes.swp)
                          Card(
                            elevation: 3,
                            margin: EdgeInsets.zero,
                            shadowColor: AppColors.neutral[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 12.0,
                              ),
                              dense: true,
                              leading: transactionData.bank?.imageUrl == null
                                  ? ListIcon(
                                      svgImage: Assets.icons.bank,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: transactionData.bank!.imageUrl!,
                                      height: _size,
                                      width: _size,
                                      placeholder: (context, url) =>
                                          CustomShimmer(
                                        child: Container(
                                          width: _size,
                                          height: _size,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          ListIcon(
                                        svgImage: Assets.icons.bank,
                                      ),
                                    ),
                              title: Text(transactionData.bank?.bankName ??
                                  'Primary Bank'),
                              subtitle: transactionData.bank == null
                                  ? null
                                  : Text(transactionData
                                      .bank!.maskedBankAccountNumber),
                            ),
                          )
                        else
                          Card(
                            elevation: 3,
                            margin: EdgeInsets.zero,
                            shadowColor: AppColors.neutral[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 12.0,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: CachedNetworkImage(
                                  imageUrl:
                                      transactionData.switchStpFund!.imgUrl,
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(
                                  transactionData.switchStpFund!.schemeName,
                                ),
                              ),
                            ),
                          ),
                      ] else ...[
                        if (transactionData.transactionType ==
                                MFTransactionTypes.lumpsum ||
                            transactionData.transactionType ==
                                MFTransactionTypes.sip ||
                            transactionData.transactionType ==
                                MFTransactionTypes.cart) ...[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Gap(25),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Link this investment to a goal?',
                                  style: baseTextStyle14400,
                                ),
                              ),
                              const Gap(20),
                              BlocBuilder<GetGoalPlanningDashboardDataCubit,
                                  GetGoalPlanningDashboardDataState>(
                                builder: (context, state) {
                                  final fundList = state.fundList ?? [];

                                  if (state
                                      is GetGoalPlanningDashboardDataLoaded) {
                                    _isLastPageFetched = state.isLastPage;
                                  }

                                  if (state is GetGoalPlanningDashboardDataLoaded &&
                                      state
                                          is! GetGoalPlanningDashboardDataLoading &&
                                      fundList.isEmpty) {
                                    return Column(
                                      children: [
                                        Assets.svgs.noTransaction.svg(),
                                        TextButton(
                                          onPressed: () {
                                            if (context
                                                .read<AuthCubit>()
                                                .state
                                                .user!
                                                .userGoalsPresent!) {
                                              Navigator.pushNamed(
                                                  context,
                                                  Routes
                                                      .goalPlanningReturnUser);
                                            } else {
                                              Navigator.pushNamed(
                                                  context,
                                                  Routes
                                                      .goalPlanningOnboardScreen);
                                            }
                                          },
                                          child: const Text('create goal'),
                                        ),
                                      ],
                                    );
                                  }

                                  return ListView.builder(
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      itemCount: state
                                              is GetGoalPlanningDashboardDataLoading
                                          ? fundList.length + 1
                                          : fundList.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        if (index > fundList.length - 1) {
                                          return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        }
                                        return InvestGoalsCardsScreens(
                                          icon: state.fundList?[index].goalIcon,
                                          title:
                                              state.fundList?[index].goalName ??
                                                  '',
                                          persentageValue: state
                                                  .fundList?[index]
                                                  .goalCompletionPercentage ??
                                              0,
                                          subtitle: state.fundList?[index]
                                                  .currentGoalAmount ??
                                              0,
                                          goalCompleted: state.fundList?[index]
                                                  .goalCompleted ??
                                              false,
                                          id: state.fundList![index].id ?? 0,
                                          paymentid:
                                              transactionData.bank?.id ?? 0,
                                          onClick: () {
                                            context
                                                .read<
                                                    CreateGoalInvestementsCubit>()
                                                .createInvestment(
                                                  CreateGoalInvestmentParams(
                                                      userId: context
                                                          .read<AuthCubit>()
                                                          .state
                                                          .user!
                                                          .id,
                                                      paymentId: transactionData
                                                              .bank?.id ??
                                                          0,
                                                      goalId: state
                                                              .fundList![index]
                                                              .id ??
                                                          0),
                                                );
                                          },
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ]
                      ],
                      const Gap(20),
                    ],
                  ] else if (widget.mfTransactionStatus ==
                      MfTransactionStatus.pending) ...[
                    Assets.svgs.pending.svg(
                      width: 200,
                      height: 200,
                    ),
                    const Gap(20),
                    Text(
                      'Your transaction is in progress',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    const Text(
                      'You will receive a confirmation once the transaction is completed',
                      textAlign: TextAlign.center,
                    ),
                  ] else ...[
                    LottieBuilder.network(
                      'https://assets6.lottiefiles.com/temp/lf20_cLJq7R.json',
                      repeat: true,
                      height: 200,
                      width: 200,
                    ),
                    const Gap(20),
                    Text(
                      'Oops! Transaction Failed',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                    const Text(
                      'Something went wrong',
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'You can try again by placing a new purchase order',
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.mfTransactionStatus ==
                  MfTransactionStatus.success) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                    transactionData.clearData();
                    final navTabEntity =
                        context.read<NavCubit>().state.navTabEntity;
                    context.read<NavCubit>().changeTab(
                          navTabEntity.copyWith(
                            mainTabIndex: 4,
                            portfolioTabIndex: 0,
                            portfolioMFTabIndex: widget.transactionType ==
                                    MFTransactionTypes.assistedService
                                ? 1
                                : null,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(335, 56),
                    minimumSize: const Size(335, 56),
                  ),
                  child: const Text('Go To My Portfolio'),
                ),
              ] else if (widget.mfTransactionStatus ==
                  MfTransactionStatus.pending) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(335, 56),
                    minimumSize: const Size(335, 56),
                  ),
                  child: const Text('Ok'),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(335, 56),
                    minimumSize: const Size(335, 56),
                  ),
                  child: const Text('Ok'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
