import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_delivery_car/data/model/order.dart';
import 'package:smart_delivery_car/presentation/widgets/client/default_form_field.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final TextEditingController titleControler = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    titleControler.dispose();
    quantityController.dispose();
  }

  buildAppBar(context) {
    return AppBar(
      title: const Text('clientHomeScreen'),
      actions: [
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, authScreen);
          },
          child: const Text(
            'log out',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  buildTheFormFieldsOfOrderAndQuantity() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultFormField(
            controller: titleControler,
            isPassword: false,
            hintText: 'please enter your order here',
            labelText: 'order',
            textInputType: TextInputType.text,
            prefixcIcon: Icons.title,
          ),
          const SizedBox(
            height: 30,
          ),
          DefaultFormField(
            controller: quantityController,
            isPassword: false,
            hintText: 'please enter your quantity here',
            labelText: 'quantity',
            textInputType: TextInputType.number,
            prefixcIcon: Icons.numbers,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: TextButton(
            style: textButtonStyle,
            child: const Text(
              'Order',
              style: textInTextButtonStyle,
            ),
            onPressed: () {
              sendOrderToFireBase();
              clearFields();
              showSnackBar();
            },
          )),
        ],
      ),
    );
  }

  Future<void> sendOrderToFireBase() async {
    final docOrder = FirebaseFirestore.instance.collection('orders').doc();

    final newOrder = Order(
      isDone: false,
      id: docOrder.id,
      title: titleControler.text,
      quantity: quantityController.text,
    ).toJson();

    await docOrder.set(newOrder);
  }

  void clearFields() {
    titleControler.clear();
    quantityController.clear();
  }

  showSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Order  is Ordered Successfully "),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildTheFormFieldsOfOrderAndQuantity(),
    );
  }
}
