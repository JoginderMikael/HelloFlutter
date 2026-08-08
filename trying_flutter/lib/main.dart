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
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Hello Joginder"),
            Text("Hello Second!"),
          ],
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.purpleAccent,
          child: Text('One'),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.cyanAccent,
          child: Text('Two'),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.amber,
          child: Text('Three'),
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