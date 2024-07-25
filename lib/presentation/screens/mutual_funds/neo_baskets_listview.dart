import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import '../../../domain/entities/params/neobaskets/basket_details_params.dart';
import '../../../domain/entities/params/neobaskets/neobaskets_discovery_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/neobaskets/neobaskets_discovery/neobasket_discovery_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_error_widget.dart';
import 'widgets/basket_sort_bottom_sheet.dart';
import 'widgets/neo_basket_tile.dart';

class NeoBasketsListView extends StatefulWidget {
  const NeoBasketsListView({super.key});

  @override
  State<NeoBasketsListView> createState() => _NeoBasketsListViewState();
}

class _NeoBasketsListViewState extends State<NeoBasketsListView> {
  String selectedSortingOption = 'CAGR';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NeoBasketDiscoveryCubit, NeobasketDiscoveryState>(
      builder: (context, state) {
        if (state is NeobasketDiscoveryLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is NeobasketDiscoveryFailure) {
          return AppErrorWidget(
            errorType: state.errorType,
            error: state.errorMessage,
            onRetry: () => context
                .read<NeoBasketDiscoveryCubit>()
                .getNeoBasketDiscoveryBaskets(
                  NeobasketDiscoveryParams(
                    searchTerm: '',
                    sortBy: 'cagr',
                  ),
                ),
          );
        }

        if (state is NeobasketDiscoverySuccess) {
          final basketsList = state.neobasketsDiscoveryDetails;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Assets.pngs.discoverBasket.image(height: 48, width: 48),
                    const Gap(4),
                    const Expanded(
                      child: Text(
                        'Discover NeoBaskets',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        String? selectedOption = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          builder: (_) {
                            return BlocProvider.value(
                              value: context.read<NeoBasketDiscoveryCubit>(),
                              child: BasketSortBottomSheet(
                                selectedSortingOption: selectedSortingOption,
                              ),
                            );
                          },
                        );

                        if (selectedOption == null) {
                          return;
                        }

                        selectedSortingOption = selectedOption;
                      },
                      child: Chip(
                        backgroundColor: AppColors.primary[50],
                        label: const Row(
                          children: [
                            Text(
                              'Sort by',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryViolet,
                              ),
                            ),
                            Gap(4),
                            FaIcon(
                              FontAwesomeIcons.sort,
                              size: 13,
                              color: AppColors.secondaryViolet,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: basketsList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return NeoBasketTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.basketDetailsScreen,
                          arguments: BasketDetailsParams(
                            basketId: basketsList[index].basketID,
                          ),
                        );
                      },
                      basketName: basketsList[index].name ?? '',
                      basketDescription: basketsList[index].description ?? '',
                      cagr: basketsList[index].cagr ?? 0.0,
                      minSip: basketsList[index].minSIP ?? 0.0,
                      aum: basketsList[index].aum ?? 0.0,
                      imageUrl: basketsList[index].imageURL ?? '',
                      isThreeYearReturns: basketsList[index].isThreeYearReturns,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
