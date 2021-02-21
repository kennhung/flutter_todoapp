import 'package:channel/channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/database/task.dart';

class AddPageArgument {
  Channel<int> channel;

  AddPageArgument({this.channel});
}

class Home extends StatelessWidget {
  final channel = Channel<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
        ),
        backgroundColor: Colors.amber,
      ),
      body: TaskList(
        channel: channel,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/add',
              arguments: AddPageArgument(channel: channel),
            );
          },
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
  final Channel<int> channel;

  TaskList({this.channel});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  void getTodoList() async {
    final list = await TaskDB.getTasks();
    setState(() {
      tasks = list;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    widget.channel.asStream().listen((event) {
      getTodoList();
    });

    return tasks.length > 0
        ? ListView(
            children: tasks.map((task) {
              return TaskListTitle(
                task: task,
                onToggleFinish: () {
                  Task t = task;
                  t.finished = !t.finished;
                  TaskDB.updateTodo(t);
                  getTodoList();
                },
                onDelete: () {
                  TaskDB.deleteTodo(task.id);
                  getTodoList();
                },
              );
            }).toList(),
          )
        : ListEmptyWidget();
  }
}
