import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories = [
    'All', 'Music', 'Gaming', 'Mixes', 'Live', 'News', 'Movies', 'Fashion', 'Learning'
  ];

  CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Chip(
              label: Text(categories[index]),
              backgroundColor: index == 0 ? Colors.white : const Color(0xFF272727),
              labelStyle: TextStyle(
                color: index == 0 ? Colors.black : Colors.white,
                fontWeight: FontWeight.w500,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        },
      ),
    );
  }
}
