import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_cubit/bloc/cubit.dart';
import 'package:person_cubit/bloc/cubit_states.dart';
import 'package:person_cubit/database/sql_db.dart' as db;


class ScreenList extends StatelessWidget {
  final List list;
  ScreenList(this.list);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index)=> Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onLongPress: (){ deleteDialog( list[index]['id'], context, AppCubit.get(context).deletePersonFromDB  ); },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.black,width: 2)
                  ),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Name : ${list[index]['name']}',style: TextStyle(color: Colors.black,fontSize: 22),),
                                SizedBox(height: 10,),
                                Text('Age : ${list[index]['age']}',style: TextStyle(color: Colors.black,fontSize: 22),),
                                SizedBox(height: 10,),
                                Text('Favorite : ${list[index]['favorite']== 1 ? 'Yes' : 'NO'}',style: TextStyle(color: Colors.black,fontSize: 22),),
                              ],
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.favorite,color:  list[index]['favorite']== 0 ? Colors.grey:Colors.red),
                              onPressed:()async
                              {
                                await list[index]['favorite']== 0 ?
                                await AppCubit.get(context).addToFavorites(list[index]['id'])
                                    : await AppCubit.get(context).removeFromFavorites(list[index]['id']);
                                print(await db.getAllPersons());
                              }
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ),
            itemCount: list.length,
          ),
        );
      },

    );
  }
}


void deleteDialog(int id,BuildContext context, Function function) async{
  return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context){
        return AlertDialog(
          title: Text('Delete Person'),
          content: Text('Are you sure you want to delete that Person permanently?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await function(id);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: (){ Navigator.of(context).pop(); },
            ),
          ],
        );
      }
  );
}