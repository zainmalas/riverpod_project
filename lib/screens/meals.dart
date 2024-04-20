import 'package:flutter/material.dart';
import 'package:my_app/models/meal.dart';
import 'package:my_app/screens/meal_details.dart';
import 'package:my_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDatilsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget contant = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'uh  oh ... nothing here!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'Try selectiong different category !',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    ));
    if (meals.isNotEmpty) {
      contant = ListView.builder(
        itemCount: meals.length,
        itemBuilder: ((ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: (meals) {
              selectMeal(context, meals);
            })),
      );
    }
    if (title == null) {
      return contant;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: contant);
  }
}
