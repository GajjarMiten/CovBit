import 'package:Monks/provider/navigation.dart';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class MyNavBar extends StatefulWidget {
  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<NavbarData>(context);
    return FloatingNavbar(
      backgroundColor: Color(0xFF3383CD),
      selectedBackgroundColor: Colors.white,
      selectedItemColor: Color(0xFF3383CD),
      unselectedItemColor: Colors.white,
      items: [
        FloatingNavbarItem(icon: Icons.score, title: 'World'),
        FloatingNavbarItem(
            icon: FlutterIcons.newspaper_variant_multiple_outline_mco,
            title: 'Local'),
        FloatingNavbarItem(icon: FlutterIcons.Safety_ant, title: 'Safer'),
        FloatingNavbarItem(icon: FlutterIcons.API_ant, title: 'CovBot'),
        FloatingNavbarItem(
            icon: FlutterIcons.map_marker_path_mco, title: 'Tracker'),
      ],
      currentIndex: data.getCurrentIndex,
      onTap: (index) {
        data.setCurrentIndex(index);
      },
    );
  }
}
