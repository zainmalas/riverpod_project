import 'package:flutter/material.dart';
import 'package:my_app/data/dummy_data.dart';
import 'package:my_app/models/meal.dart';
import 'package:my_app/screens/meals.dart';
import 'package:my_app/widgets/categories_grid_item.dart';
import 'package:my_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filterdMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                title: category.title,
                meals: filterdMeals,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCatecory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
