String apikey = '9d54e695bf4b4803aee230828231202';
String weatherIcon = 'heavycloudy.png';

class ModelWeather {
  String searchWeatherAPI =
      "https://api.weatherapi.com/v1/forecast.json?key=$apikey&days=7&q=";
  String location = 'Angers';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';
  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  String currentWeatherStatus = '';
}
