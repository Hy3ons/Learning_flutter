import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final selectedList =
        availableMeals
            .where((Meal meal) => meal.categories.contains(category.id))
            .toList();

    // Navigator.push(context, route);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, list: selectedList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,

        childAspectRatio: 1.5,
      ),

      children: [
        ...availableCategories.map((Category category) {
          return CategoryGridItem(
            category: category,

            tapped: () {
              _selectCategory(context, category);
            },
          );
        }),
      ],
    );
  }
}
