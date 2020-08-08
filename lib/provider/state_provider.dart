import 'package:flutter/foundation.dart';

class StateProvider with ChangeNotifier {
  String _name = "Gujarat";

  String _code = "10";

  String get getCountry => _name;
  String get getCountryCode => _code;

  void setState(String value) {
    _name = value;
    // notifyListeners();
  }

  void setStateCode(String value) {
    _code = value;
    notifyListeners();
  }
}
