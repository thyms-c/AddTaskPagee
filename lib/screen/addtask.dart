import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
            "Add Task",
            style: TextStyle(fontSize: 19),
            ),
          ),
      body: Container()
    );
  }
}