import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/strings.dart';
import '../../../data/model/order.dart';
import '../../widgets/client/order_tile.dart';

import '../../../business_logic/cubit/orders/orders_cubit.dart';
import '../../../constants/styles.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: const Text('employyee Home Screen'),
      actions: [
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, authScreen);
          },
          child: Row(
            children: const [
              Text(
                'log out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildStreamOfOrders() {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return StreamBuilder<List<Order>>(
          stream: readOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something Went Wrong');
            } else if (snapshot.hasData) {
              BlocProvider.of<OrdersCubit>(context).allOrders = snapshot.data;

              return ListView(
                children: BlocProvider.of<OrdersCubit>(context)
                    .allOrders!
                    .map(
                      (order) => OrderTile(
                        taskText: '${order.quantity}   ${order.title}',
                        isChecked: order.isDone,
                        onChangedTask: (checkBoxState) {
                          BlocProvider.of<OrdersCubit>(context)
                              .updateTask(order);
                        },
                        onDelete: () {},
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }

  builfBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 30,
            left: 30,
            right: 30,
            top: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: Icon(
                  Icons.list,
                  color: Colors.blueAccent,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: buildStreamOfOrders(),
            decoration: containerDicoration,
          ),
        ),
      ],
    );
  }

  Stream<List<Order>> readOrders() => FirebaseFirestore.instance
      .collection('orders')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: buildAppBar(context),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return builfBody(context);
        },
      ),
    );
  }
}
