import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_cubit/bloc/cubit.dart';
import 'package:person_cubit/bloc/cubit_states.dart';
import 'package:person_cubit/models/person.dart';


class HomeScreen extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    child: Column(
                      children: [
                        Text('Add Persons',style: TextStyle(fontSize: 30),),
                        SizedBox(height: 30,),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(width: 2,color: Colors.blueAccent)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color: Colors.lightBlueAccent)
                            ),
                            labelText: 'Name'
                          ),
                          controller: nameController,
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color: Colors.blueAccent)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2,color: Colors.lightBlueAccent)
                              ),
                              labelText: 'Age'
                          ),
                          controller: ageController,
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () async{
                            await AppCubit.get(context).insertPersonToDB(Person(
                                name: '${nameController.text}',
                                age: int.parse(ageController.text)
                             )
                            ).then((value)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Added')));
                              nameController.text = '';
                              ageController.text = '';
                            });
                          },
                          child: Text('ADD')
                        ),
                      ],
                    )
                ),
              ),
            ],
          );
        }
    );
  }
}
