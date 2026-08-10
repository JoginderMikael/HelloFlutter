import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  void getData() async{
    //simulate network request for username
  String name = await Future.delayed(Duration(seconds: 3), (){
      return 'Joginder';
    });

  String bio = await Future.delayed(Duration(seconds: 2), (){
      return 'He is a good Man';
    });


    print('$name - $bio');
  }
  // int counter = 0;

  


@override
  void initState(){
    super.initState();
    // print('initState function ran');
    getData();
    print('Hey there');
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