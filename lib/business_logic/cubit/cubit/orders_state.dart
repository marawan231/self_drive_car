part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class CheckBoxChangedSuccessfully extends OrdersState{}