import 'package:flutter/material.dart';
import 'package:flutter_todoapp/database/task.dart';
import 'package:flutter_todoapp/pages/home.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AddPageArgument args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Task',
                    ),
                    controller: taskNameController,
                    autofocus: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: 'Due date'),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton.icon(
                      onPressed: () {
                        TaskDB.addTodo(Task(name: taskNameController.text));
                        args.channel.send(0);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.send),
                      label: Text('Save'),
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
