import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Order {
  final currentUser = FirebaseAuth.instance.currentUser;
  final String? title;
  String? id;
  final String? quantity;
  List<LatLng>? polylineList;

  bool? isDone;

  void toogleOrderState() {
    isDone = !isDone!;
  }

  Order({
    this.polylineList,
    this.isDone,
    this.title,
    this.quantity,
    required this.id,
  });

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      title: json['order'],
      quantity: json['quantity'],
      id: json['uid'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'order': title,
        'quantity': quantity,
        'uid': id,
        'isDone': isDone,
        'lat': polylineList == null
            ? 'null'
            : polylineList!.map((e) => (e.latitude)).toList(),
        'lng': polylineList == null
            ? 'null'
            : polylineList!.map((e) => e.longitude).toList(),
      };
}

// class Polyline {
//   double? lat;
//   double? lng;

//   Polyline({this.lat, this.lng});

//   Map<String, dynamic> toJson() {
// return {
//   "lat": lat,
//   "lng" : lng,
// };
// }
// }
