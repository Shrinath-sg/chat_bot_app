import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/chat_screen.dart';
import 'package:task_app/screens/login.dart';
import 'package:task_app/utils/shared_preference.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';
import 'package:task_app/utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  showPopupMenu(BuildContext context) {
    // final RenderBox renderBox =
    //     _accKey.currentContext?.findRenderObject() as RenderBox;
    // final Size size = renderBox.size;
    // final Offset offset = renderBox.localToGlobal(Offset.zero);
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(5.0, UiHelper.height(context) * 0.75, 0,
          0), //position where you want to show the menu on screen
      items: [
        const PopupMenuItem<String>(value: '1', child: Text('Restaurant')),
        const PopupMenuItem<String>(value: '2', child: Text('Interview')),
        const PopupMenuItem<String>(value: '3', child: Text('Logout')),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        Navigator.pushNamed(context, ChatScreen.routeName);
      } else if (itemSelected == "1") {
        //code ehere
      } else {
        _exitApp(context);
      }
    });
  }

  Future<bool?> _exitApp(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to exit this application?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'NO',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                UiHelper.openLoadingDialog(context, "Logging of..");
                // final gProvider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // await gProvider.logout();
                final bool result =
                    await MySharedPreferences.instance.removeAll();
                await Future.delayed(const Duration(seconds: 2));
                if (result) {
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                  print('Shared pref cleared......');
                }
              } catch (err) {
                Navigator.maybePop(context);
                Fluttertoast.showToast(msg: 'something went wrong!');
              }
            },
            child: const Text(
              'YES',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    // var data = DateTime.now();
    // data.
    // log(data.timeAgo());

    // da

    log(provider.conversationList!.length.toString());
    // log(DateTime.now().toString());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showPopupMenu(context);
            // _offsetPopup();
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Iconsax.messages4),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Start a Conversation',
                style: Styles.headingStyle4(isBold: true, color: Colors.white),
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              // SizedBox(
              //   height: UiHelper.height(context) * 0.03,
              // ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Iconsax.messages4),
                      label: Text(
                        'Conversations',
                        style: Styles.headingStyle4(isBold: true),
                      )),
                ),
              ),
              // List
              Container(
                // height: UiHelper.height(context),

                color: Colors.white,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              left: UiHelper.width(context) * 0.16),
                          child: const Divider(),
                        ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var time = DateTime.tryParse(
                          provider.conversationList![index]!.time ??
                              DateTime.now().toString());
                      // log(data.timeAgo());
                      // DateTime(data);
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        // minVerticalPadding: 5,
                        leading: const Card(
                          child: SizedBox(
                            height: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 25,
                                child: Icon(Iconsax.message_21),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          provider.conversationList![index]!.chatTitle ??
                              'Restaurant',
                          style: Styles.headingStyle4(isBold: true),
                        ),
                        subtitle: Text(
                          provider.conversationList![index]!.chatList!
                                  .isNotEmpty
                              ? provider.conversationList![index]!.chatList!
                                          .last!.userId ==
                                      null
                                  ? 'Bot: ${provider.conversationList![index]!.chatList!.last!.text}'
                                  : 'Human: ${provider.conversationList![index]!.chatList!.last!.text}'
                              : 'Bot: Hello',
                          // 'Bot: ${provider.conversationList![index]!.chatList!.isNotEmpty ? provider.conversationList![index]!.chatList!.last!.userId == null ? "Hello" : provider.conversationList![index]!.chatList!.last!.text : "Hello"}',
                          style: Styles.headingStyle5(),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              time!.timeAgo(),
                              style: Styles.headingStyle6(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Iconsax.tick_circle5,
                                size: 18,
                                color: Colors.greenAccent,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: provider.getConversationList!.length),
              ),
              // tex
            ])),
      ),
    );
  }
}
