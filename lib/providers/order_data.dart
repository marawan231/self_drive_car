import 'package:flutter/foundation.dart';
import 'package:smart_delivery_car/data/model/order.dart';

import 'dart:collection';

class OrderData extends ChangeNotifier {
  final List<Order> _orders = [];

  UnmodifiableListView<Order> get orders {
    return UnmodifiableListView(_orders);
  }

  void toogleOrderState(Order order) {
    order.isDone = !order.isDone!;
    notifyListeners();
  }

  void deleteTask(Order order) {
    _orders.remove(order);
    notifyListeners();
  }

  int get orderCount {
    return _orders.length;
  }
}
