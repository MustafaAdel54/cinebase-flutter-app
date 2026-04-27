import 'package:flutter/material.dart';

import 'category_selector.dart';
import 'for_you_section.dart';
import 'home_screen_header.dart';
import 'movie_section.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String _currentCategory = "All";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeScreenHeader(),
          CategorySelector(
            selectedCategory: _currentCategory,
            onCategorySelected: (category) {
              setState(() {
                _currentCategory = category;
              });
            },
          ),
          MovieSection(category: _currentCategory),
          ForYouSection(
            match: '98% Match',
            title: 'Blade Runner 2049',
            imagePath: 'assets/images/dune.jpg',
          ),
        ],
      ),
    );
  }
}
