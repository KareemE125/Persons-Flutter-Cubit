import 'package:udemy_arabic_course/database/sql_db.dart' as db;

abstract class AppStates{}

/// Our States ///
class InitialState extends AppStates {
  InitialState()
  {
    db.createTable();
  }
}

class ChangeScreenState extends AppStates{}

class InsertToDBState extends AppStates{}

class DeleteFromDBState extends AppStates{}

class GetAllFromDBState extends AppStates{}

class ChangePersonsListState extends AppStates{}

class ChangeFavPersonsListState extends AppStates{}