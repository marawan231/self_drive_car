import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_delivery_car/data/model/place.dart';
import '../../../constants/colors.dart';
import '../../../data/model/order.dart';
import '../../widgets/client/default_form_field.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key, this.polyLinePoints, this.selectedPlace})
      : super(key: key);
  final List<LatLng>? polyLinePoints;
  final Place? selectedPlace;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, authScreen);
          },
          icon: const Icon(
            Icons.logout,
            color: onBoardingTextButtonColor,
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
                showQrCodeInBottomSheet();
                clearFields();
              },
            ),
          ),
        ],
      ),
    );
  }

  showQrCodeInBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildQrCode(),
                buildTextOfOrder(),
              ],
            ),
          );
        });
  }

  buildTextOfOrder() {
    return const Text(
      "Your Order  Placed Successfully and please keep your qr code with you to recieve your order safely",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  buildQrCode() {
    return QrImage(
      data: FirebaseAuth.instance.currentUser!.uid,
      backgroundColor: Colors.white,
      size: 200,
    );
  }

  Future<void> sendOrderToFireBase() async {
    final docOrder = FirebaseFirestore.instance.collection('orders').doc();

    final newOrder = Order(
      isDone: false,
      id: docOrder.id,
      title: titleControler.text,
      quantity: quantityController.text,
      polylineList: widget.polyLinePoints,
    ).toJson();

    await docOrder.set(newOrder);
  }

  void clearFields() {
    titleControler.clear();
    quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildTheFormFieldsOfOrderAndQuantity(),
    );
  }
}
