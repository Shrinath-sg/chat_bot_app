import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:task_app/screens/chat_screen.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
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
        const PopupMenuItem<String>(child: Text('Restaurant'), value: '1'),
        const PopupMenuItem<String>(child: Text('Interview'), value: '2'),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        Navigator.pushNamed(context, ChatScreen.routeName);
      } else {
        //code here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                separatorBuilder: (context, index) => Padding(
                      padding:
                          EdgeInsets.only(left: UiHelper.width(context) * 0.16),
                      child: const Divider(),
                    ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                      'Restaurant',
                      style: Styles.headingStyle4(isBold: true),
                    ),
                    subtitle: Text(
                      'Bot: Hello',
                      style: Styles.headingStyle5(),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${2 * index + 1} minutes ago',
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
                itemCount: 2),
          ),
          // tex
        ])),
      ),
    );
  }
}
