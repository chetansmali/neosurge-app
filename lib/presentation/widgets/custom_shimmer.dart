import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const CustomShimmer({Key? key, this.height, this.width, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white70,
      period: const Duration(seconds: 1),
      child: child ??
          Container(
            width: width ?? double.maxFinite,
            height: height ?? 10,
            color: Colors.white70,
          ),
    );
  }
}

class CustomStarShimmer extends StatelessWidget {
  const CustomStarShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white70,
      period: const Duration(seconds: 1),
      child: RatingBarIndicator(
        itemBuilder: (_, index) => const Icon(
          Icons.star,
          color: Colors.grey,
        ),
        itemCount: 5,
        rating: 3,
        itemSize: 10,
      ),
    );
  }
}
