import 'package:flutter/material.dart';
import 'package:flutter_app_todo/components/dialog_box.dart';
import 'package:flutter_app_todo/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _nameState();
}

class _nameState extends State<HomePage> {
  //text controller
  final _textController = TextEditingController();

  List toDoList = [
    //[0,1]
    ["Make Tutorial", false],
    ["Finish App", false],
  ];

  void checkBoxChanged(bool? value, int i) {
    setState(() {
      toDoList[i][1] = !toDoList[i][1];
    });
  }

  //save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([
        _textController.text,
        false,
      ]);
      _textController.clear();
      Navigator.of(context).pop();
    });
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
  }

  //delete task
  void deleteTask(int i) {
    setState(() {
      toDoList.removeAt(i);
    });
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
        itemCount: toDoList.length,
        itemBuilder: (context, i) {
          return ToDoTile(
            taskName: toDoList[i][0], 
            isDone: toDoList[i][1],  
            onChanged: (value) => checkBoxChanged(value, i),
            deleteTask: (context) => deleteTask(i),
          );
        },
      ),
    );
  }
}