import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_arabic_course/bloc/cubit_states.dart';
import 'package:udemy_arabic_course/models/person.dart';
import 'package:udemy_arabic_course/screens/home_screen.dart';
import 'package:udemy_arabic_course/screens/favorites_screen.dart';
import 'package:udemy_arabic_course/screens/persons_screen.dart';
import 'package:udemy_arabic_course/database/sql_db.dart' as db;

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(InitialState());

  /// to use the CounterBloc attributes and methods by one object
  static AppCubit get(context) => BlocProvider.of(context);

  List<Map<String,Object>> _screens =
  [
    { 'screen': HomeScreen(), 'title': 'Home', 'index': 0, },
    { 'screen': PersonsScreen(),     'title': 'Persons',    'index': 1, },
    { 'screen': FavoritesScreen(),     'title': 'Favorites',      'index': 2, },
  ];

  List<Map<String,Object>> personsList = [];
  List<Map<String,Object>> favoritePersonsList = [];

  Widget _currentScreen = HomeScreen();
  String _currentTitle = 'Home';
  int _currentIndex = 0;


  Widget get currentScreen => _currentScreen;
  String get currentTitle => _currentTitle;
  int get currentIndex => _currentIndex;

  void changeScreen(int value){
    _currentScreen = _screens[value]['screen'];
    _currentTitle = _screens[value]['title'];
    _currentIndex = _screens[value]['index'];
    emit(ChangeScreenState());
  }

  Future<void> insertPersonToDB(Person p) async
  {
    await db.insertPerson(p);
    emit(InsertToDBState());

    getAllPersonsFromDB();
  }

  Future<void> deletePersonFromDB(int id) async
  {
    await db.deletePerson(id);
    emit(DeleteFromDBState());

    getAllPersonsFromDB();
  }

  Future<void> getAllPersonsFromDB() async
  {
    await db.getAllPersons().then( (value)=> personsList = value );
    favoritePersonsList = personsList.where((element) => element['favorite'] == 1 ).toList();
    emit(GetAllFromDBState());
  }

  Future<void> addToFavorites(int id) async
  {
    await db.updatePersonFav(id,1).then((value)
    {
      getAllPersonsFromDB();
    });
    emit(ChangeFavPersonsListState());
  }

  Future<void> removeFromFavorites(int id) async
  {
    await db.updatePersonFav(id,0).then((value)
    {
      getAllPersonsFromDB();
    });

    emit(ChangeFavPersonsListState());
  }


}

