import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_block_sqflite/shared/cubit/cubit.dart';
import 'package:todoapp_block_sqflite/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).newtasks;
        return ConditionalBuilderView(tasks: tasks);
      },
    );
  }
}
