import 'package:flutter/material.dart';
import 'sector_tab.dart';

import '../../../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import '../../../../theme/app_colors.dart';
import 'analysis_section_card.dart';
import 'category_tab.dart';

class CategoryAndSectorTabView extends StatefulWidget {
  const CategoryAndSectorTabView({
    super.key,
    required this.category,
    required this.sector,
  });

  final List<SubcategoriesPercentage>? category;
  final List<SectorsPercentage>? sector;

  @override
  State<CategoryAndSectorTabView> createState() =>
      _CategoryAndSectorTabViewState();
}

class _CategoryAndSectorTabViewState extends State<CategoryAndSectorTabView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnalysisSessionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Color(0xFFEAEAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TabBar(
              indicator: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sector',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 440,
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                CategoryTab(
                  category: widget.category,
                ),
                SectorTab(
                  sector: widget.sector ?? [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
