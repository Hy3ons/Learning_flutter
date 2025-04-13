import 'package:flutter/material.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Filter, bool> activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your filters')),

      // drawer: MainDrawer(
      //   onSelectScreen: (String identifier) {
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (state) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, state);
            },
            title: Text(
              'Gluten-free',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ), //

            subtitle: Text(
              'Only include gluten-free meals.',

              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),

          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (state) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, state);
            },
            title: Text(
              'Lactose-free',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ), //

            subtitle: Text(
              'Only include Lactose-free meals.',

              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),

          SwitchListTile(
            value: activeFilters[Filter.Vegetarian]!,
            onChanged: (state) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.Vegetarian, state);
            },
            title: Text(
              'Vegetarian',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ), //

            subtitle: Text(
              'Only include Vegetarian meals.',

              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),

          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (state) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, state);
            },
            title: Text(
              'Vegan',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ), //

            subtitle: Text(
              'Only include Vegan meals.',

              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
