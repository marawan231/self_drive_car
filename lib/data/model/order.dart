import 'package:firebase_auth/firebase_auth.dart';

class Order {
  final currentUser = FirebaseAuth.instance.currentUser;
  final String title;
  String? id;
  final String quantity;

  bool? isDone;

  void toogleOrderState() {
    isDone = !isDone!;
  }

  Order({
    this.isDone,
    required this.title,
    required this.quantity,
    this.id = '',
  });

  static Order fromJson(Map<String, dynamic> json) => Order(
        title: json['order'],
        quantity: json['quantity'],
        id: json['uid'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'order': title,
        'quantity': quantity,
        'uid': id,
        'isDone': isDone,
      };
}
