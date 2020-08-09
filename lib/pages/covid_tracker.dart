

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:location/location.dart';


class CovTracker extends StatefulWidget {
  @override
  _CovTrackerState createState() => _CovTrackerState();
}

class _CovTrackerState extends State<CovTracker> {
  GoogleMapController _controller;
  CollectionReference firestore = Firestore.instance.collection('locations');

  final location = Location();

  Set<Circle> circle = {
    Circle(
        visible: true,
        circleId: CircleId("hell"),
        center: LatLng(37.423123113580664, -122.085749655962))
  };

  LocationData currentData;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _animateToUser();
  }

  _animateToUser() {
    location.getLocation().then((value) {
      var pos = value;
      if (pos != null) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 17.0,
        )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: firestore.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: SizedBox(
                      height: 60,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballPulseSync)));
            } else {
              markers.clear();
              snapshot.data.documents.forEach((DocumentSnapshot document) {
                GeoPoint pos = document.data['position']['geopoint'];
                var marker = Marker(
                  markerId: MarkerId(document.data['number']),
                  position: LatLng(pos.latitude, pos.longitude),
                  icon: BitmapDescriptor.defaultMarker,
                );
                markers.add(marker);
              });
              return GoogleMap(
                circles: circle,
                markers: markers,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
