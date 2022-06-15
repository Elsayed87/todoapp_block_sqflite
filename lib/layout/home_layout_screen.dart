import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_block_sqflite/shared/cubit/cubit.dart';
import 'package:todoapp_block_sqflite/shared/cubit/states.dart';

import '../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  var datePicker;
  bool isKeybord = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _timeEditingController = TextEditingController();
  TextEditingController _dateEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, Object? state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.lightBlueAccent,
                title: Text(cubit.titels[cubit.currentIndex]),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeCureentState(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: 'New Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline),
                        label: 'Done Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined),
                        label: 'Arechived Tasks'),
                  ]),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  cubit.bottomsheetstate(cubit.isButtonSheetShown);

                  if (cubit.isButtonSheetShown) {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                              padding: EdgeInsets.all(20.0),
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        decoration: titleInputDecoration,
                                        controller: _textEditingController,
                                        keyboardType: TextInputType.text,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'title must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      //************
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: timeInputDecoration,
                                        controller: _timeEditingController,
                                        keyboardType: TextInputType.none,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Time must not be empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) => {
                                                _timeEditingController.text =
                                                    value!
                                                        .format(context)
                                                        .toString()
                                              });
                                        },
                                      ),

                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: dateInputDecoration,
                                        controller: _dateEditingController,
                                        keyboardType: isKeybord
                                            ? TextInputType.none
                                            : TextInputType.datetime,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      "2023-10-10"))
                                              .then((value) => {
                                                    _dateEditingController
                                                            .text =
                                                        DateFormat.yMMMd()
                                                            .format(value!),
                                                  });
                                          // setState(() {
                                          //   isKeybord = false;
                                          // });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          elevation: 20.0,
                        )
                        .closed
                        .then((value) =>
                            {cubit.bottomsheetstate(cubit.isButtonSheetShown)});
                  } else {
                    if (formKey.currentState!.validate()) {
                      cubit.insertDatabase(
                          title: _textEditingController.text,
                          date: _dateEditingController.text,
                          time: _timeEditingController.text);
                    }
                  }
                },
                child: cubit.isButtonSheetShown
                    ? Icon(Icons.add)
                    : Icon(Icons.edit),
              ),
              body: ConditionalBuilder(
                  condition: state is! AppGetDataBaseLoadingState,
                  builder: (BuildContext context) =>
                      cubit.screens[cubit.currentIndex],
                  fallback: (BuildContext context) =>
                      CircularProgressIndicator()));
        },
      ),
    );
  }
}
