import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setupWorldTime() async {
    final WorldTime instance = WorldTime(
      location: 'Detecting location',
      flag: 'day.png',
      url: 'Africa/Nairobi',
    );

    await instance.getTimeFromIp();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.formattedTime,
        'date': instance.date,
        'dayOfWeek': instance.dayOfWeek,
        'timezone': instance.timezone,
        'dateTime': instance.dateTime,
        'isDaytime': instance.isDaytime,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 117, 210),
      body: Center(
        child: SpinKitCircle(color: Colors.white, size: 80.0),
      ),
    );
  }
}
