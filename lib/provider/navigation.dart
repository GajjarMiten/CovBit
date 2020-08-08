import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NavbarData with ChangeNotifier {
  final controller = PageController(initialPage: 0);

  int _currentIndex = 0;

  int get getCurrentIndex => _currentIndex;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    controller.animateToPage(value,
        duration: Duration(milliseconds: 700), curve: Curves.linear);
    notifyListeners();
  }

  void setCurrentIndexByPage(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
