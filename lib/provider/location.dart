import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  LocationProvider.init() {
    getPremission();
  }

  LocationData get getLocation => _locationData;
  PermissionStatus get status => _permissionGranted;
  Location get instance => location;

  void getPremission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        await location.getLocation().then((value) => _locationData = value);
        return;
      }
    }
  }

  Future<LocationData> fetchCurrentLocation() async {
    await location.getLocation().catchError((w) {
      print(w);
    }).then((value) {
      _locationData = value;
      return value;
    });
    return _locationData;
  }
}
