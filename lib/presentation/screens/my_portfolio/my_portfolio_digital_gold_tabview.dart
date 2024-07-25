import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../data/models/digital_gold/dg_transaction_response_model.dart';
import '../../../di/get_it.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart';
import '../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../digital_gold/dg_trans_and_delivery_info_screen.dart';
import '../digital_gold/widgets/dg_portfolio_investment_tile.dart';
import '../digital_gold/widgets/dg_transaction_card.dart';

class MyPortfolioDigitalGoldTabView extends StatefulWidget {
  const MyPortfolioDigitalGoldTabView({Key? key}) : super(key: key);

  @override
  State<MyPortfolioDigitalGoldTabView> createState() =>
      _MyPortfolioDigitalGoldTabViewState();
}

class _MyPortfolioDigitalGoldTabViewState
    extends State<MyPortfolioDigitalGoldTabView> {
  bool isGoldSelected = true;
  bool _loadError = false;
  AppErrorType _appErrorType = AppErrorType.api;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoldUserCubit, GoldUserState>(
      builder: (context, state) {
        if (state is GoldUserLoading) {
          return const Center(child: CustomLoader());
        }
        if (state is GoldUserLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const Gap(24.0),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => isGoldSelected = true),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: isGoldSelected
                                    ? AppColors.primaryColor
                                    : null,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                'Gold',
                                style: baseTextStyle12500.copyWith(
                                    color: isGoldSelected
                                        ? Colors.white
                                        : AppColors.neutral[500]),
                              ),
                            ),
                          ),
                          const Gap(8.0),
                          GestureDetector(
                            onTap: () => setState(() => isGoldSelected = false),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: isGoldSelected
                                    ? null
                                    : AppColors.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                'Silver',
                                style: baseTextStyle12500.copyWith(
                                    color: isGoldSelected
                                        ? AppColors.neutral[500]
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(30.0),
                      if (isGoldSelected) ...[
                        DGPortfolioExpandedTile(
                          metalType: MetalType.gold,
                          amount: state.goldUser!.goldBalance,
                          investedVal: state.goldUser!.totalGoldInvestment,
                        ),
                      ] else ...[
                        DGPortfolioExpandedTile(
                          metalType: MetalType.silver,
                          amount: state.goldUser!.silverBalance,
                          investedVal: state.goldUser!.totalSilverInvestment,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              body: Column(
                children: [
                  const Gap(30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions',
                        style: baseTextStyle18500.copyWith(
                            color: AppColors.neutral[500]),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DGTxnAndDeliveryScreen(),
                          ),
                        ),
                        child: Text(
                          'View all',
                          style: baseTextStyle12500.copyWith(
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16.0),
                  BlocBuilder<DgTransactionCubit, DgTransactionState>(
                    bloc: getIt<DgTransactionCubit>()
                      ..fetchTransactions(
                          transactionStatus: DgTransactionStatus.success),
                    builder: (context, state) {
                      List<DgTransactionResponseModel> transactions = [];
                      bool isLoading = false;
                      _loadError = false;
                      if (state is DgTransactionLoading && state.isFirstFetch) {
                        return const Center(child: CustomLoader());
                      }
                      if (state is DgTransactionLoadError &&
                          state.isFirstFetch) {
                        return SingleChildScrollView(
                          child: AppErrorWidget(
                            errorType: state.appErrorType,
                            error: state.errorMessage,
                            onRetry: _handleTransactionFetch,
                          ),
                        );
                      }
                      if (state is DgTransactionLoadError) {
                        transactions = state.oldTransactionList;
                        _loadError = true;
                        isLoading = false;
                        _appErrorType = state.appErrorType;
                      } else if (state is DgTransactionLoading) {
                        transactions = state.oldTransactionList;
                        isLoading = true;
                      } else if (state is DgTransactionLoaded) {
                        transactions = state.transactionList;
                      }

                      return transactions.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.svgs.emptyVector.svg(height: 200),
                                const Gap(20),
                                Text(
                                  'No transactions yet',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            )
                          : Expanded(
                              child: ListView.builder(
                                primary: false,
                                itemCount:
                                    transactions.length + (isLoading ? 1 : 0),
                                itemBuilder: (BuildContext context, int index) {
                                  if (index < transactions.length) {
                                    if (isGoldSelected) {
                                      if (transactions[index].metalType ==
                                          MetalType.gold) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: DgTransactionCard(
                                            transaction: DgTransactionModel(
                                                transaction:
                                                    transactions[index]),
                                            transactionStatus:
                                                transactions[index].status,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      if (transactions[index].metalType ==
                                          MetalType.silver) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: DgTransactionCard(
                                            transaction: DgTransactionModel(
                                                transaction:
                                                    transactions[index]),
                                            transactionStatus:
                                                transactions[index].status,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    }
                                  } else {
                                    return _loadError
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                Utils.getErrorMessage(
                                                    errorType: _appErrorType,
                                                    msg: null),
                                                textAlign: TextAlign.center,
                                              ),
                                              IconButton(
                                                  onPressed: () =>
                                                      _handleTransactionFetch(),
                                                  icon: const Icon(
                                                    Icons.refresh,
                                                  ))
                                            ],
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:
                                                Center(child: CustomLoader()),
                                          );
                                  }
                                },
                              ),
                            );
                    },
                  ),
                  const Gap(24.0),
                ],
              ),
            ),
          );
        }
        if (state is GoldUserLoadError) {
          return Center(
            child: AppErrorWidget(
              errorType: state.errorType,
              error: state.errorMessage,
              onRetry: () => context.read<GoldUserCubit>().loadGoldUser(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _handleTransactionFetch({
    bool isFirstFetch = false,
  }) {
    context.read<DgTransactionCubit>().fetchTransactions(
        transactionStatus: DgTransactionStatus.all, isFirstFetch: isFirstFetch);
  }
}
