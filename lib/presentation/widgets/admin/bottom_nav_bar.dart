import 'package:flutter/material.dart';
import 'package:smart_delivery_car/presentation/screens/admin/completed_orders_screen.dart';
import 'package:smart_delivery_car/presentation/screens/admin/employee_home_screen.dart';

class DefaultNavBar extends StatefulWidget {
  const DefaultNavBar({Key? key}) : super(key: key);

  @override
  State<DefaultNavBar> createState() => _DefaultNavBarState();
}

class _DefaultNavBarState extends State<DefaultNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    EmployeeHomeScreen(),
    CompletedOrderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
