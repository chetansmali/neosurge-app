import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../constants/dropdown_constants.dart';
import '../../../data/models/dropdowns/country_model.dart';

class StringListScreen extends StatefulWidget {
  final String title;
  final List<DropDownItem> items;

  const StringListScreen({super.key, required this.items, required this.title});

  @override
  State<StringListScreen> createState() => _StringListScreenState();
}

class _StringListScreenState extends State<StringListScreen> {
  List<DropDownItem> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  late String title;
  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_searchItems);
    title = widget.title;
  }

  _searchItems() {
    final query = searchController.text;
    if (query.isNotEmpty) {
      final List<DropDownItem> searchResult = widget.items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredItems = searchResult;
      });
    } else {
      setState(() {
        filteredItems = widget.items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: baseTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // This sets the border radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: 'Search for ${title.toLowerCase()}',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF151A20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index].name),
                  onTap: () {
                    Navigator.pop(context, filteredItems[index].value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.removeListener(_searchItems);
    searchController.dispose();
    super.dispose();
  }
}

class StringListScreen2 extends StatefulWidget {
  final String title;
  final List<CountryModel> items;

  const StringListScreen2(
      {super.key, required this.items, required this.title});

  @override
  State<StringListScreen2> createState() => _StringListScreen2State();
}

class _StringListScreen2State extends State<StringListScreen2> {
  List<CountryModel> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  late String title;
  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_searchItems);
    title = widget.title;
  }

  _searchItems() {
    final query = searchController.text;
    if (query.isNotEmpty) {
      final List<CountryModel> searchResult = widget.items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        filteredItems = searchResult;
      });
    } else {
      setState(() {
        filteredItems = widget.items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: baseTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // This sets the border radius
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: 'Search for ${title.toLowerCase()}',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF151A20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index].name),
                  onTap: () {
                    Navigator.pop(context, filteredItems[index].id);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.removeListener(_searchItems);
    searchController.dispose();
    super.dispose();
  }
}
