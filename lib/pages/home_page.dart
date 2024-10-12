import 'package:flutter/material.dart';
import 'package:flutter_app_todo/components/dialog_box.dart';
import 'package:flutter_app_todo/components/todo_tile.dart';
import 'package:flutter_app_todo/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _nameState();
}

class _nameState extends State<HomePage> {
  //reference the hive box
  final _box = Hive.box('myBox');
  ToDoDataBase _db = ToDoDataBase();

  @override
  void initState() {
    //1. time opening
    if (_box.get("TODOLIST") == null) {
      _db.createInitialData();
    } else {
      //get data
      _db.loadDB();
    }

    super.initState();
  }

  //text controller
  final _textController = TextEditingController();

  void checkBoxChanged(bool? value, int i) {
    setState(() {
      _db.toDoList[i][1] = !_db.toDoList[i][1];
    });
    _db.updateDB();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      _db.toDoList.add([
        _textController.text,
        false,
      ]);
      _textController.clear();
      Navigator.of(context).pop();
    });
    _db.updateDB();
  }

  void createNewToDo() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _textController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(), //close dialogbox
          );
      }
    );
    _db.updateDB();
  }

  //delete task
  void deleteTask(int i) {
    setState(() {
      _db.toDoList.removeAt(i);
    });
    _db.updateDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewToDo,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _db.toDoList.length,
        itemBuilder: (context, i) {
          return ToDoTile(
            taskName: _db.toDoList[i][0], 
            isDone: _db.toDoList[i][1],  
            onChanged: (value) => checkBoxChanged(value, i),
            deleteTask: (context) => deleteTask(i),
          );
        },
      ),
    );
  }
}