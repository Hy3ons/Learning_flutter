import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  // Map<Filter, bool> _selectedFilters = {
  //   Filter.glutenFree: false,
  //   Filter.Vegetarian: false,
  //   Filter.lactoseFree: false,
  //   Filter.vegan: false,
  // };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), //
      ),
    );
  }

  // deprecated _toggleMealFavoriteStatus Code.
  // 이제는 flutter_riverpod로 favorite의 상태를 관리합니다.

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('Meal is no longer a favorite.');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Meal is now a favorite.');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );

      // .then((value) {
      //   setState(() {
      //     _selectedFilters = value ?? _selectedFilters;
      //   });
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch<List<Meal>>(mealsProvider);
    final selectedFilters = ref.watch(filtersProvider);

    final availableMeals =
        meals.where((meal) {
          if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }

          if (selectedFilters[Filter.Vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }

          return true;
        }).toList();

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(list: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),

      drawer: MainDrawer(onSelectScreen: _setScreen),

      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
