import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/mutual_funds/switch/switch_funds_list_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/empty_portfolio_view.dart';
import '../../../widgets/widgets.dart';

class SwitchFundListScreen extends HookWidget {
  final Fund fund;
  final UserMfScheme scheme;

  const SwitchFundListScreen(
      {Key? key, required this.fund, required this.scheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    useEffect(
      () {
        searchController.addListener(() {
          context
              .read<SwitchFundsListCubit>()
              .searchFunds(searchController.text);
        });
        return () => searchController.removeListener(() {});
      },
      const [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch'),
        centerTitle: true,
      ),
      body: BlocBuilder<SwitchFundsListCubit, SwitchFundsListState>(
          builder: (context, state) {
        if (state is SwitchFundsListLoading) {
          return const Center(
            child: CustomLoader(),
          );
        }
        if (state is SwitchFundsListError) {
          return Center(
            child:
                AppErrorWidget(errorType: state.errorType, error: state.error),
          );
        }
        if (state is SwitchFundsListLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search Field
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(
                    color: AppColors.neutral[300],
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for funds',
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                      maxHeight: 36,
                      maxWidth: 36,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.pngs.equityMagnifer.image(),
                    ),
                    suffixIcon: ValueListenableBuilder(
                      valueListenable: searchController,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                      builder: (context, text, child) {
                        return searchController.text.isEmpty
                            ? const SizedBox.shrink()
                            : child!;
                      },
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.neutral[50]!,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.neutral[50]!,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: state.funds.isEmpty
                    ? const EmptyPortfolioView(
                        message: 'No funds found',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: state.funds.length,
                        itemBuilder: (_, i) {
                          final switchFund = state.funds[i];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              switchFund.schemeNameUnique,
                              style: TextStyle(
                                color: AppColors.neutral[300],
                                fontSize: 12,
                              ),
                            ),
                            leading: CachedNetworkImage(
                              imageUrl: switchFund.imgUrl,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => const CircleAvatar(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                child: Icon(
                                  Icons.error,
                                  color: AppColors.error[500]!,
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (switchFund.performance.threeY == 0) ...[
                                  const Text(
                                    'NA',
                                  ),
                                ] else ...[
                                  Text(
                                    '${switchFund.performance.threeY.toStringAsFixed(2)} %',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Text(
                                    '(3Y)',
                                    style: TextStyle(color: AppColors.textGrey),
                                  ),
                                ]
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.switchFund,
                                arguments: SwitchFundArgs(
                                  fund: fund,
                                  scheme: scheme,
                                  switchFund: switchFund,
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (_, i) => Divider(
                          thickness: 1,
                          color: AppColors.neutral[50],
                        ),
                      ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
