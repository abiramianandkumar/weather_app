// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/pages/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _lastSearchedCity;

  @override
  void initState() {
    super.initState();
    // Calls _loadLastSearchedCity to load the last searched city from shared preferences
    _loadLastSearchedCity();
  }

  // Retrieves the city using getString
  void _loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSearchedCity = prefs.getString('lastSearchedCity');
    if (lastSearchedCity != null) {
      setState(() {
        _lastSearchedCity = lastSearchedCity;
      });
    }
  }

  // Saving the string
  void _saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }

  // If the user enters the city name, it will navigate to the weather page to display the weather details
  void _navigateToWeatherPage(String city) {
    _saveLastSearchedCity(city);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherPage(cityname: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffAED6F1),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Text('Weather App', style: GoogleFonts.poppins(fontSize: 20)),
            SizedBox(height: 100),
            Center(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          // Storing the city name and passing it as parameter to the next page
                          String city = _searchController.text;
                          if (city.isNotEmpty) {
                            _navigateToWeatherPage(city);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_lastSearchedCity != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                // Wrapped in a GestureDetector to navigate to the WeatherPage with the last searched city when tapped
                child: GestureDetector(
                  onTap: () {
                    _navigateToWeatherPage(_lastSearchedCity!);
                  },
                  // Displaying last searched city
                  child: Text(
                    'Last searched city: $_lastSearchedCity',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 59, 59, 59),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
