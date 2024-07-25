import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class PopularInvestmentIdeaList extends StatelessWidget {
  const PopularInvestmentIdeaList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 280,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.fundsListByInvestmentIdea,
                      arguments: 'SECTOR',
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    width: 126,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.neutral[50]!,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Assets.svgs.topSector.svg(
                          width: 28,
                          height: 28,
                        ),
                        const Gap(20),
                        Expanded(
                          child: Text(
                            'Top Sectors asjfbkadfbkfb',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[900],
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.03,
            ),
          ),
        ),
      ),
    );
  }
}
