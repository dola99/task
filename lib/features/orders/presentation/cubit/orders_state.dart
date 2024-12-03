part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<MapEntry<DateTime, int>> orderData;
  final String selectedMonth;
  final List<String> availableMonths;

  const OrdersLoaded({
    required this.orderData,
    required this.selectedMonth,
    required this.availableMonths,
  });

  @override
  List<Object?> get props => [orderData, selectedMonth, availableMonths];

  OrdersLoaded copyWith({
    List<MapEntry<DateTime, int>>? orderData,
    String? selectedMonth,
    List<String>? availableMonths,
  }) {
    return OrdersLoaded(
      orderData: orderData ?? this.orderData,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      availableMonths: availableMonths ?? this.availableMonths,
    );
  }
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
