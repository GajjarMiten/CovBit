import 'package:flutter/foundation.dart';

class CountryProvider with ChangeNotifier {
  String _name = "India";

  String _code = "IN";

  String get getCountry => _name;
  String get getCountryCode => _code;

  void setCountry(String value) {
    _name = value;
    // notifyListeners();
  }

  void setCountryCode(String value) {
    _code = value;
    notifyListeners();
  }
}
