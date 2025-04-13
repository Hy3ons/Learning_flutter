import 'package:flutter/material.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;

  @override
  void initState() {
    super.initState();
    final mp = ref.read<Map<Filter, bool>>(filtersProvider);

    _glutenFreeFilterSet = mp[Filter.glutenFree]!;
    _lactoseFreeFilterSet = mp[Filter.lactoseFree]!;
    _veganFilterSet = mp[Filter.vegan]!;
    _vegetarianFilterSet = mp[Filter.Vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.Vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });

          // ref
          //     .read(filtersProvider.notifier)
          //     .setFilter(Filter.Vegetarian, _vegetarianFilterSet);
          // ref
          //     .read(filtersProvider.notifier)
          //     .setFilter(Filter.lactoseFree, _lactoseFreeFilterSet);
          // ref
          //     .read(filtersProvider.notifier)
          //     .setFilter(Filter.glutenFree, _glutenFreeFilterSet);
          // ref
          //     .read(filtersProvider.notifier)
          //     .setFilter(Filter.vegan, _veganFilterSet);

          Navigator.of(context).pop();

          return;
        },

        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (state) {
                // ref
                //     .read(filtersProvider.notifier)
                //     .setFilter(Filter.glutenFree, state);

                setState(() {
                  _glutenFreeFilterSet = state;
                });
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
              value: _lactoseFreeFilterSet,
              onChanged: (state) {
                // ref
                //     .read(filtersProvider.notifier)
                //     .setFilter(Filter.lactoseFree, state);

                setState(() {
                  _lactoseFreeFilterSet = state;
                });
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
              value: _vegetarianFilterSet,
              onChanged: (state) {
                // ref
                //     .read(filtersProvider.notifier)
                //     .setFilter(Filter.Vegetarian, state);

                setState(() {
                  _vegetarianFilterSet = state;
                });
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
              value: _veganFilterSet,
              onChanged: (state) {
                // ref
                //     .read(filtersProvider.notifier)
                //     .setFilter(Filter.vegan, state);

                setState(() {
                  _veganFilterSet = state;
                });
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
      ),
    );
  }
}
