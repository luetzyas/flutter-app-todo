import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  //reference hive box
  final _myBox = Hive.box('myBox');

  List toDoList = [];

  // run method when 1. use
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Finish ToDo App", false],
    ];
  }

  //load database
  void loadDB() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update database
  void updateDB() {
    _myBox.put("TODOLIST", toDoList);
  }

}