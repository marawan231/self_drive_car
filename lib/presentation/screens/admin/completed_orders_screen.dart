import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/order.dart';
import '../../widgets/client/order_tile.dart';

import '../../../business_logic/cubit/orders/orders_cubit.dart';
import '../../../constants/styles.dart';

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({Key? key}) : super(key: key);

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  List<Order> completedOrder = [];
  @override
  void initState() {
    super.initState();
    completedOrder = BlocProvider.of<OrdersCubit>(context)
        .allOrders!
        .where((order) => order.isDone == true)
        .toList();
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
                'Completed Orders',
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
            child: buildCompletedOrder(),
            decoration: containerDicoration,
          ),
        ),
      ],
    );
  }

  buildCompletedOrder() {
    return ListView.builder(
      itemCount: completedOrder.length,
      itemBuilder: ((context, index) {
        return OrderTile(
          taskText: completedOrder[index].title,
          isChecked: completedOrder[index].isDone,
          onChangedTask: (checkBoxState) {
            BlocProvider.of<OrdersCubit>(context)
                .updateTask(completedOrder[index]);
          },
          onDelete: () {},
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Completed Orders'),
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return builfBody(context);
        },
      ),
    );
  }
}
