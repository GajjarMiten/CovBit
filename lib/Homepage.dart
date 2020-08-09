import 'dart:async';

import 'package:Monks/pages/locale_stats.dart';
import 'package:Monks/provider/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:Monks/provider/navigation.dart';

import 'pages/covid_tracker.dart';
import 'pages/world_stats.dart';
import 'screens/enter_blue_address.dart';
import 'screens/qna.dart';
import 'widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  Location location = Location();

  void _addGeoPoint() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    var pos = await location.getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);

    return firestore
        .collection('locations')
        .document(auth.user.uid)
        .setData({'position': point.data, 'number': auth.user.phoneNumber});
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      _addGeoPoint();
    });
  }

  @override
  Widget build(BuildContext context) {
    final navData = Provider.of<NavbarData>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) => navData.setCurrentIndexByPage(value),
            controller: navData.controller,
            children: <Widget>[
              WorldStats(),
              LocalStats(),
              BluetoothAddress(),
              QNA(),
              CovTracker(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MyNavBar(),
          ),
        ],
      ),
    );
  }
}
