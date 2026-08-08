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
    body: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Hello Joginder!'),
        TextButton(
          onPressed: () {},
          child: Text('Click'),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.cyanAccent,
          child: Text('Inside Container'),
        ),
      ],
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