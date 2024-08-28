part of 'counter_cubit_cubit.dart';

sealed class CounterCubitState {}

final class CounterCubitValue extends CounterCubitState {
  CounterCubitValue({required this.value});
  final int value;
}

final class CounterCubitStatus extends CounterCubitState {
  final String message;

  CounterCubitStatus({required this.message});
}
