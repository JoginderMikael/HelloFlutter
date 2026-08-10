import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String? time;
  String flag;
  String url;
  bool? isDaytime;
  String? date;
  String? dayOfWeek;
  String? timezone;
  DateTime? dateTime;
  bool use24Hour;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
    this.use24Hour = true,
  });

  Future<void> getTime() async {
    await _getTimeFromZone(url);
  }

  Future<void> getTimeFromIp() async {
    try {
      final ipResponse = await get(Uri.parse('https://api.ipify.org?format=json'));
      if (ipResponse.statusCode == 200) {
        final ipData = jsonDecode(ipResponse.body) as Map<String, dynamic>;
        final ipAddress = ipData['ip'] as String?;

        if (ipAddress != null && ipAddress.isNotEmpty) {
          await _getTimeFromIp(ipAddress);
          return;
        }
      }
    } catch (_) {}

    await _getTimeFromZone(url);
  }

  Future<void> _getTimeFromIp(String ipAddress) async {
    try {
      final response = await get(
        Uri.parse('https://timeapi.io/api/v1/time/current/ip?ipAddress=$ipAddress'),
      );

      if (response.statusCode != 200) {
        throw Exception('Unable to fetch IP-based time');
      }

      _parseResponse(jsonDecode(response.body));
    } catch (_) {
      time = 'Could not get time data';
      date = '';
      dayOfWeek = '';
      timezone = 'Unknown';
      dateTime = DateTime.now();
      isDaytime = true;
    }
  }

  Future<void> _getTimeFromZone(String timezoneValue) async {
    try {
      final response = await get(
        Uri.parse('https://timeapi.io/api/v1/time/current/zone?timezone=$timezoneValue'),
      );

      if (response.statusCode != 200) {
        throw Exception('Unable to fetch timezone time');
      }

      _parseResponse(jsonDecode(response.body));
    } catch (_) {
      time = 'Could not get time data';
      date = '';
      dayOfWeek = '';
      timezone = timezoneValue;
      dateTime = DateTime.now();
      isDaytime = true;
    }
  }

  void _parseResponse(Map<String, dynamic> data) {
    final String datetime = data['date_time'] as String;
    final int offset = data['utc_offset_seconds'] as int? ?? 0;

    final DateTime now = DateTime.parse(datetime).add(Duration(seconds: offset));

    dateTime = now;
    date = DateFormat('EEE, MMM d, yyyy').format(now);
    dayOfWeek = DateFormat('EEEE').format(now);
    timezone = data['timezone'] as String? ?? url;
    location = timezone!;
    isDaytime = now.hour >= 6 && now.hour < 18;
    time = DateFormat.Hm().format(now);
  }

  String get formattedTime {
    if (dateTime == null) {
      return time ?? '--:--';
    }

    return use24Hour
        ? DateFormat.Hm().format(dateTime!)
        : DateFormat.jm().format(dateTime!);
  }
}
