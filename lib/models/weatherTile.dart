import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class WeatherTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  WeatherTile({required this.icon ,required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context)=>ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: Colors.blueAccent),
          ],
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff9e9e9e)),
        ));
  
}
