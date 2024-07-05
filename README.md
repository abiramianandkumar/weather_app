# Flutter Weather App
A simple Flutter application that fetches and displays current weather information for a given city using the OpenWeatherMap API.

### Features

##### Home Screen:

* Search bar to enter city names and fetch weather information.
* Displays loading indicator while fetching data.
* Persists the last searched city using SharedPreferences.
  
#### Weather Details Screen:

* Displays current temperature, weather condition, humidity percentage, and wind speed for the selected city.
* Shows an icon representing the current weather condition.
* Implements a "Refresh" button to fetch updated weather data.

#### Error Handling:

* Properly handles API request errors and displays user-friendly error messages.
#### State Management:

* Uses Provider package for state management to handle fetching weather data and updating UI.
#### Responsive Design:

* Basic responsive design that adapts to different screen sizes and orientations.

### Screenshots

![image](https://github.com/abiramianandkumar/weather_app/assets/132546032/48ce6908-b3d9-4fde-8366-3f923c5dbfa2)  	 ![image](https://github.com/abiramianandkumar/weather_app/assets/132546032/03663214-306f-4c82-b57d-7969537dbba8)


### Dependencies

  
* **flutter/material.dart** : Flutter framework.
* **google_fonts** : For custom fonts.
* **intl** : For date and time formatting.
* **provider** : For state management.
* **shared_preferences** : For local data persistence.
* **weather** : For fetching weather data from OpenWeatherMap API.

## Getting Started
To run the app locally, follow these steps:

1. Clone the repository

2. Install dependencies

3. API Key Setup

* Obtain an API key from [OpenWeatherMap](https://openweathermap.org/).
* Replace const api = 'YOUR_API_KEY'; in lib/consts.dart with your API key.

4. Run the app

* Connect your device/emulator and run the app using Flutter.

5. Usage

* On the home screen, enter a city name in the search bar and tap the arrow button to view weather details.
* The weather details screen displays current weather information for the selected city.
* Use the "Refresh" button to update weather data.
* The app persists the last searched city for convenience.

  
