import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../cubits/mutual_funds/popular_funds/popular_funds_cubit.dart';
import '../../widgets/custom_shimmer.dart';
import '../../widgets/label_text.dart';
import 'widgets/popular_funds_card.dart';

class PopularFundsListView extends StatelessWidget {
  const PopularFundsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<PopularFundsCubit, PopularFundsState>(
        builder: (context, state) {
          if (state is PopularFundsLoading) {
            return const _PopularFundsShimmer();
          }

          if (state is PopularFundsLoaded) {
            return Column(
              children: [
                const LabelText(label: 'Popular Funds'),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemCount: 20,
                    itemBuilder: (context, index) => const PopularFundsCard(),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _PopularFundsShimmer extends StatelessWidget {
  const _PopularFundsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomShimmer(
            height: 10,
            width: 100,
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(
                  height: 24,
                  width: 24,
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        CustomShimmer(),
                        Gap(20),
                        CustomShimmer(),
                      ],
                    )),
                    Gap(20),
                    CustomShimmer(
                      width: 30,
                      height: 40,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
