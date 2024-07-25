import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class NeoLogo extends StatelessWidget {
  final double? height;

  const NeoLogo({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Assets.pngs.neoLogo.image(height: 24);
    return Assets.svgs.neoLogo.svg(height: height ?? 32);
  }
}
