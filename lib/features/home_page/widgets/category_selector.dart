import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String selectedCategory;

  const CategorySelector({
    super.key,
    required this.onCategorySelected,
    required this.selectedCategory,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> categories = [
    'All',
    'Action',
    'Sci-Fi',
    'Drama',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isActive = widget.selectedCategory == categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isActive,
              onSelected: (bool selected) {
                if (selected) {
                  widget.onCategorySelected(categories[index]);
                }
              },

              labelStyle: TextStyle(
                color: isActive ? Colors.black : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: const Color(0xFF1A1A1A),
              selectedColor: const Color(0xFFFFD740),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.transparent),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
