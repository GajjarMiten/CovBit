
import 'package:Monks/widgets/my_header.dart';
import 'package:Monks/widgets/state_opt.dart';
import 'package:Monks/widgets/state_stats.dart';
import 'package:flutter/material.dart';

class LocalStats extends StatefulWidget {
  @override
  _LocalStatsState createState() => _LocalStatsState();
}

class _LocalStatsState extends State<LocalStats> with AutomaticKeepAliveClientMixin {
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
          StateOpt(),
          SizedBox(height: 20),
          StateStats(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
