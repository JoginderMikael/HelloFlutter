import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  
  void getTime() async{
    
    //make the request
    Response response = await get(Uri.parse('https://timeapi.io/api/v1/time/current/zone?timezone=Africa%2FNairobi'));

    Map data = jsonDecode(response.body);
    // print(data);

    //Get properties from data

    String datetime = data['date_time'];
    int offset = data['utc_offset_seconds'];

    // print(datetime);
    //  print(offset);

    //create a date time object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(seconds: offset));
    print(now);
  }

  


@override
  void initState(){
    super.initState();
    getTime();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Loading Screen"),
    );
  }
}