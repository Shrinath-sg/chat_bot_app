import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/custom_button.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/login.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: UiHelper.height(context) * 0.05,
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.15,
                child: Image.asset('assets/images/talkup.jpg'),
              ),
              Text(
                'Lets Get Started!',
                style: Styles.headingStyle1(),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.08,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: Styles.textFormFieldStyle(
                  hintText: 'Name',
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: Styles.textFormFieldStyle(
                    hintText: 'Phone',
                    labelText: 'Phone',
                    prefixIconData: Iconsax.mobile),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: Styles.textFormFieldStyle(
                  hintText: 'Username or e-mail',
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),
              TextFormField(
                cursorColor: Colors.black,
                onChanged: (value) {
                  provider.checkPassword(value);
                },
                decoration: Styles.textFormFieldStyle(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIconData: Iconsax.key),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),
              LinearProgressIndicator(
                value: provider.strength,
                backgroundColor: Colors.grey[300],
                color: provider.strength! <= 1 / 4
                    ? Colors.red
                    : provider.strength! == 2 / 4
                        ? Colors.yellow
                        : provider.strength! == 3 / 4
                            ? Colors.blue
                            : Colors.green,
                minHeight: 15,
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),

              // The message about the strength of the entered password
              Text(
                provider.displayText ?? '',
                style: Styles.headingStyle4(isBold: true),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.05,
              ),
              CustomButton(
                onPressed: () {},
                text: 'Sign Up',
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Styles.headingStyle4(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, LoginScreen.routeName);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: AppColors.purple,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
