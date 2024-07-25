import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/app_colors.dart';

class DgProductView extends StatefulWidget {
  final String defaultImageUrl;
  final List<String> imageUrls;

  const DgProductView({
    Key? key,
    required this.defaultImageUrl,
    required this.imageUrls,
  }) : super(key: key);

  @override
  State<DgProductView> createState() => _DgProductViewState();
}

class _DgProductViewState extends State<DgProductView> {
  late final PageController _controller;

  @override
  initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: widget.imageUrls.length + 1,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemBuilder: (context, index) {
              if (index == 0) {
                return CachedNetworkImage(imageUrl: widget.defaultImageUrl);
              }
              return CachedNetworkImage(imageUrl: widget.imageUrls[index - 1]);
            },
          ),
        ),
        const Gap(10),
        SmoothPageIndicator(
          controller: _controller,
          count: widget.imageUrls.length + 1,
          effect: const ScrollingDotsEffect(
            dotColor: AppColors.darkGrey,
            activeDotColor: Colors.black,
            radius: 8,
            dotWidth: 8,
            dotHeight: 8,
          ),
        ),
      ],
    );
  }
}
