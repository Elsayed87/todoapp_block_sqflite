import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_block_sqflite/layout/cubit.dart';
import 'package:todoapp_block_sqflite/layout/second_screen.dart';
import 'package:todoapp_block_sqflite/layout/states.dart';

class TestBlock extends StatelessWidget {
  const TestBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),

      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (
          BuildContext context, state) {
          if( state is CounterPlusState){

          }
          if( state is CounterMinusState){

          }
          if( state is  CounterTestState){

          }
        },
        builder: (BuildContext context, Object? state) => Scaffold(
          appBar: AppBar(),
          body: Column(


            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).minus();

                      },
                      child: Text('minus'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${BlocProvider.of<CounterCubit>(context).counter}'),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).plus();

                      },
                      child: Text('plus'),
                    ),
                  ),
                ],
              ),
              TextButton(onPressed: () {
                Navigator.push(  context,
                    MaterialPageRoute (
                        builder: (BuildContext context) =>  Two()));

              },
                child: Text('press'),


              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).testAdd();
                },
                child: Text('testadd '),
              ),
              Text('the counter of x state is:${BlocProvider.of<CounterCubit>(context).x}')
            ],
          ),
        ),

      ),
    );


  }
}

