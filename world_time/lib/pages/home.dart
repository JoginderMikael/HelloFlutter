import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Map<String, dynamic> data = {};
  bool use24Hour = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (data.isEmpty) {
      data = (ModalRoute.of(context)?.settings.arguments as Map?)?.cast<String, dynamic>() ?? {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final String bgImage = data['isDaytime'] == true ? 'day.png' : 'night.png';
    final Color bgColor = data['isDaytime'] == true ? Colors.blue : Colors.indigo.shade700;

    final DateTime? dateTime = data['dateTime'] as DateTime?;
    final String timeText = dateTime != null
        ? (use24Hour ? DateFormat.Hm().format(dateTime) : DateFormat.jm().format(dateTime))
        : (data['time'] ?? '--:--');
    final String dateText = data['date'] ?? '';
    final String dayText = data['dayOfWeek'] ?? '';
    final String timezone = data['timezone'] ?? '';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      use24Hour ? '24-hour time' : '12-hour time',
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: use24Hour,
                    onChanged: (value) {
                      setState(() {
                        use24Hour = value;
                      });
                    },
                    activeThumbColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white38,
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    final dynamic result = await Navigator.pushNamed(context, '/location');

                    if (result is Map && mounted) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'date': result['date'],
                          'dayOfWeek': result['dayOfWeek'],
                          'timezone': result['timezone'],
                          'dateTime': result['dateTime'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag'],
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey.shade300,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  data['location'] ?? 'Current location',
                  style: const TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                if (timezone.isNotEmpty)
                  Text(
                    timezone,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  timeText,
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  dateText,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dayText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
