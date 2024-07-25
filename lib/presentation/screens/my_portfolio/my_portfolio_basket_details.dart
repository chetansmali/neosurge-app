import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../cubits/neobaskets/basket_portfolio_detail/basket_portfolio_detail_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/widgets.dart';
import '../mutual_funds/widgets/basket_custom_container.dart';
import '../mutual_funds/widgets/redeem_type_selection_bottom_sheet.dart';
import 'widgets/basket_portfolio_fund.dart';
import 'widgets/sip_detail_tile.dart';

class MyPortfolioBasketDetailsPage extends StatelessWidget {
  const MyPortfolioBasketDetailsPage({
    Key? key,
    required this.basket,
  }) : super(key: key);

  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket Details'),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    var state =
                        context.read<BasketPortfolioDetailCubit>().state;
                    if (state is BasketPortfolioDetailLoaded) {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return RedeemTypeSelectionBottomSheet(
                            basket: basket,
                            basketPortfolioDetailResponse:
                                state.basketPortfolioDetailResponse,
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Redeem'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<BasketPortfolioDetailCubit, BasketPortfolioDetailState>(
        builder: (context, state) {
          if (state is BasketPortfolioDetailLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is BasketPortfolioDetailError) {
            return Center(
              child: AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
              ),
            );
          } else if (state is BasketPortfolioDetailLoaded) {
            BasketPortfolioDetailResponse basketPortfolioDetailResponse =
                state.basketPortfolioDetailResponse;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              state.basketPortfolioDetailResponse.imageUrl ??
                                  '',
                          height: 40,
                          width: 40,
                        ),
                        const Gap(10),
                        Text(
                          basket.basketName ?? '',
                          style: baseTextStyle14500,
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  BasketCustomContainer(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current',
                                  style: baseTextStyle1.copyWith(
                                      color: const Color(0xFFB0B0B0)),
                                ),
                                const Gap(10),
                                AmountWidget(
                                  amount: basketPortfolioDetailResponse
                                          .basketCurrentValue ??
                                      0.0,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invested',
                                  style: baseTextStyle1.copyWith(
                                    color: const Color(0xFFB0B0B0),
                                  ),
                                ),
                                const Gap(10),
                                AmountWidget(
                                  amount: basketPortfolioDetailResponse
                                          .basketInvestedValue ??
                                      0.0,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Returns',
                                  style: baseTextStyle1.copyWith(
                                    color: const Color(0xFFB0B0B0),
                                  ),
                                ),
                                const Gap(10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AmountWidget(
                                      amount: state
                                              .basketPortfolioDetailResponse
                                              .basketReturnsValue ??
                                          0.0,
                                    ),
                                    const Gap(4),
                                    Text(
                                      '(${basketPortfolioDetailResponse.basketReturnsPercentage?.toStringAsFixed(2)}%)',
                                      style: baseTextStyle.copyWith(
                                          color: const Color(0xFF43B649)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(10),
                  if (basketPortfolioDetailResponse.sip?.isNotEmpty ??
                      false) ...[
                    ListView.builder(
                      itemCount: basketPortfolioDetailResponse.sip!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return SipDetailsTile(
                          sipOrderRef: basketPortfolioDetailResponse
                              .sip![index].orderRef,
                          amount:
                              basketPortfolioDetailResponse.sip![index].amount,
                          basketInvestmentDate: int.parse(
                            basketPortfolioDetailResponse
                                .sip![index].investmentDate,
                          ),
                          sipEndDate:
                              basketPortfolioDetailResponse.sip![index].sipEnd,
                        );
                      },
                    )
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Funds in this Basket (${state.basketPortfolioDetailResponse.funds.length})',
                      style: baseTextStyle14500,
                    ),
                  ),
                  const Gap(10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: basketPortfolioDetailResponse.funds.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return BasketPortfolioFund(
                        fund: basketPortfolioDetailResponse.funds[index],
                      );
                    },
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.basketTrasactionScreen,
                      arguments: BasketTransactionArgs(
                        basketId: basket.basketId ?? '',
                      ),
                    ),
                    child: BasketCustomContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'All transactions',
                            style: baseTextStyle14500.copyWith(
                              color: const Color(0xFF297DFD),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xFF050C1B),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(60),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
