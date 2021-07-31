import 'package:conditional_builder/conditional_builder.dart';
import 'package:ecommerce_app/shared/cubit/cubit.dart';
import 'package:ecommerce_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShow) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          // color: Colors.grey[200],
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: titleController,
                                    validator: (String v) {
                                      if (v.isEmpty) {
                                        return 'title must be not empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.title),
                                      labelText: 'task title',
                                      labelStyle: TextStyle(fontSize: 10),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: timeController,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value.format(context).toString();
                                        print(value.format(context));
                                      });
                                      print('timing tapped');
                                    },
                                    validator: (String v) {
                                      if (v.isEmpty) {
                                        return 'time must be not empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.watch_later_outlined),
                                      labelText: 'task time',
                                      labelStyle: TextStyle(fontSize: 10),
                                    ),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: dateController,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2021-08-15'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
                                        print(DateFormat.yMMMd().format(value));
                                      });
                                    },
                                    validator: (String v) {
                                      if (v.isEmpty) {
                                        return 'date must be not empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today),
                                      labelText: 'task date',
                                      labelStyle: TextStyle(fontSize: 10),
                                    ),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        elevation: 15,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      icon: Icons.edit,
                      isShow: false,
                    );
                  });
                  cubit.changeBottomSheetState(
                    icon: Icons.add,
                    isShow: true,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'taskes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'archive',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// insertToDatabase(
//   title: titleController.text,
//   date: dateController.text,
//   time: timeController.text,
// ).then((value) {
//   getDataFromDatabase(database).then((value) {
//     Navigator.pop(context);
//     // setState(() {
//     //   isBottomSheetShow = false;
//     //   fabIcon = Icons.edit;
//     //   tasks = value;
//     // });
//   });
// });
// try {
//   var name = await getName();
//   print(name);
//   throw('some error 2!!');
// }catch(error){
//   print('error ${error.toString()}');
// }
// getName().then((value){
//   print(value);
//   print('ahmed');
//   throw('some error 2!!');
// }).catchError((error){
//   print('error ${error.toString()}');
// });