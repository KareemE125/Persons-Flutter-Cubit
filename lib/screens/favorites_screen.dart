import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_arabic_course/bloc/cubit.dart';
import 'package:udemy_arabic_course/bloc/cubit_states.dart';
import 'package:udemy_arabic_course/components/screen_list.dart';


class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
       listener:(context,state){},
       builder: (context,state){
        return Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Padding(padding: EdgeInsets.only(top: 20,bottom: 10),child: Text('Favorites',style: TextStyle(fontSize: 30),),),
             ScreenList(AppCubit.get(context).favoritePersonsList),
           ],
         );
       }
     );
  }

}
