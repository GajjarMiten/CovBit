
import 'package:Monks/widgets/country_opt.dart';
import 'package:Monks/widgets/cuntry_stats.dart';
import 'package:Monks/widgets/my_header.dart';
import 'package:flutter/material.dart';

class WorldStats extends StatefulWidget {
  @override
  _WorldStatsState createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats>
    with AutomaticKeepAliveClientMixin {
  final controller = ScrollController(keepScrollOffset: true);
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: controller,
      child: Column(
        children: <Widget>[
          MyHeader(
            image: "assets/icons/Drcorona.svg",
            textTop: "All you need",
            textBottom: "is stay at home.",
            offset: offset,
          ),
          CountryDropDown(),
          SizedBox(height: 20),
          CountryStats(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
