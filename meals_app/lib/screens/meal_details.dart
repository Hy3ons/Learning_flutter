import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), //

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),

            child: IconButton(
              onPressed: () {
                bool wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasAdded ? 'Meal added as Favorite.' : 'Meal removed.',
                    ), //
                  ),
                );
              },
              icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),

              child: Container(
                height: 300,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),

                  image: DecorationImage(
                    image: NetworkImage(meal.imageUrl), //
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...meal.ingredients.map(
              (ingredient) => Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...meal.steps.map((step) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),

                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              );
            }),

            //
          ],
        ),
      ),
    );
  }
}
