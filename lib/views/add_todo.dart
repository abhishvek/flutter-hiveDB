import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivetodoapp/adapters/todo_adapter.dart';

class AddTodo extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String title, description;

  submitData() async {
    if (widget.formkey.currentState.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      todoBox.add(Todo(title: title, description: description));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add todo", style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Form(
          key: widget.formkey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Add title'),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Add description'),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              ElevatedButton(onPressed: submitData, child: Text('Submit Data'))
            ],
          )),
    );
  }
}
