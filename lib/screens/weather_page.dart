// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather_app/model/screen_model.dart';
import 'package:weather_app/services/ui_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class WeatherPage extends StatefulWidget {
  final String title;
  const WeatherPage({super.key, required this.title});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherServices _weatherServices = WeatherServices();

  final TextEditingController _cityname = TextEditingController();

  // created instance of weather class and make initial loading false.
  bool _isLoading = false;
  Weather? _weather;

  // -----------------------------------  ----------------------------------- -----------------------------------
  // For debugging
  // Future<void> _getWeather() async {
  //   final city = _cityname.text.trim();
  //   if (city.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Please enter a city name')));
  //     return;
  //   }

  //   setState(() => _isLoading = true);

  //   try {
  //     print("🔹 Fetching weather for city: $city");
  //     final weather = await _weatherServices.fetchWeather(city);
  //     print("✅ Weather fetched: ${weather.cityname}");
  //     setState(() {
  //       _weather = weather;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print("❌ ERROR: $e");
  //     setState(() => _isLoading = false);
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Error fetching weather: $e')));
  //   }
  // }
  //  ----------------------------------- ----------------------------------- -----------------------------------

  void _getWeather() async {
    String newVar;

    newVar = _cityname.text;

    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherServices.fetchWeather(newVar);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: const Color.fromARGB(239, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
        backgroundColor: Color.fromRGBO(96, 125, 139, 1),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              (_weather != null) &&
                  (_weather!.text_desc.toLowerCase().contains('cloudy'))
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : (_weather != null) &&
                    (_weather!.text_desc.toLowerCase().contains('sunny'))
              ? const LinearGradient(
                  colors: [Colors.orange, Colors.blueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [Colors.grey, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 25),

                Text(
                  "Check Weather !!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: const Color.fromARGB(146, 128, 64, 255),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _cityname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter City Name",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(98, 255, 255, 255),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // print(_cityname.text);
                      _getWeather();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(161, 68, 137, 255),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: Text(
                      "Fetch",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                if (_isLoading)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),

                // widget.CustomCard,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
