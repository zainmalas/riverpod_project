import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/provider/meals_provider.dart';
import 'package:my_app/screens/categories.dart';
import 'package:my_app/screens/filters.dart';
import 'package:my_app/screens/meals.dart';
import 'package:my_app/widgets/main_drawer.dart';
import 'package:my_app/provider/favorites_provider.dart';

const kInitialFilters = {
  Filter.gluttenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsSreen extends ConsumerStatefulWidget {
  const TabsSreen({
    super.key,
  });
  @override
  ConsumerState<TabsSreen> createState() => _TabsSreenState();
}

class _TabsSreenState extends ConsumerState<TabsSreen> {
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  int _selectedPageIndex = 0;
  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                    currentFilter: _selectedFilter,
                  )));
      setState(() {
        _selectedFilter = result ?? _selectedFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilter[Filter.gluttenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    var activePageTitle = 'Categories';
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favoritesMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
      activePageTitle = ' your Favorates';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorates'),
        ],
      ),
    );
  }
}
