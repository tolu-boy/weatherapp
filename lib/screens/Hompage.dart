import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:weatherapp/models/weatherTile.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;

  Future getWeather() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=lagos&units=imperial&appid=534f70a1d48b99f9d36fd105642b36ef');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var results = jsonDecode(response.body);
      setState(() {
        this.temp = results['main']['temp'];
        this.description = results['weather'][0]['description'];
        this.currently = results['weather'][0]['main'];
        this.humidity = results['main']['humidity'];
        this.windspeed = results['wind']['speed'];
      });
    } else {
      throw Exception('Error loading request Url info');
    }
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Currently in lagos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' : 'loading',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : 'loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                WeatherTile(
                  icon: FontAwesomeIcons.thermometer,
                  title: 'Temparature',
                  subtitle:
                      temp != null ? temp.toString() + '\u00B0' : 'loading',
                ),
                WeatherTile(
                    icon: FontAwesomeIcons.cloudRain,
                    title: 'Weather',
                    subtitle: description != null
                        ? description.toString()
                        : 'loading'),
                WeatherTile(
                  icon: FontAwesomeIcons.cloudSun,
                  title: 'Humidity',
                  subtitle: humidity != null ? humidity.toString() : 'loading',
                ),
                WeatherTile(
                  icon: FontAwesomeIcons.wind,
                  title: 'Wind Speed',
                  subtitle:
                      windspeed != null ? windspeed.toString() : 'loading',
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
