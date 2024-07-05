// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/pages/weather_provider.dart';

class WeatherPage extends StatefulWidget {
  final String cityname;
  WeatherPage({super.key, required this.cityname});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();

    // It will fetch weather after the initial frame build and fetches weather
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(widget.cityname);
    });
  }

  // It will refresh the weather
  void _refreshWeather() {
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeather(widget.cityname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffAED6F1),
      appBar: AppBar(
        title: Text('Weather', style: GoogleFonts.poppins(),),
        backgroundColor: Color(0xffAED6F1),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshWeather,
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          // If weather is loading it will show loading symbol that is CircularProgressIndicator
          if (weatherProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // If weather is null it will show error
          if (weatherProvider.weather == null) {
            return Center(
              child: Text('Error fetching weather'),
            );
          }
          // Or else it will display the weather
          return ui(weatherProvider.weather!);
        },
      ),
    );
  }

  Widget ui(Weather weather) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // To display the city name
            _locationHeader(weather),
            SizedBox(height: 30),

            // To display date and time
            _datetime(weather),
            SizedBox(height: 30),
            
            // To display weather icon and description
            _weatherIcon(weather),
            SizedBox(height: 30),
            Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // To display Temperature
                      children: [Temp(weather)],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // To display Humidity
                      children: [humidity(weather)],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // To display Wind Speed
                      children: [wind(weather)],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // City name
  Widget _locationHeader(Weather weather) {
    return Text(
      weather.areaName ?? '',
      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Date and time
  Widget _datetime(Weather weather) {
    DateTime now = weather.date!.toLocal();
    return Column(
      children: [
        Text(DateFormat('h:mm a').format(now),
            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('E, MMM d').format(now),
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
            SizedBox(height: 30),
          ],
        ),
      ],
    );
  }

  // Weather icon and description
  Widget _weatherIcon(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://openweathermap.org/img/wn/${weather.weatherIcon}@4x.png'),
            ),
          ),
        ),
        Text(weather.weatherDescription ?? '', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
      ],
    );
  }

  // Temperature
  Widget Temp(Weather weather) {
    return Container(
      child: Text(
        'Temperature: ${weather.temperature?.celsius?.toStringAsFixed(1)} °C',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    );
  }

  // Humidity
  Widget humidity(Weather weather) {
    return Container(
      child: Text(
        'Humidity: ${weather.humidity?.toStringAsFixed(1)} %',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    );
  }

  // Wind speed
  Widget wind(Weather weather) {
    return Container(
      child: Text(
        'Wind Speed: ${weather.windSpeed?.toStringAsFixed(1)} km/hr',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    );
  }
}
