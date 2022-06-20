import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_delivery_car/data/model/place.dart';
import 'package:smart_delivery_car/presentation/screens/client/client_home_screen.dart';
import 'business_logic/cubit/maps/maps_cubit.dart';
import 'constants/strings.dart';
import 'data/repoistry/maps_repo.dart';
import 'data/web/places_web_services.dart';
import 'presentation/screens/admin/completed_orders_screen.dart';
import 'presentation/screens/admin/employee_home_screen.dart';
import 'presentation/screens/admin/home_screen.dart';
import 'presentation/screens/auth/auth_screen.dart';
import 'presentation/screens/client/order_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/orders/orders_cubit.dart';
import 'presentation/screens/client/map_screen.dart';

class AppRouter {
  late OrdersCubit ordersCubit;
  late MapsRepository mapsRepository;
  late MapsCubit mapsCubit;

  AppRouter() {
    ordersCubit = OrdersCubit();
    mapsRepository = MapsRepository(PlacesWebServices());
    mapsCubit = MapsCubit(mapsRepository);
  }

  Route? genertaRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case employeeScreen:
        return MaterialPageRoute(
          builder: (_) => const EmployeeHomeScreen(),
        );
      case orderScreen:
        final arguments = settings.arguments as Map;
        final polylinePoints = arguments['polylinePoints'] as List<LatLng>;
        final selectedPlace = arguments['selectedPlace'] as Place;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: mapsCubit,
            child: OrderScreen(
              polyLinePoints: polylinePoints,
              selectedPlace: selectedPlace,
            ),
          ),
        );
      case completeOrderScreen:
        return MaterialPageRoute(
          builder: (_) => const CompletedOrderScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: ordersCubit,
            child: const HomeScreen(),
          ),
        );

      case clientScreen:
        return MaterialPageRoute(
          builder: (_) => const ClientHomeScreen(),
        );

      case mapsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: mapsCubit,
            child: const MapsScreen(),
          ),
        );
    }
    return null;
  }
}
