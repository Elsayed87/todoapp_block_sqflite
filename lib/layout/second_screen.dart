import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_block_sqflite/layout/cubit.dart';
import 'package:todoapp_block_sqflite/layout/states.dart';

class Two extends StatelessWidget {
  const Two({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(' sum '),
          TextButton(
              onPressed: () {},
              child: Text('${BlocProvider.of<CounterCubit>(context).counter}'))
        ],
      ),
    );
  }
}
