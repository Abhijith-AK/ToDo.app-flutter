import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List listitems = [];

  //refernce the box

  final _mybox = Hive.box("MyBox");

  //run the method first open the app after installation

  void initializeDatabase() {
    listitems = [
      ['Learn Flutter', false],
      ["Drink caffee", false],
    ];
  }

  //load data from DataBase

  void loadData() {
    listitems = _mybox.get("TODOLIST");
  }

  //delete data from DataBase

  void updateData() {
    _mybox.put("TODOLIST", listitems);
  }
}
