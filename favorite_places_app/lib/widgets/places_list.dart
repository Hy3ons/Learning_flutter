import 'package:favorite_places_app/screens/place_detail.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places_app/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder:
          (ctx, index) => ListTile(
            leading:
                places[index].image == null
                    ? null
                    : CircleAvatar(
                      radius: 25,
                      backgroundImage: MemoryImage(places[index].image!),
                    ),

            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            subtitle:
                places[index].location == null
                    ? null
                    : Text(
                      places[index].location!.address,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),

            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailScreen(place: places[index]),
                ),
              );
            },
          ),
    );
  }
}
