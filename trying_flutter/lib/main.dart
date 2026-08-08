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
      children: <Widget>[
        Expanded(
          child: Image.asset("assets/night2.jpg"),
          flex: 3,
        ),
        Expanded(
          flex: 3,
          child:Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.cyan,
            child: Text("1")
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.pink,
            child: Text("2")
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.amber,
            child: Text("3")
          ),
        )
      ],
    ),
     
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
        print('You clicked me!');
      },
      
      backgroundColor: Colors.blue,
      child: Text('Click'),
    ),
  );
  }
}