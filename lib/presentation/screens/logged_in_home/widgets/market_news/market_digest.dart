import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../../di/get_it.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/market_news/market_news_cubit.dart';
import '../../../../widgets/app_error_widget.dart';

class MarketDigest extends StatelessWidget {
  const MarketDigest({Key? key}) : super(key: key);
  String formatTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${_monthName(date.month)} ${date.day}, ${date.year}";
  }

  String _monthName(int month) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digest'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Today'),
              const Gap(27),
              BlocProvider(
                create: (context) =>
                    getIt<MarketNewsCubit>()..fetchMarketNews('TODAY'),
                child: BlocBuilder<MarketNewsCubit, MarketNewsState>(
                  builder: (context, state) {
                    if (state is MarketNewsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is MarketNewsFailure) {
                      return AppErrorWidget(
                        errorType: state.errorType,
                        error: state.errorMessage,
                        onRetry: () => context
                            .read<MarketNewsCubit>()
                            .fetchMarketNews('TODAY'),
                      );
                    }
                    if (state is MarketNewsSuccess) {
                      final marketNews = state.newsDetails;
                      List<Widget> digestBannerList = [
                        for (int index = 0;
                            index < marketNews.data.length;
                            index++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2),
                            child: Material(
                              borderRadius: BorderRadius.circular(16),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Gap(14),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              if (marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .highlight
                                                      .sentiment >
                                                  0)
                                                Row(
                                                  children: [
                                                    Assets.gifs.trendingUp
                                                        .image(
                                                      height: 16,
                                                      width: 16,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const Gap(7),
                                                  ],
                                                ),
                                              if (marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .highlight
                                                      .sentiment <
                                                  0)
                                                Row(
                                                  children: [
                                                    Assets.gifs.trendingDown
                                                        .image(
                                                      height: 16,
                                                      width: 16,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const Gap(7),
                                                  ],
                                                ),
                                              Expanded(
                                                child: Text(
                                                  marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .entity
                                                      .name,
                                                  style: baseTextStyle10400
                                                      .copyWith(
                                                          color: const Color(
                                                              0xFF727579)),
                                                  overflow: TextOverflow
                                                      .ellipsis, // Optional: use ellipsis for text overflow
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formatTimestamp(marketNews
                                                .data[index]
                                                .article
                                                .publishedAt),
                                            style: baseTextStyle10400.copyWith(
                                                color: const Color(0xFFBEBFC1)),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  Container(
                                    height: 100,
                                    color: marketNews
                                                .data[index]
                                                .featuredHighlight
                                                .highlight
                                                .sentiment ==
                                            0
                                        ? const Color(
                                            0xFFEAF4FF) // Blue color for sentiment == 0
                                        : marketNews
                                                    .data[index]
                                                    .featuredHighlight
                                                    .highlight
                                                    .sentiment >
                                                0
                                            ? const Color(
                                                0xFFE7FAF0) // Green color for sentiment > 0
                                            : const Color(0xFFFFEDED),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        marketNews.data[index].featuredHighlight
                                            .highlight.highlight
                                            .replaceAll(RegExp(r'<[^>]*>'), ''),
                                        style: baseTextStyle12500.copyWith(
                                            color: const Color(0xFF727579)),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  Row(
                                    children: [
                                      const Gap(10),
                                      Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFFEFC3),
                                            borderRadius:
                                                BorderRadius.circular(70)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10),
                                          child: Text(
                                            marketNews
                                                .data[index]
                                                .featuredHighlight
                                                .entity
                                                .industry,
                                            style: baseTextStyle10400.copyWith(
                                              color: const Color(
                                                  0xFF8C7021), // Text color
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      const Gap(8),
                                      Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFEAF4FF),
                                            borderRadius:
                                                BorderRadius.circular(70)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10),
                                          child: Text(
                                            marketNews.data[index]
                                                .featuredHighlight.entity.type,
                                            style: baseTextStyle10400.copyWith(
                                              color: const Color(
                                                  0xFF2E8EFF), // Text color
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(20),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 90,
                                          child: Text(
                                            marketNews
                                                .data[index].article.source,
                                            style: baseTextStyle10400.copyWith(
                                                color: const Color(0xFFBEBFC1)),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(14),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          child: Assets.pngs.shareButton
                                              .image(height: 22, width: 22),
                                          onTap: () async {
                                            Share.share(
                                                'Hey! Checkout the latest stock market news & updates on Neosurge at https://onelink.to/2pdpvs');
                                          },
                                        ),
                                        GestureDetector(
                                          child: Assets.pngs.openLinkIcon
                                              .image(height: 22, width: 22),
                                          onTap: () async {
                                            String url = marketNews
                                                .data[index].article.url;
                                            if (await canLaunchUrlString(url)) {
                                              await launchUrlString(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ];
                      return CarouselSlider(
                        items: digestBannerList,
                        options: CarouselOptions(
                          height: 272, // Adjust this height if necessary
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.6, // Adjusted to show two items
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false, // Autoplay disabled
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage:
                              false, // Set to false to keep size consistent
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              const Gap(24),
              const Text('Yesterday'),
              const Gap(27),
              BlocProvider(
                create: (context) =>
                    getIt<MarketNewsCubit>()..fetchMarketNews('YESTERDAY'),
                child: BlocBuilder<MarketNewsCubit, MarketNewsState>(
                  builder: (context, state) {
                    if (state is MarketNewsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is MarketNewsFailure) {
                      return AppErrorWidget(
                        errorType: state.errorType,
                        error: state.errorMessage,
                        onRetry: () => context
                            .read<MarketNewsCubit>()
                            .fetchMarketNews('YESTERDAY'),
                      );
                    }
                    if (state is MarketNewsSuccess) {
                      final marketNews = state.newsDetails;
                      List<Widget> digestBannerList = [
                        for (int index = 0;
                            index < marketNews.data.length;
                            index++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2),
                            child: Material(
                              borderRadius: BorderRadius.circular(16),
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Gap(14),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              if (marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .highlight
                                                      .sentiment >
                                                  0)
                                                Row(
                                                  children: [
                                                    Assets.gifs.trendingUp
                                                        .image(
                                                      height: 16,
                                                      width: 16,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const Gap(7),
                                                  ],
                                                ),
                                              if (marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .highlight
                                                      .sentiment <
                                                  0)
                                                Row(
                                                  children: [
                                                    Assets.gifs.trendingDown
                                                        .image(
                                                      height: 16,
                                                      width: 16,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    const Gap(7),
                                                  ],
                                                ),
                                              Expanded(
                                                child: Text(
                                                  marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .entity
                                                      .name,
                                                  style: baseTextStyle10400
                                                      .copyWith(
                                                          color: const Color(
                                                              0xFF727579)),
                                                  overflow: TextOverflow
                                                      .ellipsis, // Optional: use ellipsis for text overflow
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formatTimestamp(marketNews
                                                .data[index]
                                                .article
                                                .publishedAt),
                                            style: baseTextStyle10400.copyWith(
                                                color: const Color(0xFFBEBFC1)),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  Container(
                                    height: 100,
                                    color: marketNews
                                                .data[index]
                                                .featuredHighlight
                                                .highlight
                                                .sentiment ==
                                            0
                                        ? const Color(
                                            0xFFEAF4FF) // Blue color for sentiment == 0
                                        : marketNews
                                                    .data[index]
                                                    .featuredHighlight
                                                    .highlight
                                                    .sentiment >
                                                0
                                            ? const Color(
                                                0xFFE7FAF0) // Green color for sentiment > 0
                                            : const Color(0xFFFFEDED),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        marketNews.data[index].featuredHighlight
                                            .highlight.highlight
                                            .replaceAll(RegExp(r'<[^>]*>'), ''),
                                        style: baseTextStyle12500.copyWith(
                                            color: const Color(0xFF727579)),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  Row(
                                    children: [
                                      const Gap(10),
                                      Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFFEFC3),
                                            borderRadius:
                                                BorderRadius.circular(70)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10),
                                          child: Text(
                                            marketNews
                                                .data[index]
                                                .featuredHighlight
                                                .entity
                                                .industry,
                                            style: baseTextStyle10400.copyWith(
                                              color: const Color(
                                                  0xFF8C7021), // Text color
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      const Gap(8),
                                      Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFEAF4FF),
                                            borderRadius:
                                                BorderRadius.circular(70)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10),
                                          child: Text(
                                            marketNews.data[index]
                                                .featuredHighlight.entity.type,
                                            style: baseTextStyle10400.copyWith(
                                              color: const Color(
                                                  0xFF2E8EFF), // Text color
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(20),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 90,
                                          child: Text(
                                            marketNews
                                                .data[index].article.source,
                                            style: baseTextStyle10400.copyWith(
                                                color: const Color(0xFFBEBFC1)),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(14),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          child: Assets.pngs.shareButton
                                              .image(height: 22, width: 22),
                                          onTap: () async {
                                            Share.share(
                                                'Hey! Checkout the latest stock market news & updates on Neosurge at https://onelink.to/2pdpvs');
                                          },
                                        ),
                                        GestureDetector(
                                          child: Assets.pngs.openLinkIcon
                                              .image(height: 22, width: 22),
                                          onTap: () async {
                                            String url = marketNews
                                                .data[index].article.url;
                                            if (await canLaunchUrlString(url)) {
                                              await launchUrlString(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ];
                      return CarouselSlider(
                        items: digestBannerList,
                        options: CarouselOptions(
                          height: 272, // Adjust this height if necessary
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.6, // Adjusted to show two items
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false, // Autoplay disabled
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage:
                              false, // Set to false to keep size consistent
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
