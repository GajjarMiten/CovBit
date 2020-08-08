import 'package:Monks/widgets/my_header.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constant.dart';

class QNA extends StatefulWidget{
  @override
  _QNAState createState() => _QNAState();
}

class _QNAState extends State<QNA> {
  final bot = ChatUser(uid: 'bot');

  final user = ChatUser(uid: 'user');

  List<ChatMessage> convertation = [];

  double sum = 0;

  double major = 0.25;
  double minor = 0.15;
  bool isLodding = true;

  List<ChatMessage> chats;

  String result = "";

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
    chats = [
      ChatMessage(
          text: '2.Do you have fever and fever or any one of this?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: 'fever',
              value: minor.toString(),
            ),
            Reply(
              title: " dry cough",
              value: minor.toString(),
            ),
            Reply(
              title: " tiredness",
              value: minor.toString(),
            ),
            Reply(
              title: " both",
              value: major.toString(),
            ),
            Reply(
              title: "None of above",
              value: 0.toString(),
            ),
          ])),
      ChatMessage(
          text: '3.Do you have aches and pain?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " Yes",
              value: minor.toString(),
            ),
            Reply(
              title: " No",
              value: '0',
            ),
          ])),
      ChatMessage(
        text: "4.Do you have headache or loss of taste or smell?",
        user: bot,
        quickReplies: QuickReplies(values: [
          Reply(
            title: " Headache",
            value: minor.toString(),
          ),
          Reply(
            title: " Loss of taste or smell",
            value: '0',
          ),
          Reply(
            title: " both",
            value: '0.30',
          ),
          Reply(
            title: "None of above",
            value: 0.toString(),
          ),
        ]),
      ),
      ChatMessage(
          text: '5.Do you have inability to wake or stay awake?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(title: " Yes", value: '.10'),
            Reply(
              title: " No",
              value: '0',
            ),
          ])),
      ChatMessage(
          text: '6.Do you have sore throat?',
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " Yes",
              value: '0.15',
            ),
            Reply(
              title: " No",
              value: '0',
            ),
          ])),
      ChatMessage(
          text: "7.Did you ever had any of the following?",
          user: bot,
          quickReplies: QuickReplies(values: [
            Reply(
              title: " Diabetes",
              value: minor.toString(),
            ),
            Reply(
              title: " Hypertension",
              value: minor.toString(),
            ),
            Reply(
              title: " Lung disease",
              value: minor.toString(),
            ),
            Reply(
              title: " Heart disease",
              value: major.toString(),
            ),
            Reply(
              title: " Kidney Disorder",
              value: major.toString(),
            ),
            Reply(
              title: "None of above",
              value: 0.toString(),
            ),
          ])),
      ChatMessage(
          text:
              'Thank you for this self assesment. This will give us heath related data of yours.',
          user: bot,
          quickReplies:
              QuickReplies(values: [Reply(title: 'click here', value: '0')])),
      ChatMessage(
        text: 'Wait a moment we are analyzinng your health status...',
        user: bot,
      ),
    ];
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        convertation.add(ChatMessage(
          text:
              'Hello There! Lets do your self assesment.\nGive me the most appropriet answers.',
          user: bot,
        ));
      });
      isLodding = false;
    }).whenComplete(
      () => Future.delayed(
        Duration(seconds: 1),
        () {
          setState(() {
            convertation.add(
              ChatMessage(
                text: "1. Do you have any of following?",
                user: bot,
                quickReplies: QuickReplies(
                  keepIt: true,
                  values: [
                    Reply(
                      messageId: 'a',
                      title: 'difficulty breathing or shortness of breath',
                      value: major.toString(),
                    ),
                    Reply(
                      messageId: 'a',
                      title: 'chest pain or pressure',
                      value: major.toString(),
                    ),
                    Reply(
                      messageId: 'a',
                      title: 'loss of speech or movement',
                      value: major.toString(),
                    ),
                    Reply(
                      messageId: 'a',
                      title: 'None of above',
                      value: '0',
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  int index = 0;
  bool showResult = false;

  List<Reply> replys = [];

  final controller = ScrollController();
  double offset = 0;
  Color color;

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
    return Material(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Get to know",
              textBottom: "About Covid-19.",
              offset: offset,
            ),
            (isLodding)
                ? Center(
                    child: SizedBox(
                        height: 40,
                        child: LoadingIndicator(
                            indicatorType: Indicator.ballPulseSync)))
                : SizedBox(
                    height: 40,
                  ),
            (!showResult)
                ? DashChat(
                    height: 800,
                    messageBuilder: (r) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFF3383CD),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.35),
                            )
                          ]),
                      child: Text(r.text,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'fedroka')),
                    ),
                    readOnly: true,
                    quickReplyPadding: EdgeInsets.only(left: 40),
                    quickReplyBuilder: (r) => Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF3383CD),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                            )
                          ]),
                      child: Text(r.title,
                          style: TextStyle(
                              color: Color(0xFF3383CD), fontFamily: 'fedroka')),
                    ),
                    onQuickReply: (reply) {
                      sum += double.parse(reply.value);

                      if (!replys.contains(reply)) {
                        replys.add(reply);

                        setState(() {
                          isLodding = true;
                        });
                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            convertation.clear();
                            convertation.add(chats[index]);
                            index++;
                            print(index);
                          });
                        }).then((value) {
                          setState(() {
                            isLodding = false;
                          });
                        });

                        if (index == 7) {
                          setState(() {
                            isLodding = true;
                          });
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              if (sum < 0.7) {
                                result =
                                    "You are safe, You should avoid to going out.";
                                color = Color(0xffc4fb6d);
                              } else if (sum >= 0.70 && sum <= 0.85) {
                                result =
                                    "Your health is quite serious, Please visit the nearest Covid Hospital for checkup";
                                color = Colors.orange;
                              } else {
                                result =
                                    "You have might chance to be COVID postive, Please call the covid help line number for further treatment";
                                color = Color(0xffe84a5f);
                              }
                              isLodding = true;
                              showResult = true;
                            });
                          }).whenComplete(() {
                            setState(() {
                              isLodding = false;
                            });
                          });
                          print(result);
                        }
                      }
                      print(replys);
                      print(sum);
                    },
                    inputDisabled: true,
                    shouldStartMessagesFromTop: true,
                    alwaysShowSend: false,
                    shouldShowLoadEarlier: false,
                    inputTextStyle: TextStyle(color: Colors.black),
                    messages: convertation,
                    user: user,
                    onSend: null,
                  )
                : Center(
                    child: Text(
                      result,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color,
                        fontFamily: 'fedroka',
                        fontSize: 28,
                      ),
                    ),
                  ),
            (showResult)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Symptoms",
                          style: kTitleTextstyle,
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SymptomCard(
                                image: "assets/images/headache.png",
                                title: "Headache",
                                isActive: true,
                              ),
                              SymptomCard(
                                image: "assets/images/caugh.png",
                                title: "Cough",
                                isActive: true,
                              ),
                              SymptomCard(
                                image: "assets/images/fever.png",
                                title: "Fever",
                                isActive: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Prevention", style: kTitleTextstyle),
                        SizedBox(height: 20),
                        PreventCard(
                          text:
                              "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                          image: "assets/images/wear_mask.png",
                          title: "Wear face mask",
                        ),
                        PreventCard(
                          text:
                              "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                          image: "assets/images/wash_hands.png",
                          title: "Wash your hands",
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
