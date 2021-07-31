import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/layout/news_app/cubit/cubit.dart';
import 'package:ecommerce_app/layout/news_app/cubit/states.dart';
import 'package:ecommerce_app/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network/remote/dio_helper.dart';
import 'package:intl/intl.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';
import 'shared/bloc_observer.dart';
import 'modules/counter/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getData()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
