import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SelfDrivenCar(
    appRouter: AppRouter(),
  ));
}

class SelfDrivenCar extends StatelessWidget {
  const SelfDrivenCar({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRouter.genertaRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
