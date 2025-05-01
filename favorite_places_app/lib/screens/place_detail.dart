import 'package:favorite_places_app/configs/env.dart';
import 'package:favorite_places_app/screens/map.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places_app/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  String get locationImage {
    if (place.location == null) return '';

    final lat = place.location!.latitude;
    final lng = place.location!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:A%7C$lat,$lng&key=$GOOGLE_API_KEY';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          //
          Image.memory(
            place.image!,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (place.location == null) return;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return MapScreen(
                            location: place.location!,
                            isSelecting: false,
                          );
                        },
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  child: Text(
                    place.location!.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
