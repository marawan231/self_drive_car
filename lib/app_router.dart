import 'package:flutter/material.dart';
import 'package:smart_delivery_car/business_logic/cubit/cubit/orders_cubit.dart';
import 'package:smart_delivery_car/constants/strings.dart';
import 'package:smart_delivery_car/presentation/screens/admin/completed_orders_screen.dart';
import 'package:smart_delivery_car/presentation/screens/admin/employee_home_screen.dart';
import 'package:smart_delivery_car/presentation/screens/admin/home_screen.dart';
import 'package:smart_delivery_car/presentation/screens/auth/auth_screen.dart';
import 'package:smart_delivery_car/presentation/screens/client/client_home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late OrdersCubit ordersCubit;
  AppRouter() {
    ordersCubit = OrdersCubit();
  }

  Route? genertaRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case employeeScreen:
        return MaterialPageRoute(
          builder: (_) => EmployeeHomeScreen(),
        );
      case clientScreen:
        return MaterialPageRoute(
          builder: (_) => const ClientHomeScreen(),
        );
      case completeOrderScreen:
        return MaterialPageRoute(
          builder: (_) => const CompletedOrderScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: ordersCubit,
            child: HomeScreen(),
          ),
        );
    }
    return null;
  }
}
