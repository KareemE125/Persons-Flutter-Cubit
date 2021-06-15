import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_arabic_course/bloc/cubit.dart';
import 'package:udemy_arabic_course/bloc/cubit_states.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> AppCubit()..getAllPersonsFromDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state){},
        builder: (BuildContext context, AppStates state){
          /// to avoid writing "AppCubit.get(context)." many times
          final AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.currentTitle),
              centerTitle: true,
            ),
            body:  cubit.currentScreen,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              showUnselectedLabels: false ,
              showSelectedLabels: false,
              selectedIconTheme: IconThemeData(size: 32),
              unselectedIconTheme: IconThemeData(size: 28),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home' ,),
                BottomNavigationBarItem(icon: Icon(Icons.person),label:'Person' ,),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label:'head' ,),
              ],
              onTap: cubit.changeScreen,
            ),
          );
        },
      ),
    );
  }
}
