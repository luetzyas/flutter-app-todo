import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  
  ToDoTile({
    super.key, 
    required this.taskName, 
    required this.isDone, 
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 170, 37, 34),
              borderRadius: BorderRadius.circular(12),
              ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Checkbox(
                value: isDone, 
                onChanged: onChanged,
                activeColor: Colors.black,
                ),
              Text(
                taskName,
                style: TextStyle(
                  decoration: isDone 
                  ? TextDecoration.lineThrough
                  : TextDecoration.none
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}