// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_app/provider/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });
  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vagetarianFreeFilterSet = false;
  var _vegenFreeFilterSet = false;
  @override
  void initState() {
    super.initState();
    final activeFilter = ref.read(filtersProvider);
    _glutenFreeFilterSet = activeFilter[Filter.gluttenfree]!;
    _lactoseFreeFilterSet = activeFilter[Filter.lactosefree]!;
    _vegenFreeFilterSet = activeFilter[Filter.vegan]!;
    _vagetarianFreeFilterSet = activeFilter[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        onPopInvoked: (didPop) {},
        child: WillPopScope(
          onWillPop: () async {
            ref.read(filtersProvider.notifier).setFilters({
              Filter.gluttenfree: _glutenFreeFilterSet,
              Filter.lactosefree: _lactoseFreeFilterSet,
              Filter.vegan: _vegenFreeFilterSet,
              Filter.vegetarian: _vagetarianFreeFilterSet,
            });
            // Navigator.of(context).pop();
            return true;
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _glutenFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenFreeFilterSet = isChecked;
                  });
                },
                title: Text(
                  'Gluten-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'only incode gluten-free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _lactoseFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _lactoseFreeFilterSet = isChecked;
                  });
                },
                title: Text(
                  'Lactose-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'only incode lactose-free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _vagetarianFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _vagetarianFreeFilterSet = isChecked;
                  });
                },
                title: Text(
                  'vegetarin_free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'only incode vegetarin_free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _vegenFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _vegenFreeFilterSet = isChecked;
                  });
                },
                title: Text(
                  'vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'only incode vagen-free meals',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
