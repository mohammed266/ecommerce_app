import 'package:ecommerce_app/modules/counter/cubit/states.dart';

import 'cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context,state){
          if(state is CounterMinusStates){
            // print('that is minus state ${state.counter}');
          }
          if(state is CounterPlusStates){
            // print('that is plus state ${state.counter}');
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Container(
                        color: Colors.red,
                        height: 50,
                        child: Icon(Icons.remove),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: Center(
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Container(
                        color: Colors.red,
                        height: 50,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

