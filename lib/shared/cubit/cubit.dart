import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_block_sqflite/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import '../../modules/archivedtasks/archivedtasks_screen.dart';
import '../../modules/donetasks/donetasks_screen.dart';
import '../../modules/newtasks/newtasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  Database? database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> arachivetasks = [];
  bool isButtonSheetShown = false;
  List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen()
  ];
  List<String> titels = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeCureentState(int index) {
    currentIndex = index;
    emit(AppChangeNavBottomState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, int version) {
      print('database created');

      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date Text, time Text,status Text)')
          .then((value) {
        print('table created');
      }).catchError((e) {
        print(e);
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print('data base opend');
    }).then((value) => {
      database = value,
      emit(AppCreateDataBaseState())});
  }

  insertDatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title, date, time,status) VALUES("$title", "$date", "$time","new")')
          .then((value) {
        emit(AppInsertDataBaseState());
        print(' the inserted successfully done $value');
        getDataFromDataBase(database);
      }).catchError((error) {
        print('the error is $error');
      });
      return null;
    });
  }

  void getDataFromDataBase(database) {
    newtasks = [];
     donetasks = [];
    arachivetasks = [];

    emit(AppGetDataBaseLoadingState());
    database!.rawQuery('SELECT * FROM Tasks ').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
         else if (element['status'] == 'archived')
          arachivetasks.add(element);
         else
          donetasks.add(element);

      });
      emit(AppGetDataBaseState());
    });
  }

  void bottomsheetstate(bool isshow) {
    isButtonSheetShown = !isButtonSheetShown;
    emit(AppChangeBottomSheetState());
  }

  void upDateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteTask({required int id}) {
    database!
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) => {
              // emit(AppUpdateDataBaseState()),

             getDataFromDataBase(database),
              emit(AppDeleteDataBaseState()),
            });
  }
}
