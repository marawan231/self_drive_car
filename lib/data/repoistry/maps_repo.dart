import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/place_directions.dart';

import '../model/place.dart';
import '../model/place_suggestion.dart';
import '../web/places_web_services.dart';

class MapsRepository {
  final PlacesWebServices placesWebServices;

  MapsRepository(this.placesWebServices);

  Future<List<PlaceSuggestion>> fetchSuggestion(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebServices.fetchSuggestion(place, sessionToken);
    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebServices.getPlaceLOcation(placeId, sessionToken);
    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final direction =
        await placesWebServices.getDirections(origin, destination);
    return PlaceDirections.fromJson(direction);
  }
}
