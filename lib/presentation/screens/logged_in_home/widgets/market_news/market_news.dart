import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../di/get_it.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/market_news/market_news_cubit.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/app_error_widget.dart';

class MarketNews extends StatefulWidget {
  const MarketNews({Key? key}) : super(key: key);

  @override
  State<MarketNews> createState() => _MarketNewsState();
}

class _MarketNewsState extends State<MarketNews> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('News'),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.marketDigest);
                },
                child: Text('View older',
                    style: baseTextStyle12500.copyWith(
                        color: const Color(0xFF2E8EFF)))),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DashedLineIndicator(
              dashCount: 9,
              currentPage: _currentPage,
              color1: const Color(0xFFEBEBEB),
              color2: const Color(0xFF1D242D),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<MarketNewsCubit>()..fetchMarketNews('TODAY'),
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
                onRetry: () =>
                    context.read<MarketNewsCubit>().fetchMarketNews('TODAY'),
              );
            }
            if (state is MarketNewsSuccess) {
              final marketNews = state.newsDetails;
              return PageView.builder(
                controller: _pageController,
                itemCount: marketNews.data.length, // Number of pages
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFEFC3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          70)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3.0,
                                                        horizontal: 10),
                                                child: Text(
                                                  marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .entity
                                                      .industry,
                                                  style: baseTextStyle10400
                                                      .copyWith(
                                                    color: const Color(
                                                        0xFF8C7021), // Text color
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Gap(8),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFEAF4FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          70)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3.0,
                                                        horizontal: 10),
                                                child: Text(
                                                  marketNews
                                                      .data[index]
                                                      .featuredHighlight
                                                      .entity
                                                      .type,
                                                  style: baseTextStyle10400
                                                      .copyWith(
                                                    color: const Color(
                                                        0xFF2E8EFF), // Text color
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 80,
                                              child: Text(
                                                marketNews
                                                    .data[index]
                                                    .featuredHighlight
                                                    .entity
                                                    .name,
                                                style:
                                                    baseTextStyle10400.copyWith(
                                                        color: const Color(
                                                            0xFF727579)),
                                                overflow: TextOverflow
                                                    .ellipsis, // Optional: use ellipsis for text overflow
                                                maxLines: 2,
                                              ),
                                            ),
                                            const Gap(2),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE7FAF0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child:
                                                  Assets.gifs.trendingUp.image(
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Gap(20),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7.0, vertical: 12),
                                            child: Container(
                                              width: 5,
                                              height: 75,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: marketNews
                                                            .data[index]
                                                            .featuredHighlight
                                                            .highlight
                                                            .sentiment ==
                                                        0
                                                    ? const Color(
                                                        0xFF2E8EFF) // Blue color for sentiment == 0
                                                    : marketNews
                                                                .data[index]
                                                                .featuredHighlight
                                                                .highlight
                                                                .sentiment >
                                                            0
                                                        ? const Color(
                                                            0xFF11CE66) // Green color for sentiment > 0
                                                        : const Color(
                                                            0xFFFF4949),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start, // Aligns children to the start of the column
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: screenWidth -
                                                        72 // Set a maximum width for the text. Adjust this value as needed.
                                                    ),
                                                child: Text(
                                                  marketNews.data[index].article
                                                      .title,
                                                  style: baseTextStyle18500
                                                      .copyWith(
                                                          color: const Color(
                                                              0xFF565A5F)),
                                                  maxLines:
                                                      2, // Set the maximum number of lines for the text
                                                  softWrap:
                                                      true, // Allow the text to wrap
                                                  overflow: TextOverflow
                                                      .ellipsis, // Add an ellipsis for overflowed text
                                                ),
                                              ),
                                              const Gap(10),
                                              SizedBox(
                                                width: screenWidth - 80,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      marketNews.data[index]
                                                          .article.source,
                                                      style: baseTextStyle10400
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xFFBEBFC1)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      formatTimestamp(marketNews
                                                          .data[index]
                                                          .article
                                                          .publishedAt),
                                                      style: baseTextStyle10400
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xFFBEBFC1)),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      'HERE’S WHAT YOU NEED TO KNOW',
                                      style: baseTextStyle10600,
                                    ),
                                  ),
                                  const Gap(16),
                                  SizedBox(
                                    height: screenHeight / 4,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style: baseTextStyle12400.copyWith(
                                                    color: Colors
                                                        .black), // Ensures the main text is black
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${marketNews.data[index].article.description} ${marketNews.data[index].featuredHighlight.highlight.highlight.replaceAll(RegExp(r'<[^>]*>'), '')}',
                                                  ),
                                                ],
                                              ),
                                              maxLines: 8,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                String url = marketNews
                                                    .data[index].article.url;
                                                if (await canLaunchUrlString(
                                                    url)) {
                                                  await launchUrlString(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              },
                                              child: const Text(
                                                'Show more',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
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
                                              .image(height: 32, width: 32),
                                          onTap: () async {
                                            Share.share(
                                                'Hey! Checkout the latest stock market news & updates on Neosurge at https://onelink.to/2pdpvs');
                                          },
                                        ),
                                        GestureDetector(
                                          child: Assets.pngs.openLinkIcon
                                              .image(height: 32, width: 32),
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
                                  const Gap(20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        (index < marketNews.data.length - 1)
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Up next',
                                    ),
                                    const Gap(16),
                                    GestureDetector(
                                      onTap: () {
                                        if (_pageController.hasClients) {
                                          int nextPage = _currentPage + 1;
                                          if (nextPage <
                                              marketNews.data.length) {
                                            _pageController.animateToPage(
                                              nextPage,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut,
                                            );
                                            setState(() {
                                              _currentPage = nextPage;
                                            });
                                          }
                                        }
                                      },
                                      child: Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(16),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (marketNews
                                                      .data[index + 1]
                                                      .featuredHighlight
                                                      .highlight
                                                      .sentiment >
                                                  0)
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFE7FAF0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Assets
                                                          .gifs.trendingUp
                                                          .image(
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    const Gap(7),
                                                  ],
                                                ),
                                              if (marketNews
                                                      .data[index + 1]
                                                      .featuredHighlight
                                                      .highlight
                                                      .sentiment <
                                                  0)
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFE7FAF0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Assets
                                                          .gifs.trendingDown
                                                          .image(
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    const Gap(7),
                                                  ],
                                                ),
                                              Flexible(
                                                child: Text(
                                                  overflow: TextOverflow
                                                      .ellipsis, // Optional: use ellipsis for text overflow
                                                  maxLines: 2,
                                                  marketNews
                                                      .data[index + 1]
                                                      .featuredHighlight
                                                      .highlight
                                                      .highlight
                                                      .replaceAll(
                                                          RegExp(r'<[^>]*>'),
                                                          ''),
                                                  style: baseTextStyle14400
                                                      .copyWith(
                                                    color: marketNews
                                                                .data[index + 1]
                                                                .featuredHighlight
                                                                .highlight
                                                                .sentiment ==
                                                            0
                                                        ? const Color(
                                                            0xFF2E8EFF) // Blue color for sentiment == 0
                                                        : marketNews
                                                                    .data[
                                                                        index +
                                                                            1]
                                                                    .featuredHighlight
                                                                    .highlight
                                                                    .sentiment >
                                                                0
                                                            ? const Color(
                                                                0xFF11CE66) // Green color for sentiment > 0
                                                            : const Color(
                                                                0xFFFF4949), // Red color for sentiment < 0
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ); // Replace with actual content
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class DashedLineIndicator extends StatelessWidget {
  final int currentPage;
  final Color color1;
  final Color color2;
  final double dashCount;

  const DashedLineIndicator({
    Key? key,
    required this.currentPage,
    required this.color1,
    required this.color2,
    required this.dashCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double dashSpacing = 4.0;
        final double dashWidth =
            (constraints.maxWidth / dashCount) - dashSpacing;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            dashCount.toInt(),
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: currentPage == index ? color2 : color1,
              ),
              width: dashWidth, // Width of dash
              height: 6, // Height of dash
              margin: const EdgeInsets.symmetric(horizontal: dashSpacing / 2),
            ),
          ),
        );
      },
    );
  }
}
