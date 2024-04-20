import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/meal.dart';

class FavoirteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoirteMealsNotifier() : super([]);

// we can not add of remove in  StateNotifier we need to create new list
  bool toggleMealFavoriteStateus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    //removing meal
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      //add new meal we keep all and then we add the new meal
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoirteMealsNotifier, List<Meal>>((ref) {
  return FavoirteMealsNotifier();
});
