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
      child: Image(
        image: AssetImage('assets/night3.jpg'),
      ),
     
     // child: Text(
      //   'Hello Joginder!',
      //   style: TextStyle(
      //     fontSize: 24.0,
      //     fontWeight: FontWeight.bold,
      //     letterSpacing: 2.0,
      //     color: Colors.grey[600],
      //     fontFamily: 'IndieFlower',
      //     ),

      ),
    // ),
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