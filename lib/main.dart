import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
        ),
        backgroundColor: Colors.amber,
      ),
      body: isEmpty ? ListEmptyWidget() : TaskList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber,
          child: Icon(Icons.add)),
    );
  }
}

class ListEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.assignment_turned_in,
                size: 50.0,
                color: Colors.lightGreen,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Good Job!',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Your list is empty.',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task(name: 'task 1'),
    Task(name: 'task 2', dueDate: DateTime.now()),
    Task(name: 'task 3'),
    Task(name: 'task 4', dueDate: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tasks.map((task) {
        return ListTile(
            title: Text(
              '${task.name}',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            subtitle: task.dueDate != null
                ? Text(
                    '${DateFormat('yyyy-MM-dd kk:mm').format(task.dueDate.toLocal())}')
                : null,
            leading: IconButton(
              icon: Icon(
                task.finished
                    ? Icons.check_circle_outline
                    : Icons.radio_button_unchecked_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  task.finished = !task.finished;
                });
              },
            ));
      }).toList(),
    );
  }
}
