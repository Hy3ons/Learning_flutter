import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/filters.dart';

enum Filter { glutenFree, lactoseFree, Vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.Vegetarian: false,
        Filter.lactoseFree: false,
        Filter.vegan: false,
      });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> map) {
    state = map;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
      return FiltersNotifier();
    });

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
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
});
