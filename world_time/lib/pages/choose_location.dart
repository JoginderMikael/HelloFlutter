import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  void getData() async{
    //simulate network request for username
    await Future.delayed(Duration(seconds: 3), (){
      print('Joginder');
    });

    await Future.delayed(Duration(seconds: 2), (){
      print('This is jog');
    });


    print('Statement');
  }
  // int counter = 0;

  


@override
  void initState(){
    super.initState();
    // print('initState function ran');
    getData();
}

  @override
  Widget build(BuildContext context) {
    print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Choose Location', 
          style: TextStyle(color: Colors.white),
          ),
        centerTitle: true,
        elevation: 0,
      ),
      // body: ElevatedButton(
      //   onPressed: (){
      //     setState(() {
      //       counter++;
      //     });
      //   }, 
      //   child: Text('counter is $counter'),
      //   )
    );
  }
}