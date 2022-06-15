

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_block_sqflite/layout/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitialState());
  // 1-static CounterCubit get(context)=>BlocProvider.of(context);
  //2-static for make it easy to access it from any site inside the project.
//3-this for using the object for access to any thing inside the class
  // 4-CounterCubit.get(Context).anything

  int counter=0;
  int x=0;
  void plus(){
    counter++;
    emit(CounterPlusState (counter));
  }
  void minus(){
    counter--;
    emit(CounterPlusState (counter));
  }
  void testAdd(){
    x=x+5;
    emit(CounterTestState (x));
  }
}