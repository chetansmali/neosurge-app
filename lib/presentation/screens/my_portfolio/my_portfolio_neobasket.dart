import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../../domain/entities/nav_tab_entity.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/neobaskets/basket_portfolio/basket_portfolio_cubit.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/widgets.dart';
import 'widgets/investment_card.dart';

class MyPortFolioNeoBasket extends StatelessWidget {
  const MyPortFolioNeoBasket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketPortfolioCubit, BasketPortfolioState>(
      builder: (context, state) {
        if (state is BasketPortfolioLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is BasketPortfolioError) {
          return Center(
            child: AppErrorWidget(
              errorType: state.errorType,
              error: state.errorMessage,
            ),
          );
        }

        if (state is! BasketPortfolioLoaded) {
          return const SizedBox();
        }

        return state.basketPortfolioResponse.portfolioInvested == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You haven’t invested in any NeoBaskets yet!',
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NavCubit>().changeTab(
                            const NavTabEntity(
                              mainTabIndex: 3,
                              mutualFundTabIndex: 0,
                            ),
                          );

                      Navigator.pushNamed(
                        context,
                        Routes.mutualFunds,
                      );
                    },
                    child: const Text('Explore NeoBaskets'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: InvestmentCard(
                      user: ImportedHoldingUser(
                        currentAssetValue:
                            state.basketPortfolioResponse.portfolioCurrent,
                        investedValue:
                            state.basketPortfolioResponse.portfolioInvested,
                        returnValue:
                            state.basketPortfolioResponse.portfolioReturns,
                        returnPercentage: state
                            .basketPortfolioResponse.portfolioReturnsPercentage,
                      ),
                      isRefreshButtonVisible: false,
                      animatedCard: true,
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'Baskets Bought (${state.basketPortfolioResponse.baskets.length})',
                      style: baseTextStyle16500,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      itemCount: state.basketPortfolioResponse.baskets.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return _BoughtBasket(
                          portfolioBasket:
                              state.basketPortfolioResponse.baskets[index],
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class _BoughtBasket extends StatelessWidget {
  final Basket portfolioBasket;

  const _BoughtBasket({
    Key? key,
    required this.portfolioBasket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.basketPortfolioDetail,
          arguments: BasketPortfolioDetailArgs(
            portfolioBasket: portfolioBasket,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: portfolioBasket.imageUrl ?? '',
                      height: 32,
                      width: 32,
                    ),
                    const Gap(10),
                    Text(
                      portfolioBasket.basketName ?? '',
                      style: baseTextStyle14500,
                    ),
                  ],
                ),
                Assets.icons.rightArrowIcon.image(
                  height: 20,
                  width: 20,
                )
              ],
            ),
            const Gap(14),
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
                      amount: portfolioBasket.currentValue ?? 0.0,
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
                      amount: portfolioBasket.investedValue ?? 0.0,
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
                    AmountWidget(
                      amount: portfolioBasket.returns ?? 0.0,
                      postText:
                          ' (${portfolioBasket.returnsPercentage?.toStringAsFixed(2)}%)',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
