import 'package:flutter/material.dart';
import 'package:flutter_app_todo/components/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content: Container (
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task",
              ),
            ),
            //buttons: save & cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              //save
              MyButton(text: "Save", onPressed: onSave),
              //gap between buttons
              const SizedBox(width: 10),
              //cancel
              MyButton(text: "Cancel", onPressed: onCancel),
            ],)
          ],
        ),
      )
    );
  }
}