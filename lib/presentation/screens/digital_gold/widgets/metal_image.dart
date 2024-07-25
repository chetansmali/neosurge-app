import 'package:flutter/material.dart';

import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';

class MetalImage extends StatelessWidget {
  final MetalType metalType;
  final double? size;

  const MetalImage({Key? key, required this.metalType, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return metalType == MetalType.gold
        ? Assets.pngs.goldCoin.image(height: size ?? 64, width: size ?? 64, cacheWidth: 300, cacheHeight: 300)
        : Assets.pngs.silverCoin.image(height: size ?? 64, width: size ?? 64, cacheWidth: 300, cacheHeight: 300);
  }
}
