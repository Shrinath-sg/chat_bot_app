import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/chat_bubble/receive_bubble.dart';
import 'package:task_app/common_widgets/chat_bubble/send_message.dart';
import 'package:task_app/models/custom_chat_model.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';
import 'package:task_app/utils/unique_id_gernator.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chatscreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = true;
  var messages = [
    const SentMessageScreen(message: "Hello"),
    const ReceivedMessageScreen(message: "Hi, how are you"),
    const SentMessageScreen(message: "I am great how are you doing"),
    const ReceivedMessageScreen(message: "I am also fine"),
    const SentMessageScreen(message: "Can we meet tomorrow?"),
    const ReceivedMessageScreen(
        message: "Yes, of course we will meet tomorrow"),
  ];
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setInitialChat();
    });
    super.initState();
  }

  setInitialChat() async {
    final provider = Provider.of<MyProvider>(context, listen: false);
    await provider.getChatData();
    provider.clearChats();
    provider.capturedChats!.add(CustomChatModel(
      text: 'Hello',
      textId: GUIDGen.generate(),
      time: DateTime.now().toString(),
    ));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    log(jsonEncode(provider.capturedChats));
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: UiHelper.height(context) * 0.08,
                    child: Row(
                      children: [
                        SizedBox(
                          width: UiHelper.width(context) * 0.04,
                        ),
                        Text(
                          'Restaurant',
                          style: Styles.headingStyle3(isBold: true),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 20,
                            ),
                            SizedBox(
                              width: UiHelper.width(context) * 0.04,
                            ),
                            const Icon(
                              Icons.flag,
                              color: AppColors.purple,
                              size: 20,
                            ),
                            SizedBox(
                              width: UiHelper.width(context) * 0.04,
                            ),
                            const Icon(
                              Icons.settings,
                              color: AppColors.purple,
                              size: 20,
                            ),
                            SizedBox(
                              width: UiHelper.width(context) * 0.04,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ListView.builder(
                        // padding: const EdgeInsets.all(20),
                        itemCount: provider.capturedChats!.length,
                        itemBuilder: (context, index) {
                          if (provider.capturedChats![index]!.userId == null) {
                            return ReceivedMessageScreen(
                              message: provider.capturedChats![index]!.text,
                              key: UniqueKey(),
                            );
                          } else {
                            return SentMessageScreen(
                              message: provider.capturedChats![index]!.text,
                              key: UniqueKey(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Material(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: IconButton(
                                onPressed: () async {
                                  final provider = Provider.of<MyProvider>(
                                      context,
                                      listen: false);
                                  if (provider.isChatCompleted) {
                                    Fluttertoast.showToast(
                                        msg: 'chat is completed!!');
                                    return;
                                  }
                                  provider.matchInputSetence(
                                      botSentence: provider.capturedChats!
                                          .elementAt(
                                              provider.capturedChats!.length -
                                                  1)!
                                          .text,
                                      humanSentence: "no");
                                  // var endEleIndex =
                                  //     provider.capturedChats!.length - 1;
                                  // provider.capturedChats!.insert(endEleIndex,
                                  //     ChatModelRestaurant(bot: data!));
                                },
                                icon: const Icon(
                                  Iconsax.microphone_25,
                                  color: AppColors.purple,
                                  size: 30,
                                )),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: IconButton(
                                onPressed: () {
                                  final provider = Provider.of<MyProvider>(
                                      context,
                                      listen: false);
                                  var data = provider.matchInputSetence(
                                      botSentence: "Would you like some water?",
                                      humanSentence: "yes please");
                                  Fluttertoast.showToast(msg: data.toString());
                                },
                                icon: const Icon(
                                  Iconsax.keyboard_open5,
                                  color: AppColors.purple,
                                  size: 28,
                                )),
                          )
                        ],
                      ),
                      color: Colors.grey.shade100,
                    ),
                    height: 100,
                    width: double.infinity,
                  ),
                ],
              ),
      ),
    );
  }
}