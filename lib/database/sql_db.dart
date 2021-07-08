import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:person_cubit/models/person.dart';


const TABLE_NAME = 'Persons';


Future<Database> createTable() async
{
  String path = join( await getDatabasesPath(), 'persons.db');
  return await openDatabase(path, version: 1, onCreate: _onCreate);
}

void _onCreate(Database database,int version) async
{
  await database.execute('CREATE TABLE $TABLE_NAME( id INTEGER PRIMARY KEY , name TEXT NOT NULL , age INTEGER , favorite INTEGER NOT NULL )');
}

Future<void> insertPerson(Person p) async
{
  Database database = await createTable();
  database.insert(TABLE_NAME, { 'name': p.name , 'age': p.age , 'favorite': 0 });
}

Future<List> getAllPersons() async
{
  Database database = await createTable();
  return await database.query( TABLE_NAME );
}

Future<void> updatePersonFav(int id, int favBool) async
{
  Database database = await createTable();
  database.rawUpdate('update $TABLE_NAME set favorite = $favBool where id = $id');
}

Future<void> deletePerson(int id) async
{
  Database database = await createTable();
  database.rawDelete('delete from $TABLE_NAME where id = $id');
}