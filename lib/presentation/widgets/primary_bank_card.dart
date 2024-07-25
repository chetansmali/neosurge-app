import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/user/user_bank_details_model.dart';
import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';
import 'custom_shimmer.dart';

const double _size = 24;

class PrimaryBankCard extends StatelessWidget {
  final UserBank bank;
  final EdgeInsetsGeometry? padding;
  final bool isVerifiedIconVisible;

  const PrimaryBankCard({
    Key? key,
    required this.bank,
    this.padding,
    this.isVerifiedIconVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary[50]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: ListTile(
          dense: true,
          leading: bank.imageUrl == null
              ? Assets.icons.bank.svg(
                  width: _size,
                  height: _size,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: bank.imageUrl!,
                  height: _size,
                  width: _size,
                  placeholder: (context, url) => CustomShimmer(
                    child: Container(
                      width: _size,
                      height: _size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Assets.icons.bank.svg(
                    width: _size,
                    height: _size,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
          title: Text(bank.bankName),
          subtitle: Text(bank.maskedBankAccountNumber),
          trailing: isVerifiedIconVisible ? Assets.svgs.tickCircle.svg() : null,
        ),
      ),
    );
  }
}
