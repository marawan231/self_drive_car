import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_delivery_car/constants/strings.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  buildBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCentreText(),
        buildButtons(context),
      ],
    );
  }

  buildButtons(context) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: onBoardingTextButtonColor,
          ),
          child: const Text(
            'Select Location from Global map ',
            style: textInTextButtonStyle,
          ),
          onPressed: () {
            Navigator.pushNamed(context, mapsScreen);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: onBoardingTextButtonColor,
          ),
          child: const Text(
            'Select Location from local map ',
            style: textInTextButtonStyle,
          ),
          onPressed: () {
            // todo : local map screen create.
          },
        ),
      ],
    );
  }

  buildCentreText() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 400,
            height: 250,
            child: Lottie.asset('assets/images/waiting.json')),
        const Text(
          'Why waiting ?',
          style: TextStyle(
            color: Color(0xFF5A6A8D),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Order easily at any time\n- pick a drop point \n- wait for our smart car\n to drop your order',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 90, 106, 141),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: buildBody(context),
    );
  }
}
