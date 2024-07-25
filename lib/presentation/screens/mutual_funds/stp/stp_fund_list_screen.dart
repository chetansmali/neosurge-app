import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/mutual_funds/stp/stp_funds_list/stp_funds_list_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';

class StpFundListScreen extends HookWidget {
  final Fund fund;
  final UserMfScheme scheme;

  const StpFundListScreen({Key? key, required this.fund, required this.scheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    useEffect(() {
      searchController.addListener(() {
        context.read<StpFundsListCubit>().searchFunds(searchController.text);
      });
      return () => searchController.removeListener(() {});
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Systematic Transfer Plan'),
        centerTitle: true,
      ),
      body: BlocBuilder<StpFundsListCubit, StpFundsListState>(
          builder: (context, state) {
        if (state is StpFundsListLoading) {
          return const Center(
            child: CustomLoader(),
          );
        }
        if (state is StpFundsListError) {
          return Center(
            child:
                AppErrorWidget(errorType: state.errorType, error: state.error),
          );
        }
        if (state is StpFundsListLoaded) {
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
                    ? const Center(child: Text('No Funds found'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: state.funds.length,
                        itemBuilder: (_, i) {
                          final stpFund = state.funds[i];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              stpFund.schemeNameUnique,
                              style: TextStyle(
                                color: AppColors.neutral[300],
                                fontSize: 12,
                              ),
                            ),
                            leading: CachedNetworkImage(
                              imageUrl: stpFund.imgUrl,
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
                                if (stpFund.performance.threeY == 0) ...[
                                  const Text(
                                    'NA',
                                  ),
                                ] else ...[
                                  Text(
                                    '${stpFund.performance.threeY.toStringAsFixed(2)} %',
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
                                Routes.stpFund,
                                arguments: StpFundArgs(
                                  fund: fund,
                                  scheme: scheme,
                                  stpFund: stpFund,
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
