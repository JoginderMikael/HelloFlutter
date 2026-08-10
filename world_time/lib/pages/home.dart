import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State <Home> createState() =>  HomeState();
}

class  HomeState extends State <Home> {

Map data = {};

  @override
  Widget build(BuildContext context) {

    data = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    print(data);

    //set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('/$bgImage'),
              fit:BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, '/location');
                  }, 
                  icon: Icon(Icons.edit_location),
                  label: Text('Edit Location'),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                    ),
                  )
              ],
            ),
          ),
        )
        ),
    );
  }
}