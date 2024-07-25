import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../data/models/equity/login/equity_brokers.dart';
import 'login_gridview_imageitems_screen.dart';

class ImageGridView extends StatefulWidget {
  final PageController pageController;
  final List<BrokersModel> brokerList;
  final int currentPage;
  final Function(String) selectBrokerKey;
  final Function(String) selectBrokerName;
  final String selectedBrokerKey;

  const ImageGridView({
    super.key,
    required this.pageController,
    required this.brokerList,
    required this.currentPage,
    required this.selectBrokerKey,
    required this.selectBrokerName,
    required this.selectedBrokerKey,
  });

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  String? selectedBrokerId;

  @override
  void initState() {
    for (var element in widget.brokerList) {
      if (element.key.toUpperCase() == widget.selectedBrokerKey) {
        selectedBrokerId = element.id;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.brokerList.length / 9).ceil();

    return Stack(
      children: [
        PageView.builder(
          controller: widget.pageController,
          itemCount: totalPages,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var remainingElements = widget.brokerList.length - index * 9;
            int elementsPerPage;

            if (remainingElements >= 9) {
              elementsPerPage = 9;
            } else {
              elementsPerPage = remainingElements + 9;
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 18.0,
                    mainAxisSpacing: 18.0,
                  ),
                  physics: const ClampingScrollPhysics(),
                  itemCount: elementsPerPage,
                  itemBuilder: (context, gridViewIndex) {
                    final innerIndex = index * 9 + gridViewIndex;

                    return ImageItem(
                      imageUrl: widget.brokerList[innerIndex].icon,
                      name: widget.brokerList[innerIndex].broker,
                      isSelected:
                          widget.brokerList[innerIndex].id == selectedBrokerId,
                      onTap: () {
                        setState(() {
                          selectedBrokerId = widget.brokerList[innerIndex].id;
                          widget.selectBrokerKey(
                            widget.brokerList[innerIndex].key,
                          );
                          widget.selectBrokerName(
                            widget.brokerList[innerIndex].broker,
                          );
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 16.0,
          left: 0,
          right: 0,
          child: buildPageIndicator(
            widget.currentPage,
            totalPages,
          ),
        ),
      ],
    );
  }

  Widget buildPageIndicator(int currentPage, int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => buildIndicator(currentPage, index),
      ),
    );
  }

//indicator UI
  Widget buildIndicator(int currentPage, int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
