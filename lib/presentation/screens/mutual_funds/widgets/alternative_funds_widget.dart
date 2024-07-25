import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/fund_detail.dart';
import '../../../cubits/mutual_funds/all_funds/all_funds_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';

class AlternativeFundsWidget extends StatelessWidget {
  final FundDetail fundDetail;

  const AlternativeFundsWidget({Key? key, required this.fundDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Alternative Funds',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.neutral[400],
        ),
      ),
      children: [
        BlocBuilder<AllFundsCubit, AllFundsState>(
          builder: (context, state) {
            if (state is AllFundsLoaded) {
              if (state.fundList.isEmpty) {
                return const Center(child: Text('No Alternative Funds'));
              }
              return Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: _TitleText('Fund Name'),
                        ),
                        Gap(20),
                        Expanded(
                          flex: 2,
                          child: _TitleText('Return(3Y)'),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    state.fundList.length,
                    (index) => _AlternativeFundCard(
                      fund: state.fundList[index],
                    ),
                  )
                ],
              );
            }
            if (state is AllFundsLoading) {
              return const Center(child: CustomLoader());
            }
            if (state is AllFundsLoadError) {
              return AppErrorWidget(
                errorType: state.appErrorType,
                error: state.errorMessage,
                onRetry: () => context
                    .read<AllFundsCubit>()
                    .getFunds(assetSubCategory: [fundDetail.assetSubCategory]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _AlternativeFundCard extends StatelessWidget {
  final Fund fund;

  const _AlternativeFundCard({
    Key? key,
    required this.fund,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.detailedFundView,
            arguments: DetailedFundViewArgs(schemeCode: fund.schemeCode),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: fund.imgUrl,
                  width: 50,
                  height: 50,
                ),
                const Gap(10),
                Expanded(
                  flex: 5,
                  child: Text(
                    fund.schemeNameUnique,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.neutral[300],
                    ),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Text(
                    '${fund.performance.threeY} %',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          indent: 20,
        ),
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
