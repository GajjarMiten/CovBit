import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Monks/provider/navigation.dart';

import 'pages/world_stats.dart';
import 'screens/qna.dart';
import 'widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              QNA(),
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
