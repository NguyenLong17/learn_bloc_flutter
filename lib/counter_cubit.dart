import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  int counter = 0;

  void increment() {
    counter = counter +1;
    emit(state + 1);
  }
  void decrement()
  {
    counter = counter - 1;
    emit(state - 1);
  }
}