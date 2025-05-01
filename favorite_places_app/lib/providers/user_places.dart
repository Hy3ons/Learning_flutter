import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image BLOB, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    state =
        data.map((Map<String, Object?> row) {
          return Place(
            title: row['title'] as String,
            image: row['image'] as Uint8List?,
            location:
                row['lat'] == null
                    ? null
                    : PlaceLocation(
                      latitude: row['lat'] as double,
                      longitude: row['lng'] as double,
                      address: row['address'] as String,
                    ),
            id: row['id'] as String,
          );
        }).toList();
  }

  void addPlace(String title, Uint8List? image, PlaceLocation? location) async {
    final newPlace = Place(title: title, image: image, location: location);

    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': image,
      'lat': location == null ? null : location.latitude,
      'lng': location == null ? null : location.longitude,
      'address': location == null ? null : newPlace.location!.address,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
      (ref) => UserPlacesNotifier(),
    );
