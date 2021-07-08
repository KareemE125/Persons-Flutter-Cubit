import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_cubit/bloc/cubit.dart';
import 'package:person_cubit/bloc/cubit_states.dart';
import 'package:person_cubit/components/screen_list.dart';


class PersonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates states) {},
      builder: (BuildContext context, AppStates states) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text('Persons', style: TextStyle(fontSize: 30),),
              ),
              AppCubit.get(context).personsList.length != 0 ?
              ScreenList(AppCubit.get(context).personsList)
               : Center(child: CircularProgressIndicator(),)
            ]
        );
      },
    );
  }
}
