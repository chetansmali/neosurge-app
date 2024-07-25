import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../../../../../data/models/digital_gold/delivery_product_model.dart';
import '../../../../routes/route_arguments.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';
import '../../widgets/metal_image.dart';

class DeliverInfoCard extends StatelessWidget {
  final DeliveryProductModel deliveryProduct;

  const DeliverInfoCard({
    super.key,
    required this.deliveryProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, Routes.digitalGoldDeliveryDetailedView,
              arguments: DigitalGoldDeliveryDetailedViewArgs(
                  deliveryProduct: deliveryProduct)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.neutral[900],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                deliveryProduct.defaultImageUrl == null
                    ? MetalImage(
                        metalType: deliveryProduct.metalType,
                        size: 68,
                      )
                    : CachedNetworkImage(
                        imageUrl: deliveryProduct.defaultImageUrl!,
                        width: 68,
                        height: 68,
                      ),
                const Gap(20.0),
                Text(
                  '${deliveryProduct.productWeight} gms',
                  style: baseTextStyle14500.copyWith(color: Colors.white),
                ),
                const Gap(4.0),
                Text(
                  '${deliveryProduct.purity} purity',
                  style: baseTextStyle12400.copyWith(
                      color: AppColors.neutral[300]),
                ),
              ],
            ),
          ),
        ),
        if (deliveryProduct.status != 'active')
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
