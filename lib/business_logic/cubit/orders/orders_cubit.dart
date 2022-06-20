import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../data/model/order.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  List<Order>? allOrders = [];

  void updateTask(Order order) {
    order.toogleOrderState();
    final orderDoc =
        FirebaseFirestore.instance.collection('orders').doc(order.id);
    orderDoc.update({
      'isDone': order.isDone,
    });
    emit(CheckBoxChangedSuccessfully());
  }
}
