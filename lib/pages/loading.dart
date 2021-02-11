import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  icon: Icon(Icons.navigate_next),
                  label: Text('next'),
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
