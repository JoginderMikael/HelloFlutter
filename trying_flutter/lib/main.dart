import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home()
));


class Home extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('My App'),
      centerTitle: true,
      backgroundColor: Colors.blue,
    ),
    body: Center(
      child: TextButton(
        onPressed: () {
          // Add your onPressed code here!
          print('Button pressed!');
        },
        child: Text('Click Me'),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    ),
     
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: Text('Click'),
      backgroundColor: Colors.blue,
    ),
  );
  }
}