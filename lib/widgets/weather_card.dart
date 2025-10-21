import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/screen_model.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(96, 255, 255, 255),
          ),
          child: Column(
            children: [
              Lottie.asset(
                weather.isday.toString().contains('0')
                    ? 'assets/Weather-night.json'
                    : weather.isday.toString().contains('1')
                    ? 'assets/sunny.json'
                    : 'assets/Weather-storm.json',

                height: 150,
                width: 150,
              ),

              Text(
                weather.cityname,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              SizedBox(height: 10),

              Text(
                "${weather.temp.toStringAsFixed(1)}°C",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                weather.text_desc,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Humidity ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Wind ${weather.windspeed}m/s',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Current Time: \n${formatTime(weather.newtime)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Last Updated Time: \n${formatTime(weather.lasttime)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              // Optional for sunrise and sunset
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Icon(Icons.wb_sunny_outlined, color: Colors.orange),

              //     Text(
              //       'Sunrise ${weather.humidity}%',
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     Text(
              //       'Wind ${weather.windspeed}m/s',
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //   ],
              // ),

              // SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
