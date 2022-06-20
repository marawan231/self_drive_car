import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/strings.dart';

class PlacesWebServices {
  late Dio dio;
  PlacesWebServices() {
    BaseOptions options = BaseOptions(
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> fetchSuggestion(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(suggestionBaseUrl, queryParameters: {
        'input': place,
        'type': 'address',
        'components': 'country:eg',
        'key': googleApiKey,
        'sessiontoken': sessionToken,
      });
      // print(response.data['predictions']);
      // print(response.statusCode);
      return response.data['predictions'];
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }

  Future<dynamic> getPlaceLOcation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        placeLocationBaseUrl,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': googleApiKey,
          'sessiontoken': sessionToken,
        },
      );

      return response.data;
    } catch (e) {
      // ignore: avoid_print

      return Future.error('place loccation error  :   ',
          StackTrace.fromString(('this is its trace')));
    }
  }

//origin equals currentLOcation
//destination is searched location
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsBaseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleApiKey,
        },
      );

      return response.data;
    } catch (e) {
      // ignore: avoid_print

      return Future.error('place loccation error  :   ',
          StackTrace.fromString(('this is its trace')));
    }
  }
}
