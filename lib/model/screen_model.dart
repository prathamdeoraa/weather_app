// ignore_for_file: non_constant_identifier_names

class Weather {
  // final String location;
  final String cityname;
  final String region;
  final String country;

  // final String current; //temp
  // final String condition; //temp
  final num temp;
  final String text_desc; //text of conditon like cloudy or rainy //description

  final num windspeed;

  final String icon;
  final int humidity;

  final int isday; // 0 or 1 bool
  final int newtime; //time
  final int lasttime; //time

  Weather({
    // required this.location,
    required this.cityname,
    required this.region,
    required this.country,
    // required this.condition,
    // required this.current,
    required this.temp,
    required this.text_desc,
    required this.windspeed,
    required this.icon,
    required this.isday,
    required this.humidity,
    required this.newtime,
    required this.lasttime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityname: json['location']['name'] ?? '',
      region: json['location']['region'] ?? '',
      country: json['location']['country'] ?? '',
      temp: (json['current']['temp_c'] ?? 0).toDouble(),
      isday: json['current']['is_day'] ?? 0,
      text_desc: json['current']['condition']['text'] ?? '',
      icon: json['current']['condition']['icon'] ?? '',
      windspeed: (json['current']['wind_mph'] ?? 0).toDouble(),
      humidity: json['current']['humidity'] ?? 0,
      newtime: json['location']['localtime_epoch'] ?? 0,
      lasttime: json['current']['last_updated_epoch'] ?? 0,
    );
  }

  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(
  //     // location: json['location'],
  //     text_desc: json['current']['condition']['text'],
  //     icon: json['current']['condition']['icon'],
  //     windspeed: json['current']['wind_mph'],
  //     humidity: json['current']['humidity'],

  //     cityname: json['location']['name'],
  //     region: json['location']['region'],
  //     country: json['location']['country'],
  //     // current: json['current'],
  //     temp: json['current']['temp_c'],
  //     isday: json['current']['is_day'],

  //     // condition: json['condition'],
  //     newtime: json['location']['localtime_epoch'],
  //     lasttime: json['location']['last_updated_epoch'],
  //   );
  // }
}
