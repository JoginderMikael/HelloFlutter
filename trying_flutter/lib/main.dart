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
      child: ElevatedButton.icon(
        onPressed: () {
          // Add your onPressed code here!
        },
        icon: Icon(Icons.mail),
        label: Text('Click Me'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
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