import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepositoryCities {
  Future<void> setSelectedCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCity', cityName);
  }

  Future<String> getSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedCity = prefs.getString('selectedCity') ?? '';
    return selectedCity;
  }
}
