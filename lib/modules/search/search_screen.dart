import 'package:ecommerce_app/layout/news_app/cubit/cubit.dart';
import 'package:ecommerce_app/layout/news_app/cubit/states.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            leading: FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(child: articleBuilder(list,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
