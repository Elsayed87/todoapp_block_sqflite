import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_block_sqflite/layout/cubit.dart';
import 'package:todoapp_block_sqflite/layout/states.dart';
import 'package:todoapp_block_sqflite/shared/bloc_observer.dart';

import 'layout/cubit.dart';
import 'layout/home_layout_screen.dart';
import 'layout/test_screen.dart';

void main() {
  BlocOverrides.runZoned(
        () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeLayout (),
    );
  }
}
