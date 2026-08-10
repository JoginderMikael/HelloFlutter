import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; //location name for the UI
  String? time; //time in the location
  String flag; //URL to an asset flag icon
  String url; //location url for api endpoint

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response = await get(
        Uri.parse('https://timeapi.io/api/v1/time/current/zone?timezone=$url'),
      );

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

      //set the time property
      time = now.toString();
    } catch (e) {
      print('Caught error $e');
      time = 'Could not get time data';
    }
  }
}
