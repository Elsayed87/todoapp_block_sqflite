import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

Widget buildTaskItem(Map model,context) => Dismissible(

  key: Key(model['id'].toString()),
  child:   Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundColor: Colors.teal[500],
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).upDateData(status: 'done', id: model["id"]);
              },
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
              tooltip: 'Done Tasks',
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).upDateData(status: 'archived', id: model["id"]);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black54,
              ),
                tooltip: 'Archived Tasks'
            ),
          
          ],
        ),
      ),
  onDismissed: (DismissDirection){
    AppCubit.get(context).deleteTask(id: model["id"]);
  },
);



class ConditionalBuilderView extends StatelessWidget {
  ConditionalBuilderView({required this.tasks});
  List<Map> tasks;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return ConditionalBuilder(
      builder: (BuildContext context) => ListView.separated(

          itemBuilder: (BuildContext context, int index) =>
              buildTaskItem(tasks[index], context),
          separatorBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: tasks.length),
      fallback: (BuildContext context) => Container(
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              size: 70,
              color: Colors.red,
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'NO ${cubit.titels[cubit.currentIndex]}  !please add',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
      condition: tasks.length > 0,
    );
  }
}
