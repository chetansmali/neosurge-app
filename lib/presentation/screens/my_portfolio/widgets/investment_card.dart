import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../common/common.dart';
import '../../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../../../domain/entities/params/import_external_fund/validate_transaction_params.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/import_external_fund/transaction/transaction_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart' show AppColors;
import '../../../widgets/amount_widget.dart';

class InvestmentCard extends StatefulWidget {
  const InvestmentCard({
    super.key,
    required this.user,
    this.animatedCard = true,
    this.isRefreshButtonVisible = true,
    this.onTap,
  });

  final ImportedHoldingUser user;
  final VoidCallback? onTap;
  final bool animatedCard;
  final bool isRefreshButtonVisible;

  @override
  State<InvestmentCard> createState() => _InvestmentCardState();
}

class _InvestmentCardState extends State<InvestmentCard> {
  bool isCardOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: [
            if (widget.animatedCard)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: isCardOpen ? -65 : 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: AppColors.lightGrey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        children: [
                          _buildInvestedAndReturn(
                            titleOne: 'XIRR',
                            valueOne: Text(
                              '${widget.user.xirr?.toStringAsFixed(2) ?? '0.0'}%',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            titleTwo: '1D Change',
                            valueTwo: AmountWidget(
                              amount: widget.user.oneDayChange ?? 0,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    (widget.user.oneDayChange ?? 0).isNegative
                                        ? AppColors.textRed
                                        : AppColors.green,
                              ),
                            ),
                            percentageChange:
                                widget.user.oneDayChangePercentage ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            GestureDetector(
              onTap: widget.onTap,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Current',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            '(as on ${DateFormat('dd MMM yyyy').format(DateTime.now())})',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (widget.isRefreshButtonVisible) ...[
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                await context
                                    .read<TransactionCubit>()
                                    .initailiseImportTransaction(
                                      userId: context
                                          .read<AuthCubit>()
                                          .state
                                          .user!
                                          .id,
                                      panNumber: widget.user.panNumber!,
                                      phoneNumber: widget.user.mobileNumber!,
                                    );
                              },
                              icon: BlocConsumer<TransactionCubit,
                                  TransactionState>(
                                listener: (context, state) {
                                  if (state is TransactionInitialised) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (timeStamp) {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.importExternalFundsVerifyOtp,
                                          arguments: ValidateTransactionParams(
                                            userID: context
                                                .read<AuthCubit>()
                                                .state
                                                .user!
                                                .id,
                                            panNumber: widget.user.panNumber!,
                                            phoneNumber:
                                                widget.user.mobileNumber!,
                                            transactionID: state
                                                .initialiseTransactionReposnse
                                                .transactionID,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is TransactionLoading) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  return const Icon(
                                    CupertinoIcons.refresh,
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                      AmountWidget(
                          amount: widget.user.currentAssetValue ?? 0,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: widget.user.currentAssetValue?.isNegative ??
                                    false
                                ? AppColors.textRed
                                : AppColors.green,
                          )),
                      const Divider(),
                      _buildInvestedAndReturn(
                        titleOne: 'Invested',
                        valueOne: AmountWidget(
                          amount: widget.user.investedValue ?? 0,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        titleTwo: 'Returns',
                        valueTwo: AmountWidget(
                          amount: widget.user.returnValue ?? 0,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: widget.user.returnValue?.isNegative ?? true
                                ? AppColors.textRed
                                : AppColors.green,
                          ),
                        ),
                        isTrailingIconVisible: widget.animatedCard,
                        percentageChange: widget.user.returnPercentage ?? 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: !isCardOpen ? 0 : 75,
        ),
      ],
    );
  }

  Row _buildInvestedAndReturn({
    bool isTrailingIconVisible = false,
    required String titleOne,
    required Widget valueOne,
    required String titleTwo,
    required Widget valueTwo,
    required double percentageChange,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleOne,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            valueOne,
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleTwo,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                valueTwo,
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: percentageChange.isNegative
                        ? AppColors.textRed.withOpacity(
                            0.1,
                          )
                        : AppColors.green.withOpacity(
                            0.1,
                          ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${percentageChange.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: percentageChange.isNegative
                              ? AppColors.textRed
                              : AppColors.green,
                        ),
                      ),
                      const Gap(6),
                      Icon(
                        percentageChange.isNegative
                            ? CupertinoIcons.arrowtriangle_down_fill
                            : CupertinoIcons.arrowtriangle_up_fill,
                        size: 12,
                        color: percentageChange.isNegative
                            ? AppColors.textRed
                            : AppColors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isTrailingIconVisible) ...[
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                isCardOpen = !isCardOpen;
              });
            },
            icon: Icon(
              isCardOpen
                  ? CupertinoIcons.arrowtriangle_up_circle
                  : CupertinoIcons.arrowtriangle_down_circle,
            ),
          ),
        ]
      ],
    );
  }
}
